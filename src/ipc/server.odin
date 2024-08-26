package ipc

import "core:path/filepath"
import "core:sys/linux"
import "core:os"
import "core:fmt"

QUEUE_SIZE :: 10
BUFFER_SIZE :: 100

read :: linux.read

mkServer :: proc (pathname: string) -> (
  socketFd: FileDescriptor,
  socketAddr: Sock_Addr_Un,
  err: Errno
) {
  socketAddr = mkUDSAddress(pathname) or_return

  if rmErr: = remove(transmute(string) socketAddr.sin_addr[:]);
    rmErr != .NONE && rmErr != .ENOENT
  {
    err = rmErr
    return
  }

  socketFd = mkUDSSocket() or_return

  bindUDS(socketFd, &socketAddr) or_return
  linux.listen(socketFd, QUEUE_SIZE) or_return

  return
}

serverLoop :: proc (
  socketFd: FileDescriptor,
  address: ^Sock_Addr_Un
) -> Errno {
  skBuffer :[BUFFER_SIZE]u8
  bytesRead :int
  bytesWritten :int

  for {
    fmt.println("Waiting to accept a connection...")

    peerSockFd := acceptUDS(socketFd, address) or_return

    fmt.println("Accepted socket fd: ", peerSockFd)

    for {
      bytesRead = linux.read(
        peerSockFd,
        skBuffer[:]) or_return
      bytesWritten = linux.write(
        FileDescriptor(os.stdout),
        skBuffer[:]) or_return

      fmt.printfln("BytesRead: {}, BytesWritten: {}",
        bytesRead, bytesWritten)
    }
  }

  return .NONE
}

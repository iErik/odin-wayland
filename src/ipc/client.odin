package ipc

import "core:fmt"
import "core:sys/linux"
import "core:os"
import "core:mem"

CLIENT_BUFFER_SIZE :: 100

mkClient :: proc (pathname: string) -> (
  socketFd: FileDescriptor,
  err: Errno
) {
  address := mkUDSAddress(pathname) or_return
  socketFd = mkUDSSocket() or_return
  rawConnect(socketFd, &address) or_return

  return
}

clientLoop :: proc (socketFd: FileDescriptor) -> Errno {
  skBuffer :[CLIENT_BUFFER_SIZE]u8
  bytesRead :int
  bytesWritten :int

  for {
    bytesRead = linux.read(
      FileDescriptor(os.stdin),
      skBuffer[:]) or_return

    bytesWritten = linux.write(
      socketFd,
      skBuffer[:]) or_return

    fmt.printfln("BytesRead: {}, BytesWritten: {}",
      bytesRead, bytesWritten)
  }

  return .NONE
}

package ipc

import "core:strings"
import "core:path/filepath"
import "core:sys/linux"
import "core:mem"
import "core:os"

@(private)
errno_unwrap :: #force_inline proc "contextless" (
  ret: $P,
  $T: typeid
) -> (T, Errno) {
	if ret < 0 {
		default_value: T
		return default_value, Errno(-ret)
	} else {
		return cast(T) ret, Errno(.NONE)
	}
}

remove :: proc (pathname: string) -> Errno {
  cpath, allocErr := strings.clone_to_cstring(pathname)
  if allocErr != nil do return .ENOMEDIUM

  err := linux.unlink(cpath)

  if err != .EISDIR do return err

  linux.rmdir(cpath) or_return

  return .NONE
}

acceptUDS :: proc "contextless" (
  sockFd: FileDescriptor,
  addr: ^Sock_Addr_Un,
  sockFlags: linux.Socket_FD_Flags = {}
) -> (
  peerSockFd: FileDescriptor,
  err: Errno
)
{
  addrLen: i32 = size_of(Sock_Addr_Un)
  ret := linux.syscall(
    linux.SYS_accept4,
    sockFd,
    addr,
    &addrLen,
    transmute(int) sockFlags
  )

  return errno_unwrap(ret, FileDescriptor)
}

rawConnect :: proc "contextless" (
  sockFd: FileDescriptor,
  addr: ^Sock_Addr_Un
) -> Errno {
  ret := linux.syscall(
    linux.SYS_connect,
    sockFd,
    addr,
    size_of(Sock_Addr_Un))

  return Errno(-ret)
}

bindUDS :: proc "contextless" (
  sockFd: FileDescriptor,
  addr: ^Sock_Addr_Un
) -> Errno
{
  ret := linux.syscall(
    linux.SYS_bind,
    sockFd,
    addr,
    size_of(Sock_Addr_Un)
  )

  return Errno(-ret)
}

mkUDSAddress :: proc (pathname: string) -> (
  address: Sock_Addr_Un,
  err: Errno
) {
  fullpath := filepath.join({
    os.get_env(RUNTIME_DIR_ENV),
    pathname
  })

  if len(fullpath) > UDS_ADDR_SIZE -1 {
    err = .EFAULT
    return
  }

  count := min(len(fullpath), UDS_ADDR_SIZE - 1)
  address = Sock_Addr_Un{
    sin_family = linux.Address_Family.UNIX,
  }

  mem.copy(&address.sin_addr[0], raw_data(fullpath), count)
  address.sin_addr[count + 1] = 0

  return
}

mkUDSSocket :: proc () -> (
  socketFd: FileDescriptor,
  err: Errno
) {
  socketFd = linux.socket(
    linux.Address_Family.UNIX,
    linux.Socket_Type.STREAM,
    {},
    linux.Protocol.HOPOPT) or_return

  return
}

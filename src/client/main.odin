package client

import "core:fmt"
import "core:path/filepath"
import "core:os"

import "../ipc"

/*
getDisplayPath :: proc () -> Sock_Addr_Un {
  xdgRuntimeDir := os.get_env(RUNTIME_DIR_ENV)
  wlDisplayName := os.get_env(DISPLAY_PATH_ENV)

  return ipc.mkUDSAddress(filepath.join({
    xdgRuntimeDir,
    wlDisplayName
  }))
}
*/

main :: proc () {
  socket, err := ipc.mkClient("serverTest")

  if err != nil {
    fmt.println("Client creation error: ", err)
  }

  fmt.println("Client socket FD: ", socket)

  err = ipc.clientLoop(socket)

  if err != nil {
    fmt.println("Client loop error")
  }
}

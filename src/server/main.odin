package server

import "core:fmt"
import "core:path/filepath"
import "core:os"

import "pkgs:ipc"

/*
getDisplayPath :: proc () -> Sock_Addr_Un {
  xdgRuntimeDir := os.get_env(ipc.RUNTIME_DIR_ENV)
  wlDisplayName := os.get_env(ipc.DISPLAY_PATH_ENV)

  return ipc.mkUDSAddress(filepath.join({
    xdgRuntimeDir,
    wlDisplayName
  }))
}
*/

main :: proc () {
  server, address, err := ipc.mkServer("serverTest")

  if err != nil {
    fmt.println("Server creation error")
  }

  err = ipc.serverLoop(server, &address)

  if err != nil {
    fmt.println("Server loop error")
  }
}

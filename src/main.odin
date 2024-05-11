package test

import "core:fmt"

import "wayland"

main :: proc () {
  something := wayland.wl_list{}
  list := wayland.wl_list{}


  array := wayland.wl_array{
    size = 3,
    alloc = 3,
  }

  wayland.wl_list_init(&something)
  wayland.wl_list_insert(&something, &list)
  wayland.wl_array_init(&array)

  hey := wayland.wl_list_length(&something)

  fmt.println("check this: ", hey, array, something)
}

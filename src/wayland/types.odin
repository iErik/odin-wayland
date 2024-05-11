package wayland

import "core:c"
#assert(size_of(int)  == size_of(c.long))
#assert(size_of(uint) == size_of(c.ulong))
#assert(size_of(i32)  == size_of(c.int))
#assert(size_of(u32)  == size_of(c.uint))

pid_t :: i32
gid_t :: u32
uid_t :: u32

/* ---- wayland-util.h --------------------------------------- */
/* ----------------------------------------------------------- */

wl_fixed_t :: distinct i32

wl_dispatcher_func_t :: #type proc "c" (
  user_data: rawptr,
  target: rawptr,
  opcode: u32,
  msg: ^wl_message,
  args: [^]wl_argument
) -> i32

wl_log_func_t :: #type proc "c" {
  fmt: cstring,
  args: [^]c.va_list
}

wl_iterator_result :: enum {
  WL_ITERATOR_STOP,
  WL_ITERATOR_CONTINUE
}

wl_argument :: struct #raw_union {
  i: i32,
  u: u32,
  f: wl_fixed_t,
  s: cstring,
  o: ^wl_object,
  n: u32,
  a: ^wl_array,
  h: i32
}

wl_message :: struct {
  name:      cstring,
  signature: cstring,
  types:     [^]^wl_interface
}

wl_interface :: struct {
  name:         cstring,
  version:      i32,
  method_count: i32,
  event_count:  i32,
  methods:      ^wl_message,
  events:       ^wl_message
}

wl_list :: struct {
  prev: ^wl_list,
  next: ^wl_list
}

wl_array :: struct {
  size: uint,
  alloc: uint,
  data: rawptr
}

/* ---- wayland-server.h ------------------------------------- */
/* ----------------------------------------------------------- */

wl_client :: struct { }

wl_object :: struct {
  interface: ^wl_interface,
	implementation: rawptr,
	id: u32
}

wl_resource :: struct {
  object: wl_object,
  destroy: wl_resource_destroy_func_t,
  link: wl_list,
  destroy_signal: wl_signal,
  client: ^wl_client,
  data: rawptr
}

/* ---- wayland-server-private.h ----------------------------- */
/* ----------------------------------------------------------- */

wl_priv_signal :: struct {
  listener_list: wl_list,
  emit_list: wl_list
}

/* ---- wayland-server-core.h -------------------------------- */
/* ----------------------------------------------------------- */

WL_EVENT_READABLE :: 0x01
WL_EVENT_WRITABLE :: 0x02
WL_EVENT_HANGUP   :: 0x04
WL_EVENT_ERROR    :: 0x08

wl_event_loop_fd_func_t :: #type proc "c" (
  fd: i32,
  mask: u32,
  data: rawptr
) -> i32

wl_event_loop_timer_func_t :: #type proc "c" (
  data: rawptr
) -> i32

wl_event_loop_signal_func_t :: #type proc "c" (
  signal_number: i32,
  data: rawptr
) -> i32

wl_event_loop_idle_func_t :: #type proc "c" (data: rawptr) ---

wl_resource_destroy_func_t :: #type proc "c" (
  resource: ^wl_resource
)

wl_notify_func_t :: #type proc "c" (
  listener: ^wl_listener,
  data: rawptr
)

wl_global_bind_func_t :: #type proc "c" (
  client: ^wl_client,
  data: rawptr,
  version: u32,
  id: u32
)

wl_display_global_filter_func_t :: #type proc "c" (
  client: ^wl_client,
  global: ^wl_global,
  data: rawptr
) -> bool

wl_client_for_each_resource_iterator_func_t :: #type proc "c" (
  resource: ^wl_resource,
  user_data: rawptr
) -> wl_iterator_result

wl_user_data_destroy_func_t :: #type proc "c" (data: rawptr)

wl_resource_destroy_func_t :: #type proc "c" (
  resource: ^wl_resource
)

wl_protocol_logger_func_t :: #type proc "c" (
  user_data: rawptr,
  direction: wl_protocol_logger_type,
  #by_ptr message: wl_protocol_logger_message
)

wl_protocol_logger_type :: enum {
  WL_PROTOCOL_LOGGER_REQUEST,
  WL_PROTOCOL_LOGGER_EVENT
}

wl_protocol_logger_message :: struct {
  resource: ^wl_resource,
  message_opcode: i32,
  message: ^wl_message,
  arguments_count: i32,
  arguments: ^wl_argument
}

wl_listener :: struct {
  list: wl_list,
  notify: wl_notify_func_t
}

wl_signal :: struct {
  listener_list: wl_list
}

/* ---- wayland-private.h ------------------------------------ */
/* ----------------------------------------------------------- */

WL_MAP_SERVER_SIDE         :: 0
WL_MAP_CLIENT_SIDE         :: 1
WL_SERVER_ID_START         :: 0xff000000
WL_MAP_MAX_OBJECTS         :: 0x00f00000
WL_CLOSURE_MAX_ARGS        :: 20
WL_BUFFER_DEFAULT_SIZE_POT :: 12
WL_BUFFER_DEFAULT_MAX_SIZE :: (1 << WL_BUFFER_DEFAULT_SIZE_POT)

wl_arg_type :: enum {
  WL_ARG_INT    = 'i',
  WL_ARG_UINT   = 'u',
  WL_ARG_FIXED  = 'f',
  WL_ARG_STRING = 's',
  WL_ARG_OBJECT = 'o',
  WL_ARG_NEW_ID = 'n',
  WL_ARG_ARRAY  = 'a',
  WL_ARG_FD     = 'h'
}

wl_map_entry_flags :: enum {
  WL_MAP_ENTRY_LEGACY = (1 << 0),
  WL_MAP_ENTRY_ZOMBIE = (1 << 0)
}

wl_closure_invoke_flag :: enum {
  WL_CLOSURE_INVOKE_CLIENT = (1 << 0),
  WL_CLOSURE_INVOKE_SERVER = (1 << 1)
}

wl_map :: struct {
  client_entries: wl_array,
  server_entries: wl_array,
  side: u32,
  free_list: u32
}

wl_closure :: struct {
  count: i32,
  message: ^wl_message,
  opcode: u32,
  sender_id: u32,
  args: [WL_CLOSURE_MAX_ARGS]wl_argument,
  link: wl_list,
  proxy: ^wl_proxy,
  extra: [0]wl_array
}

argument_details :: struct {
  type: wl_arg_type,
  nullable: i32
}

wl_iterator_func_t :: #type proc "c" (
  element: rawptr,
  data: rawptr,
  flags: u32
) -> wl_iterator_result

/* ---- wayland-client.h ------------------------------------- */
/* ----------------------------------------------------------- */

wl_proxy :: struct {
  object: wl_object,
  display: ^wl_display,
	queue: ^wl_event_queue,
	flags: u32,
  refCount: i32,
	user_data: rawptr,
	dispatcher: wl_dispatcher_func_t,
	version: u32,
	tag: cstring,
  queue_link: wl_list
}

wl_display :: struct { }

wl_event_queue :: struct {  }


package wayland

foreign import wayland {
  "system:wayland-client",
  "system:wayland-server",
  "system:wayland-cursor",
  "system:wayland-egl"
}

// TODO: STATIC INLINE FUNCTIONS

@(default_calling_convention="c")
foreign wayland {

  /* ---- wayland-util.h --------------------------------------*/
  /* ----------------------------------------------------------*/

  wl_list_init   :: proc (list: ^wl_list) ---
  wl_list_insert :: proc (list: ^wl_list, elm: ^wl_list) ---
  wl_list_remove :: proc (elm: ^wl_list) ---
  wl_list_length :: proc (list: ^wl_list) -> i32 ---
  wl_list_empty  :: proc (list: ^wl_list) -> i32 ---
  wl_list_insert_list :: proc (
    list: ^wl_list,
    other: ^wl_list
    ) ---
  wl_array_init    :: proc (array: ^wl_array) ---
  wl_array_release :: proc (array: ^wl_array) ---
  wl_array_add     :: proc (
    array: ^wl_array,
    size: uint
    ) -> rawptr ---
  wl_array_copy    :: proc (
    array: ^wl_array,
    source: ^wl_array
    ) -> i32 ---
  wl_fixed_to_double :: proc (f: i32) -> f64 ---
  wl_fixed_to_int    :: proc (d: f64) -> i32 ---
  wl_fixed_from_int  :: proc (i: i32) -> i32 ---

  /* ---- wayland-server.h ------------------------------------*/
  /* ----------------------------------------------------------*/

  @(deprecated="")
  wl_client_add_resource   :: proc (
    client: ^wl_client,
    resource: ^wl_resource
    ) -> u32 ---
  @(deprecated="")
  wl_client_add_object     :: proc (
    client: ^wl_client,
    interface: ^wl_interface,
    implementation: rawptr,
    id: u32,
    data: rawptr
    ) -> ^wl_resource ---
  @(deprecated="")
  wl_client_new_object     :: proc (
    client: ^wl_client,
    interface: ^wl_interface,
    implementation: rawptr,
    data: rawptr
    ) -> ^wl_resource ---
  wl_display_add_global    :: proc (
    display: ^wl_display,
    interface: ^wl_interface,
    data: rawptr,
    bind: wl_global_bind_func
    ) -> ^wl_global ---
  @(deprecated="")
  wl_display_remove_global :: proc (
    display: ^wl_display,
    global: wl_global
    ) ---

  /* ---- wayland-server-private.h ----------------------------*/
  /* ----------------------------------------------------------*/

  wl_priv_signal_init       :: proc (signal: ^wl_priv_signal) ---
  wl_priv_signal_add        :: proc (
    signal: ^wl_priv_signal,
    listener: ^wl_listener
    ) ---
  wl_priv_signal_get        :: proc (
    signal: ^wl_priv_signal,
    notify: wl_notify_func_t
    ) -> ^wl_listener ---
  wl_priv_signal_emit       :: proc (
    signal: wl_priv_signal,
    data: rawptr
    ) ---
  wl_priv_signal_final_emit :: proc (
    signal: ^wl_priv_signal,
    data: rawptr
    ) ---

  /* ---- wayland-server-core.h -------------------------------*/
  /* ----------------------------------------------------------*/

  wl_event_loop_create :: proc () -> ^wl_event_loop ---
  wl_event_loop_destroy :: proc (loop: ^wl_event_loop) ---
  wl_event_loop_add_fd :: proc (
    loop: ^wl_event_loop,
    fd: i32,
    mask: u32,
    func: wl_event_loop_fd_func_t,
    data: rawptr
    ) -> ^wl_event_source ---
  wl_event_source_fd_update :: proc (
    source: ^wl_event_source,
    mask: u32
    ) -> i32 ---
  wl_event_loop_add_timer :: proc (
    loop: ^wl_event_loop,
    signal_number: i32,
    func: wl_event_loop_signal_func_t,
    data: rawptr
    ) -> ^wl_event_source ---
  wl_event_loop_add_signal :: proc (
    loop: ^wl_event_loop,
    signal_number: i32,
    func: wl_event_loop_signal_func_t,
    data: rawptr
    ) -> ^wl_event_source ---
  wl_event_source_timer_update :: proc (
    source: ^wl_event_source,
    ms_delay: i32
    ) -> i32 ---
  wl_event_source_remove :: proc (
    source: ^wl_event_source
    ) -> i32 ---
  wl_event_source_check :: proc (
    source: ^wl_event_source
    ) ---
  wl_event_loop_dispatch :: proc (
    loop: ^wl_event_loop,
    timeout: i32
    ) -> i32 ---
  wl_event_loop_dispatch_idle :: proc (loop: ^wl_event_loop) ---
  wl_event_loop_add_idle :: proc (
    loop: ^wl_event_loop,
    func: wl_event_loop_idle_func_t,
    data: rawptr
    ) -> ^wl_event_source ---
  wl_event_loop_get_fd :: proc (loop: wl_event_loop) -> i32 ---
  wl_event_loop_add_destroy_listener :: proc (
    loop: ^wl_event_loop,
    listener: ^wl_listener
    ) ---
  wl_event_loop_get_destroy_listener :: proc (
    loop: ^wl_event_loop,
    notify: wl_notify_func_t
    ) -> ^wl_listener ---
  wl_display_create :: proc () -> ^wl_display ---
  wl_display_destroy :: proc (display: ^wl_display) ---
  wl_display_get_event_loop :: proc (
    display: ^wl_display
    ) -> ^wl_event_loop ---
  wl_display_add_socket :: proc (
    display: ^wl_display,
    name: cstring
    ) -> i32 ---
  wl_display_add_socket_auto :: proc (
    display: ^wl_display
    ) -> string ---
  wl_display_add_socket_fd :: proc (
    display: ^wl_display,
    sock_fd: i32
    ) -> i32 ---
  wl_display_terminate :: proc (display: ^wl_display) ---
  wl_display_run :: proc (display: ^wl_display) ---
  wl_display_flush_clients :: proc (display: ^wl_display) ---
  wl_display_destroy_clients :: proc(display: ^wl_display)
  wl_display_set_default_max_buffer_size :: proc (
    display: ^wl_display,
    max_buffer_size: uint
    ) ---
  wl_display_get_serial :: proc (display: ^wl_display) -> u32 ---
  wl_display_next_serial :: proc (
    display: ^wl_display
    ) -> u32 ---
  wl_display_add_destroy_listener :: proc (
    display: ^wl_display,
    listener: ^wl_listener
    ) ---
  wl_display_add_client_created_listener :: proc (
    display: ^wl_display,
    listener: ^wl_listener
    ) ---
  wl_display_get_destroy_listener :: proc (
    display: ^wl_display,
    notify: wl_notify_func_t
    ) -> ^wl_listener ---
  wl_global_create :: proc (
    display: ^wl_display,
    interface: ^wl_interface,
    version: i32,
    data: rawptr,
    bind: wl_global_bind_func_t
    ) -> ^wl_global ---
  wl_global_remove :: proc (global: ^wl_global) ---
  wl_global_destroy :: proc (global: ^wl_global) ---
  wl_display_set_global_filter :: proc (
    display: ^wl_display,
    filter: wl_display_global_filter_func_t,
    data: rawptr
    ) ---
  wl_global_get_interface :: proc (
    global: ^wl_global
    ) -> ^wl_interface ---
  wl_global_get_name :: proc (
    global: ^wl_global,
    client: ^wl_client
    ) -> u32 ---
  wl_global_get_version :: proc (
    global: ^wl_global
    ) -> u32 ---
  wl_global_get_display :: proc (
    global: ^wl_global
    ) -> ^wl_display ---
  wl_global_get_user_data :: proc (
    wl_global: ^wl_global
    ) -> rawptr ---
  wl_global_set_user_data :: proc (
    global: ^wl_global,
    data: rawptr
    ) -> rawptr ---
  wl_client_create :: proc (
    display: ^wl_display,
    fd: i32
    ) -> ^wl_client ---
  wl_display_get_client_list :: proc (
    display: ^wl_display
    ) -> ^wl_list ---
  wl_client_get_link :: proc (client: ^wl_client) -> ^wl_list ---
  wl_client_from_link :: proc (link: ^wl_list) -> ^wl_client ---
  wl_client_destroy :: proc (client: ^wl_client) ---
  wl_client_flush :: proc (client: ^wl_client) ---
  // TODO: Revise types
  wl_client_get_credentials :: proc (
    client: ^wl_client,
    pid: [^]pid_t,
    uid: [^]uid_t,
    gid: [^]gid_t
    ) ---
  wl_client_get_fd :: proc (client: ^wl_client) -> i32 ---
  wl_client_add_destroy_listener :: proc (
    client: ^wl_client,
    listener: ^wl_listener
    ) ---
  wl_client_get_destroy_listener :: proc (
    client: ^wl_client,
    listener: ^wl_listener
    ) ---
  wl_client_add_destroy_late_listener :: proc (
    client: ^wl_client,
    listener: ^wl_listener
    ) ---
  wl_client_get_destroy_late_listener :: proc (
    client: ^wl_client,
    notify: wl_notify_func_t
    ) -> ^wl_listener ---
  wl_client_get_object :: proc (
    client: ^wl_client,
    id: u32
    ) -> ^wl_resource ---
  wl_client_post_no_memory :: proc (client: ^wl_client) ---
  wl_client_post_implementation_error :: proc (
    client: ^wl_client,
    msg: cstring,
    #c_vararg args: ..any
    ) ---
  wl_client_add_resource_created_listener :: proc (
    client: ^wl_client,
    listener: ^wl_listener
    ) ---
  wl_client_for_each_resource :: proc (
    client: ^wl_client,
    iterator: wl_client_for_each_resource_iterator_func_t,
    user_data: rawptr
    ) ---
  wl_client_set_user_data :: proc (
    client: ^wl_client,
    data: rawptr,
    dtor: wl_user_data_destroy_func_t
    ) ---
  wl_client_get_user_data :: proc (
    client: ^wl_client
    ) -> rawptr ---
  wl_client_set_max_buffer_size :: proc (
    client: ^wl_client,
    max_buffer_size: uint
    ) ---
  wl_signal_emit_mutable :: proc (
    signal: ^wl_signal,
    data: rawptr
    ) ---
  wl_resource_post_event :: proc (
    resource: ^wl_resource,
    opcode: u32,
    #c_vararg args: ..any
    ) ---
  wl_resource_post_event_array :: proc (
    resource: ^wl_resource,
    opcode: u32,
    args: [^]wl_argument
    ) ---
  wl_resource_queue_event :: proc (
    resource: ^wl_resource,
    opcode: u32,
    #c_vararg args: ..any
    ) ---
  wl_resource_queue_event_array :: proc (
    resource: ^wl_resource,
    opcode: u32,
    args: [^]wl_argument
    ) ---
  wl_resource_post_error :: proc (
    resource: ^wl_resource,
    code: u32,
    msg: cstring,
    #c_vararg args ..any
    ) ---
  wl_resource_post_no_memory :: proc (
    resource: ^wl_resource
    ) ---
  wl_client_get_display :: proc (
    client: ^wl_client
    ) -> ^wl_display ---
  wl_resource_create :: proc (
    client: ^wl_client,
    #by_ptr interface: wl_interface,
    version: i32,
    id: i32
    ) -> ^wl_resource ---
  wl_resource_set_implementation :: proc (
    resource: ^wl_resource,
    implementation: rawptr,
    data: rawptr,
    destroy: wl_resource_destroy_func_t
    ) ---
  wl_resource_set_dispatcher :: proc (
    resource: ^wl_resource,
    dispatcher: wl_dispatcher_func_t,
    implementation: rawptr,
    data: rawptr,
    destroy: wl_resource_destroy_func_t
    ) ---
  wl_resource_destroy :: proc (resource: ^wl_resource) ---
  wl_resource_get_id :: proc (resource: ^wl_resource) -> u32 ---
  wl_resource_get_link :: proc (
    resource: ^wl_resource
    ) -> ^wl_list ---
  wl_resource_from_link :: proc (
    resource: ^wl_list
    ) -> ^wl_resource ---
  wl_resource_find_for_client :: proc (
    list: ^wl_list,
    #by_ptr client: wl_client
    ) -> ^wl_resource ---
  wl_resource_get_client :: proc (
    resource: ^wl_resource
    ) -> ^wl_client ---
  wl_resource_set_user_data :: proc (
    resource: ^wl_resource,
    data: rawptr
    ) ---
  wl_resource_get_user_data :: proc (
    resource: ^wl_resource
    ) -> rawptr ---
  wl_resource_get_version :: proc (
    resource: ^wl_resource
    ) -> i32 ---
  wl_resource_set_destructor :: proc (
    resource: ^wl_resource,
    destroy: wl_resource_destroy_func_t
    ) ---
  wl_resource_instance_of :: proc (
    resource: ^resource,
    #by_ptr interface: wl_interface,
    implementation: rawptr
    ) -> i32 ---
  wl_resource_get_class :: proc (
    resource: ^wl_resource
    ) -> string ---
  wl_resource_add_destroy_listener :: proc (
    resource: ^wl_resource,
    listener: ^wl_listener
    ) ---
  wl_resource_get_destroy_listener :: proc (
    resource: ^wl_resource,
    notify: wl_notify_func_t
    ) -> ^wl_listener ---
  wl_shm_buffer_get :: proc (
    resource: ^wl_resource
    ) -> ^wl_shm_buffer ---
  wl_shm_buffer_begin_access :: proc (
    buffer: ^wl_shm_buffer
    ) ---
  wl_shm_buffer_end_access :: proc (
    buffer: ^wl_shm_buffer
    ) ---
  wl_shm_buffer_get_data :: proc (
    buffer: ^wl_shm_buffer
    ) -> rawptr ---
  wl_shm_buffer_get_stride :: proc (
    buffer: ^wl_shm_buffer
    ) -> i32 ---
  wl_shm_buffer_get_format :: proc (
    buffer: ^wl_shm_buffer
    ) -> u32 ---
  wl_shm_buffer_get_width :: proc (
    buffer: ^wl_shm_buffer
    ) -> i32 ---
  wl_shm_buffer_get_height :: proc (
    buffer: ^wl_shm_buffer
    ) -> i32 ---
  wl_shm_buffer_ref_pool :: proc (
    buffer: ^wl_shm_buffer
    ) -> ^wl_shm_buffer ---
  wl_shm_pool_unref :: proc (
    pool: ^wl_shm_pool
    ) ---
  wl_display_init_shm :: proc (
    display: ^wl_display
    ) -> i32 ---
  // TODO: Check implementation and return type
  wl_display_add_shm_format :: proc (
    display: ^wl_display,
    format: u32
    ) -> [^]u32 ---
  @(deprecated="")
  wl_shm_buffer_create :: proc (
    client: ^wl_client,
    id: u32,
    width: i32,
    height: i32,
    stride: i32,
    format: u32
    ) -> ^wl_shm_buffer ---
  wl_log_set_handler_server :: proc (handler: wl_log_func_t) ---
  wl_display_add_protocol_logger :: proc (
    display: ^wl_display,
    func: wl_protocol_logger_func_t,
    user_data: rawptr
    ) -> ^wl_protocol_logger ---
  wl_protocol_logger_destroy :: proc (
    logger: ^wl_protocol_logger
    ) ---

  /* ---- wayland-private.h -----------------------------------*/
  /* ----------------------------------------------------------*/

  wl_interface_equal :: proc (
    #by_ptr iface1: wl_interface,
    #by_ptr iface2: wl_interface
    ) -> i32 ---
  wl_map_init :: proc (mapArg: ^wl_map, side: u32) ---
  wl_map_release :: proc (mapArg: ^wl_map) ---
  wl_map_insert_new :: proc (
    aMap: ^wl_map,
    flags: u32,
    data: rawptr
    ) -> u32 ---
  wl_map_insert_at :: proc (
    aMap: ^wl_map,
    flags: u32,
    i: u32,
    data: rawptr
    ) -> i32 ---
  wl_map_reserve_new :: proc (
    aMap: ^wl_map,
    i: u32
    ) -> i32 ---
  wl_map_remove :: proc (aMap: ^wl_map, i: u32) ---
  wl_map_lookup :: proc (aMap: ^wl_map, i: u32) -> rawptr ---
  wl_map_lookup_flags :: proc (aMap: ^wl_map, i: u32) -> u32 ---
  wl_map_for_each :: proc (
    aMap: ^wl_map,
    func: wl_iterator_func_t,
    data: rawptr
    ) ---
  wl_connection_create :: proc (
    fd: i32,
    max_buffer_size: uint
    ) -> ^wl_connection ---
  wl_connection_destroy :: proc (
    connection: ^wl_connection
    ) -> i32 ---
  wl_connection_copy :: proc (
    connection: ^wl_connection,
    data: rawptr,
    size: uint
    ) ---
  wl_connection_consume :: proc (
    connection: ^wl_connection,
    size: uint
    ) ---
  wl_connection_flush :: proc (
    connection: ^wl_connection
    ) -> i32 ---
  wl_connection_pending_input :: proc (
    connection: ^wl_connection
    ) -> u32 ---
  wl_connection_read :: proc (
    connection: ^wl_connection
    ) -> i32 ---
  wl_connection_write :: proc (
    connection: ^wl_connection,
    data: rawptr,
    count: u32
    ) -> i32 ---
  wl_connection_queue :: proc (
    connection: ^wl_connection,
    data: rawptr,
    count: u32
    ) -> i32 ---
  wl_connection_get_fd :: proc (
    connection: ^wl_connection
    ) -> i32 ---
  get_next_argument :: proc (
    signature: cstring,
    #by_ptr details: argument_details
    ) -> string ---
  arg_count_for_signature :: proc (signature: cstring) -> i32 ---
  wl_message_count_arrays :: proc (
    #by_ptr message: wl_message
    ) -> i32 ---
  wl_message_get_since :: proc (
    #by_ptr message: wl_message
    ) -> i32 ---
  // TODO: revise va_list argument
  wl_argument_from_va_list :: proc (
    signature: cstring,
    #by_ptr args: wl_argument,
    count: i32,
    ap: c.va_list
    ) ---
  wl_closure_marshal :: proc (
    #by_ptr sender: wl_object,
    opcode: u32,
    #by_ptr args: wl_argument,
    #by_ptr message: wl_message
    ) -> ^wl_closure ---
  wl_closure_vmarshal :: proc (
    #by_ptr sender: wl_object,
    opcode: u32,
    ap: c.va_list,
    #by_ptr message: wl_message
    ) -> ^wl_closure ---
  wl_connection_demarshal :: proc (
    connection: ^wl_connection,
    size: u32,
    objects: ^wl_map,
    #by_ptr message: wl_message
    ) -> ^wl_closure ---
  wl_object_is_zombie :: proc (
    aMap: ^wl_map,
    id: u32
    ) -> bool ---
  wl_closure_lookup_objects :: proc (
    closure: ^wl_closure,
    objects: ^wl_map
    ) -> i32 ---
  wl_closure_invoke :: proc (
    closure: ^wl_closure,
    flags: u32,
    target: ^wl_object,
    opcode: u32,
    data: rawptr
    ) ---
  wl_closure_dispatch :: proc (
    closure: ^wl_closure,
    flags: u32,
    target: ^wl_object,
    opcode: u32,
    data: rawptr
    ) ---
  wl_closure_send :: proc (
    closure: ^wl_closure,
    connection: ^wl_connection
    ) -> i32 ---
  wl_closure_queue :: proc (
    closure: ^wl_closure,
    connection: ^wl_connection
    ) -> i32 ---
  // TODO: Revise C function pointer
  wl_closure_print :: proc (
    closure: ^wl_closure,
    target: ^wl_object,
    send: i32,
    discarded: i32,
    #by_ptr n_parse: proc (arg: ^wl_argument) -> u32,
    queue_name: cstring
    ) ---
  wl_closure_destroy :: proc (closure: ^wl_closure) ---
  wl_log :: proc (fmt: cstring, #c_vararg args: ..any) ---
  wl_abort :: proc (fmt: cstring, #c_vararg args: ..any) ---
  wl_display_get_additional_shm_formats :: proc (
    display: ^wl_display
    ) -> ^wl_array ---
  wl_connection_close_fds_in :: proc (
    connection: ^wl_connection,
    max: i32
    ) ---
  wl_connection_set_max_buffer_size :: proc (
    connection: ^wl_connection,
    max_buffer_size: uint
    ) ---

  /* ---- wayland-os.h ----------------------------------------*/
  /* ----------------------------------------------------------*/

  wl_os_socket_cloexec :: proc (
    domain: i32,
    type: i32,
    protocol: i32
    ) -> i32 ---
  wl_os_socket_peercred :: proc (
    sockfd: i32,
    uid: ^uid_t,
    gid: ^gid_t,
    pid: ^pid_t
    ) -> i32 ---
  wl_os_dupfd_cloexec :: proc (fd: i32, minfd: i32) -> i32 ---
  wl_os_recvmsg_cloexec :: proc (
    sockfd: i32,
    msg: ^linux.Msg_Hdr,
    flags: i32,
    ) -> int ---
  wl_os_epoll_create_cloexec :: proc () -> i32 ---
  wl_os_accept_cloexec :: proc (
    sockfd: i32,
    addr: ^sockaddr,
    addrlen: ^socklen_t
    ) -> i32 ---
  wl_os_mremap_maymove :: proc (
    fd: i32,
    old_data: rawptr,
    old_size: uint,
    new_size: uint,
    prot: i32,
    flags: i32
    ) -> rawptr ---

  /* ---- wayland-client-core.h -------------------------------*/
  /* ----------------------------------------------------------*/

  wl_event_queue_destroy :: proc (queue: ^wl_event_queue) ---
  wl_proxy_marshal_flags :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    #by_ptr interface: wl_interface,
    version: u32,
    flags: u32,
    #c_varargs args: ..any
    ) -> ^wl_proxy ---
  wl_proxy_marshal_array_flags :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    #by_ptr interface: ^wl_interface,
    version: u32,
    flags: u32,
    args: [^]wl_argument
    ) -> ^wl_proxy ---
  wl_proxy_marshal :: proc (
    p: ^wl_proxy,
    opcode: u32,
    #c_varargs args: ..any
    ) ---
  wl_proxy_marshal_array :: proc (
    p: ^wl_proxy,
    opcode: u32,
    args: [^]wl_argument
    ) ---
  wl_proxy_create :: proc (
    factory: ^wl_proxy,
    #by_ptr interface: wl_interface
    ) -> ^wl_proxy ---
  wl_proxy_create_wrapper :: proc (proxy: rawptr) -> rawptr ---
  wl_proxy_wrapper_destroy :: proc (proxy_wrapper: rawptr) ---
  wl_proxy_marshal_constructor :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    #by_ptr interface: wl_interface,
    #c_varargs args: ..any
    ) -> ^wl_proxy ---
  wl_proxy_marshal_constructor_versioned :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    #by_ptr interface: wl_interface,
    version: u32,
    #c_varargs args: ..any
    ) -> ^wl_proxy ---
  wl_proxy_marshal_array_constructor :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    args: [^]wl_argument,
    #by_ptr interface: wl_interface
    ) -> ^wl_proxy ---
  wl_proxy_marshal_array_constructor_versioned :: proc (
    proxy: ^wl_proxy,
    opcode: u32,
    args: [^]wl_arguments,
    #by_ptr interface: wl_interface,
    version: u32
    ) -> ^wl_proxy ---
  wl_proxy_destroy :: proc (proxy: ^wl_proxy) ---
  // TODO: Review function pointer arg
  wl_proxy_add_listener :: proc (
    proxy: ^wl_proxy,
    implementation: proc (),
    data: rawptr
    ) -> i32 ---
  wl_proxy_get_listener :: proc (proxy: ^wl_proxy) -> rawptr ---
  wl_proxy_add_dispatcher :: proc (
    proxy: ^wl_proxy,
    dispatcher_func: wl_dispatcher_func_t,
    dispatcher_data: rawptr,
    data: rawptr
    ) -> i32 ---
  wl_proxy_set_user_data :: proc (
    proxy: ^wl_proxy,
    user_data: rawptr
    ) ---
  wl_proxy_get_user_data :: proc (prox: ^wl_proxy) -> rawptr ---
  wl_proxy_get_version :: proc (proxy: ^wl_proxy) -> u32 ---
  wl_proxy_get_id :: proc (proxy: ^wl_proxy) -> u32 ---
  // TODO: tag is a `const char * const *` (bismillah)
  wl_proxy_set_tag :: proc (
    proxy: ^wl_proxy,
    tag: ^cstring
    ) ---
  wl_proxy_get_tag :: proc (proxy: ^proxy, tag: ^cstring) ---
  wl_proxy_get_class :: proc (proxy: ^wl_proxy) -> string
  wl_proxy_get_display :: proc (
    proxy: ^wl_proxy
    ) -> ^wl_display ---
  wl_proxy_set_queue :: proc (
    proxy: ^wl_proxy,
    queue: ^wl_event_queue
    ) ---
  wl_proxy_get_queue :: proc (
    #by_ptr proxy: wl_proxy
    ) -> ^wl_event_queue ---
  wl_event_queue_get_name :: proc (
    #by_ptr queue: wl_event_queue
    ) -> cstring ---
  wl_display_connect :: proc (name: cstring) -> ^wl_display ---
  wl_display_connect_to_fd :: proc (fd: i32) -> ^wl_display ---
  wl_display_disconnect :: proc (display: ^wl_display) ---
  wl_display_get_fd :: proc (display: ^wl_display) -> i32 ---
  wl_display_dispatch :: proc (display: ^wl_display) -> i32 ---
  wl_display_dispatch_queue :: proc (
    display: ^wl_display,
    queue: ^wl_event_queue
    ) -> i32 ---
  wl_display_dispatch_queue_pending :: proc (
    display: ^wl_display,
    queue: ^wl_event_queue
    ) -> i32 ---
  wl_display_dispatch_pending :: proc (
    display: ^wl_display
    ) -> i32 ---
  wl_display_get_error :: proc (display: ^wl_display) -> i32 ---
  /* TODO: interface is a pointer to a pointer */
  wl_display_get_protocol_error :: proc (
    display: ^wl_display,
    #by_ptr interface: ^wl_interface,
    id: ^u32
    ) -> u32 ---
  wl_display_flush :: proc (display: ^wl_display) -> i32 ---
  wl_display_roundtrip_queue :: proc (
    display: ^wl_display,
    queue: ^wl_event_queue
    ) -> i32 ---
  wl_display_roundtrip :: proc (display: ^wl_display) -> i32 ---
  wl_display_create_queue :: proc (
    display: ^wl_display
    ) -> ^wl_event_queue ---
  wl_display_create_queue_with_name :: proc (
    display: ^wl_display,
    name: cstring
    ) -> ^wl_event_queue ---
  wl_display_prepare_read_queue :: proc (
    display: ^wl_display,
    queue: ^wl_event_queue
    ) -> i32 ---
  wl_display_prepare_read :: proc (
    display: ^wl_display
    ) -> i32 ---
  wl_display_cancel_read :: proc (display: ^wl_display) ---
  wl_display_read_events :: proc (
    display: ^wl_display
    ) -> i32 ---
  wl_log_set_handler_client :: proc (handler: wl_log_func_t) ---
  wl_display_set_max_buffer_size :: proc (
    display: ^wl_display,
    max_buffer_size: uint
  ) ---
}

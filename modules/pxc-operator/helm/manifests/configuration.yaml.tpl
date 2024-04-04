pxc:
  configuration: |
    [mysqld]
    max_connect_errors = 100000
    interactive_timeout = 1800
    net_read_timeout = 360
    connect_timeout = 300
    net_write_timeout = 900
    wait_timeout = 28800
    max_execution_time = 0
    max_allowed_packet = 64M
    slow_query_log = OFF
    slow_query_log_always_write_time = 5
%{ if innodb_buffer_pool_size != "system_define" ~}
    innodb_buffer_pool_size = ${innodb_buffer_pool_size}
    max_connections = ${max_connections}
    innodb_buffer_pool_chunk_size = 128M
    innodb_buffer_pool_instances = ${innodb_buffer_pool_instances}
%{ endif ~}
    join_buffer_size = 1M
    sort_buffer_size = 1M
    read_buffer_size = 1M
    read_rnd_buffer_size = 1M

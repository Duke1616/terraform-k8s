pxc:
  configuration: |
    [mysqld]
    max_connect_errors = 100000
    interactive_timeout = 1800
    net_read_timeout = 360
    connect_timeout = 300
    net_write_timeout = 900
    wait_timeout = 28800
    max_connections = 5000
    max_execution_time = 0
    max_allowed_packet = 64M
    slow_query_log = OFF
    slow_query_log_always_write_time = 5
    # 官方推荐其配置为系统内存的 50% 到 75%
    innodb_buffer_pool_size = 10G
    innodb_buffer_pool_chunk_size = 128M
    # 该参数可以设置为服务器 CPU 核心数，这样可在一定程度上提供并发性能。
    innodb_buffer_pool_instances = 8
    join_buffer_size = 1M
    sort_buffer_size = 1M
    read_buffer_size = 1M
    read_rnd_buffer_size = 1M

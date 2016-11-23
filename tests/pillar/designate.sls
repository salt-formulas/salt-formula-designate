designate:
  server:
    enabled: true
    local_bind: true
    region: RegionOne
    domain_id: 5186883b-91fb-4891-bd49-e6769234a8fc
    version: ${_param:designate_version}
    message_queue:
      members:
        - host: ${_param:messaging_node01_address}
        - host: ${_param:messaging_node02_address}
        - host: ${_param:messaging_node03_address}
    pool:
      pool_id: cae73b6f-95eb-4a7d-a567-099ae6176e08
      nameservers:
        - uuid: 690d7bc8-811b-404c-abcc-9cec54d87092
          host: ${_param:cluster_node01_address}
          port: 53
        - uuid: bc5ddcf0-8d95-4f87-b435-9ff831a4a14c
          host: ${_param:cluster_node02_address}
          port: 53
        - uuid: a43d5375-a5ec-4077-8c87-ec0b08fa3bd1
          host: ${_param:cluster_node03_address}
          port: 53
      targets:
        uuid: f26e0b32-736f-4f0a-831b-039a415c481e
        options: 'port: 53, host: 127.0.0.1'
        masters: 127.0.0.1:5354
        type:  bind9

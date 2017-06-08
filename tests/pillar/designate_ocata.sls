designate:
  _support:
    sensu:
      enabled: false
  server:
    enabled: true
    region: RegionOne
    domain_id: 5186883b-91fb-4891-bd49-e6769234a8fc
    version: ocata
    bind:
      api:
        address: 127.0.0.1
    database:
      engine: mysql
      host: 127.0.0.1
      port: 3306
      name:
        main_database: designate
        pool_manager: designate_pool_manager
      user: designate
      password: passw0rd
    identity:
      engine: keystone
      host: 127.0.0.1
      port: 35357
      tenant: service
      user: designate
      password: passw0rd
    message_queue:
      engine: rabbitmq
      members:
      - host: 127.0.0.1
      user: openstack
      password: password
      virtual_host: '/openstack'
    pools:
      default:
        description: 'default pool'
        attributes:
          service_tier: GOLD
          test_attr: test_value
        ns_records:
          - hostname: 'ns1.example.org.'
            priority: 10
        nameservers:
          - host: 127.0.0.1
            port: 53
          - host: 127.0.1.1
            port: 53
          - host: 127.0.2.1
            port: 53
        targets:
          default_target:
            type: bind9
            description: 'default target'
            masters:
              - host: 127.0.0.1
                port: 5354
            options:
              host: 127.0.0.1
              port: 53
              rndc_host: 127.0.0.1
              rndc_port: 953
              rndc_key_file: /etc/designate/rndc.key
        also_notifies:
          - host: 127.0.3.1
            port: 53
mysql:
  client:
    enabled: true
    version: '5.7'
    admin:
      host: localhost
      port: 3306
      user: admin
      password: password
      encoding: utf8
  server:
    enabled: true
    version: "5.7"
    force_encoding: utf8
    bind:
      address: 0.0.0.0
      port: 3306
      protocol: tcp
    database:
      designate:
        encoding: utf8
        users:
        - host: '%'
          name: designate
          password: passw0rd
          rights: all
        - host: 127.0.0.1
          name: designate
          password: passw0rd
          rights: all
      designate_pool_manager:
        encoding: utf8
        users:
        - host: '%'
          name: designate
          password: passw0rd
          rights: all
        - host: 127.0.0.1
          name: designate
          password: passw0rd
          rights: all
# On xenial rabbitmq fails to start inside docker on MK CI
# rabbitmq:
#   server:
#     enabled: true
#     bind:
#       address: 0.0.0.0
#       port: 5672
#     secret_key: rabbit_master_cookie
#     admin:
#       name: adminuser
#       password: pwd
#     host:
#       '/':
#         enabled: true
#         user: guest
#         password: guest
#         policies:
#         - name: HA
#           pattern: '^(?!amq\.).*'
#           definition: '{"ha-mode": "all", "message-ttl": 120000}'
#       '/openstack':
#         enabled: true
#         user: openstack
#         password: password
#         policies:
#         - name: HA
#           pattern: '^(?!amq\.).*'
#           definition: '{"ha-mode": "all", "message-ttl": 120000}'
#     memory:
#       vm_high_watermark: 0.4
#     plugins: ['']

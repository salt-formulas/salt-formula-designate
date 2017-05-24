designate:
  server:
    enabled: true
    region: RegionOne
    domain_id: 5186883b-91fb-4891-bd49-e6769234a8fc
    version: mitaka
    message_queue:
      members:
        - host: 127.0.0.1
        - host: 127.0.1.1
        - host: 127.0.2.1
    pools:
      - name: default
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
          - type: bind9
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

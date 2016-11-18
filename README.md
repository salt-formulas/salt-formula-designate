# salt-formula-designate
Designate provides DNSaaS services for OpenStack
## Sample pillars
```yaml
designate:
  server:
    enabled: true
    local_bind: true # Option to setup local bind9 as a backend for Designate
    designate_config:
      DEFAULT:
        rabbit_userid: RABBIT_USER # RabbitMQ User
        rabbit_password: PASSWORD # RabbitMQ Password
        rabbit_hosts: IP_ADDRESS # RabbitMQ host
      service:api:
        api_base_uri: http://IP_ADDRESS:PORT/ # Ex: http://192.168.122.169:9001/
        api_host: IP_ADDRESS # Ex: 192.168.122.169
        api_port: PORT # Ex: 9001
      handler:nova_fixed:
        domain_id: DOMAIN_ID # Ex: 0d2f5a86-553f-4309-b65c-95ea76a51ce8
      keystone_authtoken:
        auth_host: IP_ADDRESS # Ex: 192.168.122.169
        admin_tenant_name: ADMIN_TENANT # Ex: services
        admin_user: ADMIN_USER # Ex: designate
        admin_password: PASSWORD
      pool_manager_cache:sqlalchemy:
        connection: mysql://DESIGNATE_MYSQL_USER:PASSWORD@IP_ADDRESS/designate_pool_manager
      storage:sqlalchemy:
        connection: mysql://DESIGNATE_MYSQL_USER:PASSWORD@IP_ADDRESS/designatedb
      database:
        engine: mysql
        host: ${_param:cluster_vip_address}
        port: 3306
        name: designate
        user: designate
        password: password
      identity:
        engine: keystone
        region: RegionOne
        host: ${_param:cluster_vip_address}
        port: 35357
        tenant: service
        user: designate
        password: password
```
## Additional pillars for pools configuration
### Single
```yaml
designate:
  server:
    designate_config:
      service:pool_manager:
        pool_id: 794ccc2c-d751-44fe-b57f-8894c9f5c842 # UUID 
      pool:794ccc2c-d751-44fe-b57f-8894c9f5c842:
        nameservers: 0f66b842-96c2-4189-93fc-1dc95a08b012
        targets: f26e0b32-736f-4f0a-831b-039a415c481e
      pool_nameserver:0f66b842-96c2-4189-93fc-1dc95a08b012:
        port: 53
        host: 127.0.0.1
      pool_target:f26e0b32-736f-4f0a-831b-039a415c481e:
        options: 'port: 53, host: 127.0.0.1'
        masters: 127.0.0.1:5354
        type: bind9
```
### Multiple
```yaml
designate:
  server:
    designate_config:
      service:pool_manager:
        pool_id: 794ccc2c-d751-44fe-b57f-8894c9f5c842
      pool:794ccc2c-d751-44fe-b57f-8894c9f5c842:
        nameservers: 0f66b842-96c2-4189-93fc-1dc95a08b012, a7c98d54-6c08-497e-ae50-c31b44923041, 871df553-07e4-4a21-8b5b-c15439e286b1
        targets: f26e0b32-736f-4f0a-831b-039a415c481e, 2683d05e-1290-4018-a02b-9a69af847d7c, dab43696-04bf-4162-8fc4-61947815c628
      pool_target:f26e0b32-736f-4f0a-831b-039a415c481e:
        masters: 192.168.122.169:5354
        type: bind9
        options: 'port: 53, host: 192.168.122.169'
      pool_target:2683d05e-1290-4018-a02b-9a69af847d7c:
        masters: 192.168.122.69:5354
        type: bind9
        options: 'port: 53, host: 192.168.122.69'
      pool_target:dab43696-04bf-4162-8fc4-61947815c628:
        masters: 192.168.122.119:5354
        type: bind9
        options: 'port: 53, host: 192.168.122.119'
      pool_nameserver:0f66b842-96c2-4189-93fc-1dc95a08b012:
        port: '53'
        host: 192.168.122.169
      pool_nameserver:a7c98d54-6c08-497e-ae50-c31b44923041:
        port: '53'
        host: 192.168.122.69
      pool_nameserver:871df553-07e4-4a21-8b5b-c15439e286b1:
        port: '53'
        host: 192.168.122.119
```
## Usage
Create server
```bash
designate server-create --name ns.example.com.
```
Create domain
```bash
designate domain-create --name example.com. --email mail@example.com
```
Create record
```bash
designate record-create example.com. --name test.example.com. --type A --data 10.2.14.15
```
Test it
```bash
dig @127.0.0.1 test.example.com.
```

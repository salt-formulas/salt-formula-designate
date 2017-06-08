
=================
Designate formula
=================

Designate provides DNSaaS services for OpenStack.

Sample pillars
==============

For Designate with BIND9 local backend:

.. code:: yaml

    designate:
      server:
        enabled: true
        region: RegionOne
        domain_id: 5186883b-91fb-4891-bd49-e6769234a8fc
        version: ocata
        backend:
          bind9:
            rndc_key: 4pc+X4PDqb2q+5o72dISm72LM1Ds9X2EYZjqg+nmsS7FhdTwzFFY8l/iEDmHxnyjkA33EQC8H+z0fLLBunoitw==
            rndc_algorithm: hmac-sha512
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
            ns_records:
              - hostname: 'ns1.example.org.'
                priority: 10
            nameservers:
              - host: 127.0.0.1
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

.. note::
   *domain_id* parameter is UUID of DNS zone managed by designate-sink service. This zone will 
   be populated by A records for fixed and floating ip addresses of spawned VMs. After designate
   is deployed and zone is created, this parameter should be updated accordingly to UUID of
   newly created zone. Then designate state should be reapplied.

Pools pillar for BIND9 master and multiple slaves setup:

.. code:: yaml

    pools:
      default:
        description: 'default pool'
        attributes:
          service_tier: GOLD
        ns_records:
          - hostname: 'ns1.example.org.'
            priority: 10
        nameservers:
          - host: 192.168.0.1
            port: 53
          - host: 192.168.0.2
            port: 53
          - host: 192.168.0.3
            port: 53
        targets:
          default_target:
            type: bind9
            description: 'default target'
            masters:
              - host: 192.168.0.4
                port: 5354
            options:
              host: 192.168.0.4
              port: 53
              rndc_host: 192.168.0.4
              rndc_port: 953
              rndc_key_file: /etc/designate/rndc.key

Usage
=====

Create server

.. code:: bash

    designate server-create --name ns.example.com.

Create domain

.. code:: bash

    designate domain-create --name example.com. --email mail@example.com

Create record

.. code:: bash

    designate record-create example.com. --name test.example.com. --type A --data 10.2.14.15

Test it

.. code:: bash

    dig @127.0.0.1 test.example.com.

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-letsencrypt/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-letsencrypt

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net

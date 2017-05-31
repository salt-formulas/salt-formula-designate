linux:
  system:
    enabled: true
    repo:
      mirantis_openstack:
        source: "deb http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }} ocata main"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }}/archive-mcpocata.key"
        pin:
        - pin: 'release a=ocata'
          priority: 1100
          package: '*'
      mirantis_openstack_hotfix:
        source: "deb http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }} ocata-hotfix main"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }}/archive-mcpocata.key"
        pin:
        - pin: 'release a=ocata-hotfix'
          priority: 1100
          package: '*'
      mirantis_openstack_security:
        source: "deb http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }} ocata-security main"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }}/archive-mcpocata.key"
        pin:
        - pin: 'release a=ocata-security'
          priority: 1100
          package: '*'
      mirantis_openstack_updates:
        source: "deb http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }} ocata-updates main"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }}/archive-mcpocata.key"
        pin:
        - pin: 'release a=ocata-uptades'
          priority: 1100
          package: '*'
      mirantis_openstack_holdback:
        source: "deb http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }} ocata-holdback main"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mcp-repos/ocata/{{ grains.get('oscodename') }}/archive-mcpocata.key"
        pin:
        - pin: 'release a=ocata-holdback'
          priority: 1100
          package: '*'
      mk_openstack:
        source: "deb [arch=amd64] http://apt-mk.mirantis.com/{{ grains.get('oscodename') }}/ nightly ocata"
        architectures: amd64
        key_url: "http://apt-mk.mirantis.com/public.gpg"
        pin:
        - pin: 'release a=nightly'
          priority: 1100
          package: '*'

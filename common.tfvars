loopbacks = [
  {
    loopback_id   = 20
    switch_id     = 101
    loopback_ipv4 = "100.100.100.1"
    vrf           = "vrf_app1"
    route_tag     = 12345
  },
  {
    loopback_id   = 20
    switch_id     = 102
    loopback_ipv4 = "100.100.100.1"
    vrf           = "vrf_app1"
    route_tag     = 12345
    route_tag     = 12345
  }
]

vpcs = [
  {
    vpc_id          = 30
    switch1_id      = 101
    switch2_id      = 102
    mode            = "active"
    bpdu_guard_flag = "true"
    mtu             = "jumbo"
    peer1_members   = ["eth1/3"]
    peer2_members   = ["eth1/3"]
  },
  {
    vpc_id          = 40
    switch1_id      = 101
    switch2_id      = 102
    mode            = "active"
    bpdu_guard_flag = "true"
    mtu             = "jumbo"
    peer1_members   = ["eth1/4"]
    peer2_members   = ["eth1/4"]
  }
]

vrfs = [
  {
    name        = "vrf_app1"
    segment_id  = 50001
    vlan_id     = 2010
    description = "application1"
    attachments = [
      {
        switch_id = 101
      },
      {
        switch_id = 102
      }
    ]
  }
]

networks = [
  {
    name         = "network_web"
    network_id   = 30001
    vlan_id      = 2311
    description  = "network for web tier"
    vrf_name     = "vrf_app1"
    ipv4_gateway = "10.1.1.1/24"
    attachments = [
      {
        switch_id = 101
        switch_ports = [
          "Port-channel30",
          "Port-channel40",
        ]
      },
      {
        switch_id = 102
        switch_ports = [
          "Port-channel30",
          "Port-channel40",
        ]
      }
    ]
  }
]

# bonus

templates = [
  {
    name        = "telemetry"
    description = "static telemetry config"
    file        = "./telemetry.tmpl"
  }
]

policies = [
  {
    switch_id     = 101
    template_name = "telemetry"
    description   = "dialout telemetry"
    priority      = 500
    props         = {}
  },
  {
    switch_id     = 102
    template_name = "telemetry"
    description   = "dialout telemetry"
    priority      = 500
    props         = {}
  },
  {
    switch_id     = 201
    template_name = "telemetry"
    description   = "dialout telemetry"
    priority      = 500
    props         = {}
  },
  {
    switch_id     = 101
    template_name = "ntp_server"
    description   = "ntp_server 10.81.254.131"
    priority      = 500
    props = {
      "NTP_SERVER"     = "10.81.254.131"
      "NTP_SERVER_VRF" = "management"
    }
  },
  {
    switch_id     = 102
    template_name = "ntp_server"
    description   = "ntp_server 10.81.254.131"
    priority      = 500
    props = {
      "NTP_SERVER"     = "10.81.254.131"
      "NTP_SERVER_VRF" = "management"
    }
  },
  {
    switch_id     = 201
    template_name = "ntp_server"
    description   = "ntp_server 10.81.254.131"
    priority      = 500
    props = {
      "NTP_SERVER"     = "10.81.254.131"
      "NTP_SERVER_VRF" = "management"
    }
  }
]

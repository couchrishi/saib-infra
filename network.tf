resource "oci_core_virtual_network" "VCN-Demo" {
  cidr_block     = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "MSP-Demo-VCN"

  #dns_label      = "vcndemo"
}

resource "oci_core_internet_gateway" "IGW-Demo" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "IGW-Demo"
  vcn_id         = "${oci_core_virtual_network.VCN-Demo.id}"
}

resource "oci_core_route_table" "RT-Demo" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.VCN-Demo.id}"
  display_name   = "RT-Demo"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.IGW-Demo.id}"
  }
}

resource "oci_core_security_list" "SL-InstanceSubnet" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "SL-Instance"
  vcn_id         = "${oci_core_virtual_network.VCN-Demo.id}"

  egress_security_rules = [{
    protocol    = "6"
    destination = "0.0.0.0/0"
  },
    {
      protocol    = "1"
      destination = "0.0.0.0/0"
    },
    {
      protocol    = "17"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      tcp_options {
        "max" = 8080
        "min" = 8080
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 0
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 3
        "code" = 4
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 8
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
  ]
}

resource "oci_core_security_list" "SL-DBSubnet" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "SL-DB"
  vcn_id         = "${oci_core_virtual_network.VCN-Demo.id}"

  egress_security_rules = [{
    protocol    = "6"
    destination = "0.0.0.0/0"
  },
    {
      protocol    = "1"
      destination = "0.0.0.0/0"
    },
    {
      protocol    = "17"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      tcp_options {
        "max" = 3306
        "min" = 3306
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 0
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 3
        "code" = 4
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 8
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
  ]
}

resource "oci_core_subnet" "SN-DemoSubnetAD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.DemoSubnetAD1CIDR}"
  display_name        = "SN-InstanceSubnet"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.VCN-Demo.id}"
  route_table_id      = "${oci_core_route_table.RT-Demo.id}"
  security_list_ids   = ["${oci_core_security_list.SL-InstanceSubnet.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.VCN-Demo.default_dhcp_options_id}"

  #dns_label           = "sndemosubnetad1"
}

resource "oci_core_subnet" "SN-DemoSubnetAD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.DemoSubnetAD2CIDR}"
  display_name        = "SN-DBSubnet"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.VCN-Demo.id}"
  route_table_id      = "${oci_core_route_table.RT-Demo.id}"
  security_list_ids   = ["${oci_core_security_list.SL-DBSubnet.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.VCN-Demo.default_dhcp_options_id}"

  #dns_label           = "sndemosubnetad1"
}

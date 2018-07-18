# Output the private and public IPs of the instances

output "MySql DB PublicIP" {
  value = ["${data.oci_core_vnic.InstanceVnic.public_ip_address}"]
}


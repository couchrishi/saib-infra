# Authentication
variable "oci_tenancy_ocid" {}

variable "oci_user_ocid" {}
variable "oci_fingerprint" {}
variable "oci_private_key_path" {}

variable "compartment_ocid" {}
variable "oci_ssh_public_key" {}
variable "oci_ssh_private_key" {}

variable "oci_region" {
  default = "us-ashburn-1"
}

variable "InstanceShape" {
  default = "VM.Standard1.4"
}

variable "DemoShape" {
  default = "VM.Standard1.4"
}

variable "InstanceOS" {
  default = "Oracle Linux"
}

variable "InstanceOSVersion" {
  default = "7.5"
}

variable "VPC-CIDR" {
  default = "10.0.0.0/16"
}

variable "DemoSubnetAD1CIDR" {
  default = "10.0.1.0/24"
}

variable "DemoSubnetAD2CIDR" {
  default = "10.0.2.0/24"
}

variable "TomcatAppBootStrap" {
  default = "./userdata/tomcatApp"
}

variable "MysqlBootStrap" {
  default = "./userdata/mysql"
}

### Added for Block , block.tf , remote-exec.tf

# Choose an Availability Domain
variable "AD" {
  default = "1"
}

variable "2TB" {
  default = "2097152"
}

variable "50GB" {
  default = "51200"
}

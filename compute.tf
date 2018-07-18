resource "oci_core_instance" "MySql" {
  #availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"

  compartment_id = "${var.compartment_ocid}"
  display_name   = "Mysql-Instance"

  //image = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"

  image     = "ocid1.image.oc1.iad.aaaaaaaacuywxcsllo5dpp5s6gongdygwj4ofuikowqr2tnbvo3j3wzmfmla"
  
  shape     = "${var.InstanceShape}"
  subnet_id = "${oci_core_subnet.SN-DemoSubnetAD2.id}"
  metadata {
    ssh_authorized_keys = "${var.oci_ssh_public_key}"
    user_data           = "${base64encode(file(var.MysqlBootStrap))}"
  }
}

resource "oci_core_instance" "TomcatApp" {
  #availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"

  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "Tomcat-App-Instance-1"

  #image               = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"
  #centOS7 image
  image = "ocid1.image.oc1.iad.aaaaaaaa6ybn2lkqp2ejhijhehf5i65spqh3igt53iyvncyjmo7uhm5235ca"

  shape     = "${var.InstanceShape}"
  subnet_id = "${oci_core_subnet.SN-DemoSubnetAD1.id}"

  metadata {
    ssh_authorized_keys = "${var.oci_ssh_public_key}"
    user_data           = "${base64encode(file(var.TomcatAppBootStrap))}"
    db_ip               = "${data.oci_core_vnic.InstanceVnic.public_ip_address}"
  }
}

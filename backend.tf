terraform {
  backend "http" {
    update_method = "PUT"
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/9dJ84RyPJ3x0bC6GmnWpdNXe-WV4uj_KPbRdt4I_dis/n/pranastudios/b/remotetfstate/o/terraform.tfstate"
  }
}
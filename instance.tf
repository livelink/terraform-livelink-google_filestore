resource random_string filestore_name {
  length  = 16
  special = false
  upper   = false
  lower   = true
  number  = false
}
resource google_filestore_instance filestore {
  name = random_string.filestore_name.result
  tier = "STANDARD"
  zone = "${local.resource_location}-a"
  depends_on = [ "google_project_service.filestore_api" ]
  file_shares {
    capacity_gb = 1024
    name =  random_string.filestore_name.result
  }

  networks {
    network = "${var.client_name}-${var.environment}"
    modes = ["MODE_IPV4"]
  }
}

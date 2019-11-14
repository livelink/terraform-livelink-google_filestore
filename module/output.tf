output server {
  value = google_filestore_instance.filestore.networks.0.ip_addresses.0
}

output path {
  value = random_string.filestore_name.result
}

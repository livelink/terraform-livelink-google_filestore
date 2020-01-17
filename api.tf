resource "google_project_service" "filestore_api" {
  service = "file.googleapis.com"
  disable_on_destroy = false
}

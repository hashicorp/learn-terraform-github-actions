resource "google_storage_bucket" "gcsbucket" {
  name = var.gcs_name
  location = var.gcs_location
  project = var.project_id
}

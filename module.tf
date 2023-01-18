module "gcs_bucket" {
  source       = "./Modules/bucket/"
  gcs_name     = var.bucket_name
  gcs_location = var.bucket_location
  project_id   = var.project_id
}

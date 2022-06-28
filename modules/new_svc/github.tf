
resource "github_repository" "service_repo" {
  name        = "${var.service_name}-repo"
  description = "repo for ${var.service_name} microservice on gke"

  visibility = "public"
}

resource "github_repository_file" "github_action" {
  repository          = github_repository.service_repo.name
  branch              = "main"
  file                = ".github/workflows/cicd.yaml"
  content             = file("${path.module}/templates/.github/workflows/cicd.yaml")
  commit_message      = "Managed by Terraform github action"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [github_repository_file.deployment]
}

resource "github_repository_file" "deployment" {
  repository          = github_repository.service_repo.name
  branch              = "main"
  file                = "deployment.yaml"
  content             = templatefile("${path.module}/templates/deployment.tftpl",{ deploy_name = var.service_name})
  commit_message      = "Managed by Terraform deployment"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [github_repository_file.hpa]
}

resource "github_repository_file" "hpa" {
  repository          = github_repository.service_repo.name
  branch              = "main"
  file                = "deployment.yaml"
  content             = templatefile("${path.module}/templates/hpa.tftpl",{ deploy_name = var.service_name, min_replica = var.min_replica, max_replica = var.max_replica})
  commit_message      = "Managed by Terraform hpa"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [github_repository_file.env]
}


resource "github_repository_file" "env" {
  repository          = github_repository.service_repo.name
  branch              = "main"
  file                = ".env"
  content             = templatefile("${path.module}/templates/.env.tftpl",{ deploy_name = var.service_name, image_name = var.service_name, workload_identity = var.workload_identity, service_account = var.service_account})
  commit_message      = "Managed by Terraform env var"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}
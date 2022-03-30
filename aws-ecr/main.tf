resource "aws_ecr_repository" "main" {
  name                 = "${var.name}-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository_policy" "main" {
  # repository = aws_ecr_repository.main.name

  # policy = jsonencode({
  #   rules = [{
  #     rulePriority = 1
  #     description  = "keep last 10 images"
  #     action       = {
  #       type = "expire"
  #     }
  #     selection     = {
  #       tagStatus   = "any"
  #       countType   = "imageCountMoreThan"
  #       countNumber = 10
  #     }
  #   }]
  # })

  repository = aws_ecr_repository.main.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the ${aws_ecr_repository.main.name} repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

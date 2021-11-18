resource "aws_s3_bucket" "bucket" {
  bucket = "aurelio-malheiros-githubactions"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
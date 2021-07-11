output "bucket_url" {
    description = "URL of s3 bucket"
    value = aws_s3_bucket.terrabucket.bucket_regional_domain_name
}
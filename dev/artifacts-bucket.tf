resource "random_id" "random_bucket_suffix" {
  byte_length = 1
}

resource "aws_s3_bucket" "artifacts_bucket" {
  bucket = "${var.artifacts_bucket}-${random_id.random_bucket_suffix.dec}"
  acl    = "private"

  tags = {
    Name        = "Artifacts bucket"
    Environment = "Dev"
  }
}

output "artifacts_bucket_full_name" {
  value = "${aws_s3_bucket.artifacts_bucket.id}"
}

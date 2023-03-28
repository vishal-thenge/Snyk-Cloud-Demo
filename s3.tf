#Define Buckets
resource "aws_s3_bucket" "exposedbucket" {
  bucket = "${var.victim_company}accidentlyexposed"
  tags = {
    Name        = "Exposed Bucket"
    env = "Dev"
    Owner = var.owner
  }
}

resource "aws_s3_bucket_acl" "exposedbucket_acl" {
  bucket = aws_s3_bucket.exposedbucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.exposedbucket.id
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


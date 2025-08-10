# below code tells Terraform to use AWS and which region

provider "aws" {
  region = "us-east-1"  # You can change this to your preferred region
}

resource "aws_s3_bucket" "dube_bucket" {
  bucket = "dube-drop-bucket"
  acl    = "private"
}


resource "aws_s3_bucket_object" "notes_upload" {
  bucket = aws_s3_bucket.dube_bucket.bucket
  key    = "notes.txt"
  source = "${path.module}/../notes.txt"
  acl    = "private"
}

resource "aws_s3_bucket_object" "notes_upload" {
  bucket = aws_s3_bucket.dube_bucket.bucket
  key    = "notes1.txt"
  source = "${path.module}/../notes.txt"
  acl    = "private"
}




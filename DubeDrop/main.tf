provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket_website_configuration" "dube_site" {
  bucket = "dube-drop-notes-2025"

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = "dube-drop-notes-2025"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::dube-drop-notes-2025/*"
      }
    ]
  })
}

resource "aws_s3_bucket_object" "notes_upload" {
  bucket = "dube-drop-notes-2025"
  key    = "notes.txt"
  source = "notes.txt"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "index_upload" {
  bucket        = "dube-drop-notes-2025"
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
  acl           = "public-read"
}

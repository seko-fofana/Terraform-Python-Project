provider "aws" {
  region = var.aws_region
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../Python/index.py"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "gitlab-examen-${var.group_id}"
	s3_bucket				 = aws_s3_bucket.this.bucket
	s3_key					 = "lambda_function.zip"
  role             = data.aws_iam_role.this.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = var.runtime

  tags = {
    Name        = var.group_id
  }
}

resource "aws_s3_bucket" "this" {
  bucket = "gitlab-examen-${var.group_id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = var.group_id
  }
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = aws_s3_bucket.this.bucket
  key    = "lambda_function.zip"
  source = "${path.module}/lambda_function.zip"
  etag   = filemd5("${path.module}/lambda_function.zip")
}

data "aws_iam_role" "this" {
  name = "SUP2VINCI-gitlab"
}

# Resource S3 Bucket static content with subdomain
################################################################################################

resource "aws_s3_bucket" "bucket_static_web_subdomain" {
  bucket = "${var.sub_domain}.${var.naked_domain}.${var.tld}"

  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

#Attach bucket policy
resource "aws_s3_bucket_policy" "allow_cloudfront_access_policy" {
  bucket = aws_s3_bucket.bucket_static_web_subdomain.id
  policy = data.aws_iam_policy_document.allow_cloudfront_access.json
}

# Website Config S3 Bucket with subdomain
################################################################################################

resource "aws_s3_bucket_website_configuration" "s3_website_subdomain" {
  bucket = aws_s3_bucket.bucket_static_web_subdomain.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

}

# Upload files on creation
################################################################################################

resource "null_resource" "upload_files" {
  provisioner "local-exec" {
    command = "aws s3 cp ../static-web/build/ s3://${aws_s3_bucket.bucket_static_web_subdomain.bucket} --recursive"
  }

  depends_on = [aws_s3_bucket.bucket_static_web_subdomain]
}

# Resource S3 Bucket static content redirect
################################################################################################
resource "aws_s3_bucket" "bucket_static_web" {
  bucket = "${var.naked_domain}.${var.tld}"

  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}


# Website Config S3 Bucket redirect
################################################################################################

resource "aws_s3_bucket_website_configuration" "s3_website_redirect" {
  bucket = aws_s3_bucket.bucket_static_web_subdomain.id

  redirect_all_requests_to {

    host_name = "${var.sub_domain}.${var.naked_domain}.${var.tld}"

    protocol = var.protocol
  }

}


locals {
  assets_access_identity = "${var.project}-${var.environment}-client-assets-${var.domain}"

  allDomains = concat([var.domain], var.aliases)

  # Find buckets that are the domain apex. These need to have A ALIAS records.
  rootDomains = [
    for domain in local.allDomains :
    domain if length(regexall("\\.", domain)) == 1
  ]

  # Find buckets that are subdomains. These can have CNAME records.
  subDomains = [
    for domain in local.allDomains :
    domain if length(regexall("\\.", domain)) > 1
  ]

  # allows frontend application to upload to pre-signed S3 urls
  corsRules = length(var.allowed_cors_origins) > 0 ? [{
    allowed_methods = ["HEAD", "GET", "PUT", "POST"],
    allowed_origins = var.allowed_cors_origins,
    max_age_seconds = 3000
  }] : []
}

resource "aws_s3_bucket" "client_assets" {
  // Our bucket's name is going to be the same as our site's domain name.
  bucket = var.domain
  acl    = "private" // The contents will be available through cloudfront, they should not be accessible publicly

  dynamic "cors_rule" {
    for_each = local.corsRules
    content {
      allowed_methods = lookup(cors_rule.value, "allowed_methods", ["GET"])
      allowed_origins = lookup(cors_rule.value, "allowed_origins", [""])
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", 3000)
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Deny public access to this bucket
resource "aws_s3_bucket_public_access_block" "client_assets" {
  bucket                  = aws_s3_bucket.client_assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Access identity for CF access to S3
resource "aws_cloudfront_origin_access_identity" "client_assets" {
  comment = local.assets_access_identity
}

# Policy to allow CF access to S3
data "aws_iam_policy_document" "assets_origin" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.client_assets.id}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.client_assets.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.client_assets.id}"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.client_assets.iam_arn]
    }
  }
}

# Attach the policy to the bucket
resource "aws_s3_bucket_policy" "client_assets" {
  depends_on = [aws_cloudfront_distribution.client_assets_distribution]
  bucket     = aws_s3_bucket.client_assets.id
  policy     = data.aws_iam_policy_document.assets_origin.json
}

# Create the cloudfront distribution
resource "aws_cloudfront_distribution" "client_assets_distribution" {
  // origin is where CloudFront gets its content from.
  origin {
    domain_name = aws_s3_bucket.client_assets.bucket_domain_name
    origin_id   = local.assets_access_identity
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.client_assets.cloudfront_access_identity_path
    }
  }

  // for single page applications, we need to respond with the index if file is missing
  custom_error_response {
    error_code            = 404
    response_code         = 200
    error_caching_min_ttl = 0
    response_page_path    = "/index.html"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html" # Render this when you hit the root

  // All values are defaults from the AWS console.
  default_cache_behavior {
    target_origin_id       = local.assets_access_identity
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    trusted_signers        = var.cf_signed_downloads ? var.cf_trusted_signers : null

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    dynamic "lambda_function_association" {
      for_each = var.cf_lambda_function_associations
      content {
        event_type   = lambda_function_association.value.event_type
        lambda_arn   = lambda_function_association.value.lambda_arn
        include_body = lambda_function_association.value.include_body
      }
    }
  }

  aliases = local.allDomains

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Use our cert
  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }

  depends_on = [var.certificate_validation]
}

# Root domains to point at CF
resource "aws_route53_record" "client_assets_root" {
  count = length(local.rootDomains)

  zone_id = var.route53_zone_id
  name    = local.rootDomains[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.client_assets_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.client_assets_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# Subdomains to point at CF
resource "aws_route53_record" "client_assets_subdomain" {
  count = length(local.subDomains)

  zone_id = var.route53_zone_id
  name    = local.subDomains[count.index]
  type    = "CNAME"
  ttl     = "120"
  records = [aws_cloudfront_distribution.client_assets_distribution.domain_name]
}

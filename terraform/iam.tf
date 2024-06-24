# IAM S3 content
################################################################################################

data "aws_iam_policy_document" "allow_cloudfront_access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket_static_web_subdomain.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}


# IAM S3 content
################################################################################################

#Create policy for update S3 content
resource "aws_iam_policy" "s3_update_object_policy" {
  name = "s3-update-object-${var.sub_domain}.${var.naked_domain}.${var.tld}-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PutObject",
        "Effect" : "Allow",
        "Action" : "s3:PutObject",
        "Resource" : [
          "arn:aws:s3:::${var.sub_domain}.${var.naked_domain}.${var.tld}/*"
        ]
      },
      {
        "Sid" : "ListBucket",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::${var.sub_domain}.${var.naked_domain}.${var.tld}"
        ]
      }
    ]
  })
}


# IAM Cloudfront distribution
################################################################################################

#Create policy for update cloudfront distribution
resource "aws_iam_policy" "cloudfront_update_distribution" {
  name = "cloudfront-distribution-${var.sub_domain}.${var.naked_domain}.${var.tld}-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "CloudfrontUpdateDistribution",
        "Effect" : "Allow",
        "Action" : [
          "cloudfront:UpdateDistribution",
          "cloudfront:DeleteDistribution",
          "cloudfront:CreateInvalidation"
        ],
        "Resource" : "arn:aws:cloudfront::${var.account_id}:distribution/${aws_cloudfront_distribution.cdn.id}"
      }
    ]
  })
}

# IAM Github Actions
################################################################################################

#Create role for github actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-${var.sub_domain}.${var.naked_domain}.${var.tld}-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:${var.github_org}/${var.repository_name}:*"
          }
        }
      }
    ]
  })
}

#Attach s3_update_object_policy
resource "aws_iam_role_policy_attachment" "attach-github-action--s3-policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.s3_update_object_policy.arn
}

#Attach cloudfront_update_distribution
resource "aws_iam_role_policy_attachment" "attach-github-action--cloudfront-policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.cloudfront_update_distribution.arn
}

# Output the ARN of Github Action role
output "github_action_s3_update_object_role_arn" {
  description = "Github action machine role ARN"
  value       = aws_iam_role.github_actions_role.arn
}

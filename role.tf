# IAM assume role policy document for the IAM role
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    dynamic "principals" {
      for_each = var.account_ids
      iterator = ids

      content {
        type = "AWS"
        identifiers = [
          "arn:aws:iam::${ids.value}:${local.iam_username}"
        ]
      }
    }
  }
}

# The IAM role
resource "aws_iam_role" "ssm_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = local.role_description
  name               = local.role_name
}

# Attach the SSM policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = aws_iam_policy.ssm_policy.arn
  role       = aws_iam_role.ssm_role.name
}

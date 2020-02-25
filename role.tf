# IAM assume role policy document for the IAM role
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

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
          "arn:aws:iam::${ids.value}:root"
        ]
      }
    }
  }
}

# The IAM role
resource "aws_iam_role" "the_role" {
  name               = "ParameterStoreReadOnly-${var.hostname}"
  description        = "Allows reading SSM params for ${var.hostname}."
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
}

# Get the current account
data "aws_caller_identity" "current" {}

# IAM policy document that that allows for reading the SSM parameters
data "aws_iam_policy_document" "ssm_doc" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]

    # calculate all the combinations of regions, accounts, and names
    resources = [for t in setproduct(var.ssm_regions, [data.aws_caller_identity.current.account_id], var.ssm_names) : format("arn:aws:ssm:${t[0]}:${t[1]}:parameter${t[2]}")]
  }
}

# The IAM policy for our ssm-reading role
resource "aws_iam_role_policy" "ssm_policy" {
  role   = aws_iam_role.the_role.id
  policy = data.aws_iam_policy_document.ssm_doc.json
}

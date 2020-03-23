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

    # Calculate all combinations of account_ids and iam_usernames
    principals {
      type        = "AWS"
      identifiers = [for t in setproduct(var.account_ids, local.iam_usernames) : format("arn:aws:iam::${t[0]}:${t[1]}")]
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

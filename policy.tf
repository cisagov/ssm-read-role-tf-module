# Get the current account
data "aws_caller_identity" "current" {
}

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
resource "aws_iam_policy" "ssm_policy" {
  description = "Allows read-only access to SSM Parameter Store parameters required for ${var.user}."
  name        = "ParameterStoreReadOnly-${var.user}"
  policy      = data.aws_iam_policy_document.ssm_doc.json
}

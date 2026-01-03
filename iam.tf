# IAM policy document for scheduled Lambda execution
# This is passed to the lambda module as an inline policy
data "aws_iam_policy_document" "lambda_execution" {
  # Secrets Manager access (if secrets are configured)
  dynamic "statement" {
    for_each = length(var.secrets_arns) > 0 ? [1] : []
    content {
      sid    = "AllowSecretsManagerAccess"
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = var.secrets_arns
    }
  }

  # CloudWatch Metrics (for script monitor)
  statement {
    sid    = "AllowCloudWatchMetrics"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = ["*"]
  }

  # Additional policy statements
  dynamic "statement" {
    for_each = var.additional_policy_statements
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

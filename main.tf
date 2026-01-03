# Lambda function (using composable lambda module)
module "lambda_function" {
  source = "git::https://github.com/im5tu/opentofu-aws-lambda.git?ref=1ae587f69bc37a3faf4fae0aa35267dc91e8bdca"

  name                                    = var.function_name
  description                             = "Scheduled Lambda function"
  package_type                            = "Image"
  image_uri                               = var.image_uri
  function_architecture                   = var.architecture
  function_memory_in_mb                   = var.memory_size
  function_timeout_in_seconds             = var.timeout
  function_reserved_concurrent_executions = var.reserved_concurrent_executions
  cloudwatch_logs_retention_in_days       = var.log_retention_days

  # VPC configuration
  vpc_subnet_ids         = var.subnet_ids
  vpc_security_group_ids = var.security_group_ids

  # Environment variables
  environment_variables = var.environment_variables

  # IAM policies - use custom policies from this module instead of lambda module's defaults
  iam_inline_policies = {
    "scheduled_lambda_execution" = data.aws_iam_policy_document.lambda_execution.json
  }

  dead_letter_target_arn = var.dead_letter_target_arn

  tags = var.tags
}

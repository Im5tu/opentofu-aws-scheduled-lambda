output "function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda_function.name
}

output "function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda_function.arn
}

output "eventbridge_rule_name" {
  description = "Name of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.schedule.name
}

output "secrets_arns_configured" {
  description = "Secrets ARNs that were configured for IAM access (for debugging)"
  value       = var.secrets_arns
}

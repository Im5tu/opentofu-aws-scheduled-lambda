# OpenTofu AWS Scheduled Lambda

An OpenTofu module that creates an AWS Lambda function triggered by EventBridge on a schedule. This module wraps the [opentofu-aws-lambda](https://github.com/im5tu/opentofu-aws-lambda) module and adds EventBridge scheduling using cron or rate expressions.

## Usage

```hcl
module "scheduled_lambda" {
  source = "git::https://github.com/im5tu/opentofu-aws-scheduled-lambda.git?ref=1ae587f69bc37a3faf4fae0aa35267dc91e8bdca"

  function_name       = "my-scheduled-task"
  image_uri           = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest"
  schedule_expression = "rate(5 minutes)"

  environment_variables = {
    LOG_LEVEL = "INFO"
  }

  tags = {
    Environment = "production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.9 |
| aws | ~> 6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| function_name | Name of the Lambda function | `string` | n/a | yes |
| image_uri | ECR image URI for the Lambda function | `string` | n/a | yes |
| schedule_expression | EventBridge schedule expression (e.g., 'rate(5 minutes)' or 'cron(0 12 * * ? *)') | `string` | n/a | yes |
| schedule_enabled | Whether the EventBridge schedule is enabled | `bool` | `true` | no |
| memory_size | Memory size for Lambda function in MB | `number` | `1536` | no |
| timeout | Timeout for Lambda function in seconds | `number` | `60` | no |
| architecture | Lambda architecture (x86_64 or arm64) | `string` | `"x86_64"` | no |
| reserved_concurrent_executions | Reserved concurrent executions for Lambda function (-1 = unreserved) | `number` | `-1` | no |
| log_retention_days | CloudWatch log retention in days | `number` | `7` | no |
| subnet_ids | List of subnet IDs for Lambda VPC configuration (optional) | `list(string)` | `[]` | no |
| security_group_ids | List of security group IDs for Lambda (optional) | `list(string)` | `[]` | no |
| environment_variables | Environment variables for the Lambda function | `map(string)` | `{}` | no |
| secrets_arns | List of Secrets Manager secret ARNs the Lambda can access | `list(string)` | `[]` | no |
| additional_policy_statements | Additional IAM policy statements to attach to the Lambda execution role | `list(object)` | `[]` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| function_name | Name of the Lambda function |
| function_arn | ARN of the Lambda function |
| eventbridge_rule_name | Name of the EventBridge rule |
| secrets_arns_configured | Secrets ARNs that were configured for IAM access |

## Development

### Validation

This module uses GitHub Actions for validation:

- **Format check**: `tofu fmt -check -recursive`
- **Validation**: `tofu validate`
- **Security scanning**: Checkov, Trivy

### Local Development

```bash
# Format code
tofu fmt -recursive

# Validate
tofu init -backend=false
tofu validate
```

## License

MIT License - see [LICENSE](LICENSE) for details.

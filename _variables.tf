# Core Configuration
variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "image_uri" {
  description = "ECR image URI for the Lambda function"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# Schedule Configuration
variable "schedule_expression" {
  description = "EventBridge schedule expression (e.g., 'rate(5 minutes)' or 'cron(0 12 * * ? *)')"
  type        = string
}

variable "schedule_enabled" {
  description = "Whether the EventBridge schedule is enabled"
  type        = bool
  default     = true
}

# Lambda Configuration
variable "memory_size" {
  description = "Memory size for Lambda function in MB"
  type        = number
  default     = 1536
}

variable "timeout" {
  description = "Timeout for Lambda function in seconds"
  type        = number
  default     = 60
}

variable "architecture" {
  description = "Lambda architecture (x86_64 or arm64)"
  type        = string
  default     = "x86_64"
  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "Architecture must be either 'x86_64' or 'arm64'."
  }
}

variable "reserved_concurrent_executions" {
  description = "Reserved concurrent executions for Lambda function (-1 = unreserved)"
  type        = number
  default     = -1
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

# VPC Configuration
variable "subnet_ids" {
  description = "List of subnet IDs for Lambda VPC configuration (optional)"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs for Lambda (optional)"
  type        = list(string)
  default     = []
}

# Environment Variables
variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

# Secrets Manager Access
variable "secrets_arns" {
  description = "List of Secrets Manager secret ARNs the Lambda can access"
  type        = list(string)
  default     = []
}

# Additional IAM Policies
variable "additional_policy_statements" {
  description = "Additional IAM policy statements to attach to the Lambda execution role"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

# Dead Letter Queue
variable "dead_letter_target_arn" {
  description = "ARN of SNS topic or SQS queue for failed async invocations (optional)"
  type        = string
  default     = null
}

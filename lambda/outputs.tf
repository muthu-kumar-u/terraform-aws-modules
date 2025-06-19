# infra/environments/prod/modules/lambda/outputs.tf

output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_security_group_id" {
  description = "Security group ID attached to the Lambda function"
  value       = aws_security_group.LambdaSG.id
}

output "lambda_iam_role_arn" {
  description = "IAM role ARN used by the Lambda function"
  value       = aws_iam_role.LambdaRole.arn
}

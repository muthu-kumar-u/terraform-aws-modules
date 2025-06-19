# infra/environments/prod/modules/api_gateway/outputs.tf

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = module.api_gateway.apigatewayv2_api_id
}

output "api_gateway_arn" {
  description = "ARN of the API Gateway"
  value       = module.api_gateway.apigatewayv2_api_arn
}

output "api_gateway_endpoint" {
  description = "Endpoint of the API Gateway"
  value       = module.api_gateway.apigatewayv2_api_api_endpoint
}

output "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = module.api_gateway.apigatewayv2_api_execution_arn
}

output "api_gateway_custom_domain" {
  description = "Custom domain name associated with the API Gateway"
  value       = module.api_gateway.apigatewayv2_domain_name
}

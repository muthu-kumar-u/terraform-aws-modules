# infra/environments/prod/modules/api_gateway/main.tf

# api gateway
module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = var.name
  description   = var.description
  protocol_type = var.protocol_type 

  cors_configuration = {
    allow_headers = var.cors_allow_headers
    allow_methods = var.cors_allow_methods
    allow_origins = var.cors_allow_origins
  }

  default_stage_access_log_destination_arn = var.cloudwatch_log_group_arn
  default_stage_access_log_format          = var.access_log_format

  domain_name     = var.domain_name
  domain_name_certificate_arn = var.certificate_arn

  integrations = {
    "ANY /" = {
      detailed_metrics_enabled = false

      integration = {
        uri                    = var.lambda_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
    "$default" = {
      integration = {
        uri = var.lambda_arn
        tls_config = {
          server_name_to_verify = var.domain_name
        }

        response_parameters = [
          {
            status_code = 500
            mappings = {
              "append:header.header1" = "$context.requestId"
              "overwrite:statuscode"  = "403"
            }
          },
          {
            status_code = 404
            mappings = {
              "append:header.error" = "$stageVariables.environmentId"
            }
          }
        ]
      }
    }
  }

  tags = var.tags
}

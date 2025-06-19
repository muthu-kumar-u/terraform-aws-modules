# infra/shared/security_groups/variables.tf

variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate subnets and route tables with"
}

variable "security_groups_config" {
  description = "Map of Security Groups in object"
  type = map(object({
    description = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
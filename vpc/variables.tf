# infra/shared/vpc/variables.tf

variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate subnets and route tables with"
}

variable "subnets" {
  description = "Map of subnet definitions"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}

variable "route_tables" {
  description = "Map of route table definitions"
  type = map(object({
    name        = string
    routes      = list(object({
      cidr_block = string
      gateway_id = string
    }))
  }))
}

variable "vpc_endpoints" {
  description = "Map of VPC endpoint service names"
  type        = map(string) 
}
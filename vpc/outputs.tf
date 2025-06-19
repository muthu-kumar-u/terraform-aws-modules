# infra/shared/vpc/outputs.tf

output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    for k, subnet in aws_subnet.this : k => subnet.id
  }
}

output "route_table_ids" {
  description = "Map of route table IDs"
  value = {
    for k, rt in aws_route_table.this : k => rt.id
  }
}

output "route_table_association_ids" {
  description = "Map of route table association IDs"
  value = {
    for k, assoc in aws_route_table_association.private : k => assoc.id
  }
}

output "vpc_endpoint_ids" {
  description = "Map of VPC endpoint IDs"
  value = {
    for k, ep in aws_vpc_endpoint.this : k => ep.id
  }
}
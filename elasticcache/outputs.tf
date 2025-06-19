# infra/environments/prod/modules/elasticcahe/outputs.tf

output "elasticache_security_group_id" {
  description = "The security group ID for ElastiCache"
  value       = aws_security_group.ElasticacheSG.id
}

output "elasticache_subnet_group_name" {
  description = "The name of the ElastiCache subnet group"
  value       = aws_elasticache_subnet_group.ElasticacheSubnetGroup.name
}

output "elasticache_cluster_id" {
  description = "The ElastiCache cluster ID"
  value       = module.elasticache.elasticache_cluster_id
}

output "elasticache_cluster_arn" {
  description = "The ElastiCache cluster ARN"
  value       = module.elasticache.elasticache_cluster_arn
}

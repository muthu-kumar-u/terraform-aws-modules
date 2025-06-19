# infra/shared/security_groups/outputs.tf

output "security_group_ids" {
  description = "Map of security group names to their IDs"
  value       = {
    for sg_name, sg in aws_security_group.custom_sg :
    sg_name => sg.id
  }
}
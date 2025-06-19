# infra/shared/ec2/outputs.tf

output "instance_ids" {
  description = "EC2 Instance IDs"
  value = {
    for key, instance in aws_instance.ec2 :
    key => instance.id
  }
}

output "instance_private_ips" {
  description = "Private IPs of the EC2 instances"
  value = {
    for key, instance in aws_instance.ec2 :
    key => instance.private_ip
  }
}

output "instance_public_ips" {
  description = "Public IPs of the EC2 instances (if applicable)"
  value = {
    for key, instance in aws_instance.ec2 :
    key => instance.public_ip
  }
}

output "instance_arns" {
  description = "ARNs of the EC2 instances"
  value = {
    for key, instance in aws_instance.ec2 :
    key => instance.arn
  }
}

output "instance_names" {
  description = "Name tags of the EC2 instances"
  value = {
    for key, instance in aws_instance.ec2 :
    key => lookup(instance.tags, "Name", "no-name")
  }
}

output "instance_private_dns" {
  description = "Private DNS names of the EC2 instances"
  value = {
    for key, instance in aws_instance.ec2 :
    key => instance.private_dns
  }
}
# infra/shared/ec2/main.tf

locals {
  ec2_expanded_instances = flatten([
    for tmpl_key, tmpl in var.ec2_instance_templates : [
      for i, subnet_id in tmpl.subnet_ids : {
        key                         = "${tmpl_key}-${i}"
        name                        = "${tmpl.name}-${i}"
        ami                         = tmpl.ami
        instance_type               = tmpl.instance_type
        subnet_id                   = subnet_id
        key_name                    = tmpl.key_name
        security_group_ids          = tmpl.security_group_ids
        user_data                   = lookup(tmpl, "user_data", null)
        iam_instance_profile        = lookup(tmpl, "iam_instance_profile", null)
        associate_public_ip_address = lookup(tmpl, "associate_public_ip_address", false)
        root_volume_size            = lookup(tmpl, "root_volume_size", 8)
        root_volume_type            = lookup(tmpl, "root_volume_type", "gp3")
        tags                        = lookup(tmpl, "tags", {})
      }
    ]
  ])
}

resource "aws_instance" "ec2" {
  for_each = {
    for inst in local.ec2_expanded_instances :
    inst.key => inst
  }

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = each.value.subnet_id
  key_name                    = each.value.key_name
  vpc_security_group_ids      = each.value.security_group_ids
  user_data                   = each.value.user_data
  iam_instance_profile        = each.value.iam_instance_profile
  associate_public_ip_address = each.value.associate_public_ip_address

  root_block_device {
    volume_size = each.value.root_volume_size
    volume_type = each.value.root_volume_type
  }

  tags = merge({
    Name = each.value.name
  }, each.value.tags)
}
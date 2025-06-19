# infra/shared/ec2/variables.tf

variable "ec2_instance_templates" {
  description = "Templates of EC2 instances with multiple subnets"
  type = map(object({
    name                        = string
    ami                         = string
    instance_type               = string
    subnet_ids                  = list(string)
    key_name                    = string
    security_group_ids          = list(string)
    user_data                   = optional(string)
    iam_instance_profile        = optional(string)
    associate_public_ip_address = optional(bool, false)
    root_volume_size            = optional(number, 8)
    root_volume_type            = optional(string, "gp3")
    tags                        = optional(map(string), {})
  }))
}
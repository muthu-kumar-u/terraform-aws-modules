# Terraform AWS Modules

This repository contains reusable Terraform modules for various AWS resources. These modules were originally implemented in a previous project and are now maintained here for easy reuse in future projects.

## Purpose

The goal of this repository is to:

- Maintain a clean, reusable set of AWS Terraform modules.
- Enable quick and consistent infrastructure setup in future projects.
- Avoid repeating common Terraform code.

## Modules Included

This repo currently includes modules for:

- VPC
- Subnets
- EC2
- S3 Buckets
- IAM Roles/Policies
- RDS
- Security Groups
- API Gateway
- CloudFront
- ElastiCache
- Lambda
- Route 53

> More modules may be added in the future as needed.  
> Feel free to customize or extend existing modules to fit your use cases.

## Usage

To use a module in your Terraform project:

```hcl
module "vpc" {
  source = "github.com/muthu-kumar-u/terraform-aws-modules//vpc"

  # Add required variables
}
```

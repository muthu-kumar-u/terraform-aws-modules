# infra/environments/prod/modules/elasticcahe/main.tf

# elasticache security group
resource "aws_security_group" "ElasticacheSG" {
  name        = "${var.identifier}-sg"
  description = var.elasticache_main_security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.lambda_sg_id != null ? [var.lambda_sg_id] : []
    content {
      description     = var.elasticache_main_security_group_description
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.identifier}-sg"
  })
}

# elasticache subnet group
resource "aws_elasticache_subnet_group" "ElasticacheSubnetGroup" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.private_subnets
  tags       = var.tags
}

# elasticache module
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = var.name
  create_cluster           = var.create_cluster
  create_replication_group = var.create_replication_group
  security_group_ids  = [aws_security_group.ElasticacheSG.id]
  security_group_use_name_prefix = var.elasticache_security_group_use_name_prefix

  engine          = var.cache_engine
  engine_version  = var.cluster_version
  node_type       = var.cluster_node_version
  apply_immediately = var.apply_immediately
  vpc_id = var.vpc_id

  subnet_group_name        = aws_db_subnet_group.ElasticacheSubnetGroup.name
  subnet_group_description = "${title(var.name)} subnet group"
  subnet_ids               = var.private_subnets

  create_parameter_group = var.create_parameter_group
  parameter_group_family = var.parameter_group_family

  tags = merge(var.tags, {
    Terraform   = var.cluster_tag_terraform
    Environment = var.environment
  })
}
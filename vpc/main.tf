# infra/shared/vpc/main.tf

# subnets
resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

# route tables
resource "aws_route_table" "this" {
  for_each = var.route_tables

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = each.value.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = {
    Name = each.value.name
  }
}

# route table association
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.this

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# vpc endpoints
resource "aws_vpc_endpoint" "this" {
  for_each    = var.vpc_endpoints
  vpc_id      = var.vpc_id
  service_name = each.value
}
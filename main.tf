resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  #instance_tenancy = "default" #aplica EC2 unicas para este usuario/customer, cool.
  enable_dns_hostnames = true
}

# SUBNETS
resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnets)
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
}

# PUBLIC CONFIG
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_eip" "nat_eip" {
  count      = length(var.public_subnets)
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_subnets)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  depends_on    = [aws_internet_gateway.internet_gateway]
}

# Private CONFIG

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  count  = length(var.private_subnets)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }
}

# RT assosiations

resource "aws_route_table_association" "public_subnets_rta" {
  count          = length(var.public_subnets)
  route_table_id = element(aws_route_table.public_rt[*].id, count.index)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

resource "aws_route_table_association" "private_subnets_rta" {
  count          = length(var.private_subnets)
  route_table_id = element(aws_route_table.private_rt[*].id, count.index)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}

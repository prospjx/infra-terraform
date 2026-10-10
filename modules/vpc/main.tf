resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "my_subnet"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "my_subnet_2"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My_IG"
  }
}

resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = "my_route_table"
  }
}

# Attach Route Table to both subnets
resource "aws_route_table_association" "sub1" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.myroutetable.id
}

resource "aws_route_table_association" "sub2" {
  subnet_id      = aws_subnet.my_subnet_2.id
  route_table_id = aws_route_table.myroutetable.id
}

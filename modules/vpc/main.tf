resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_subnet"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "my_subnet_2"
  }
}

resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My_IG"
  }
}

resource "aws_nat_gateway" "mynat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.my_subnet.id
}

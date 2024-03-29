terraform {
  required_providers {
    aws = {
      version = "= 5.6.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "example-vpc"
  }
}


resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
    tags = {
    Name = "igw"
  }
}


resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.example.id
  enable_resource_name_dns_a_record_on_launch = true
  cidr_block        = "10.0.48.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.example.id
  enable_resource_name_dns_a_record_on_launch = true
  cidr_block        = "10.0.64.0/20"
  availability_zone = "us-east-1b"
    tags = {
    Name = "public_subnet_b"
  }
}


resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.example.id
  enable_resource_name_dns_a_record_on_launch = true
  cidr_block        = "10.0.80.0/20"
  availability_zone = "us-east-1c"
  tags = {
    Name = "public_subnet_c"
  }
}


resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet_a"
  }
}


resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1b"
     tags = {
    Name = "private_subnet_b"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1c"
  tags = {
    Name = "private_subnet_c"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.example.id

    route {
    gateway_id = aws_internet_gateway.example.id
    cidr_block = "0.0.0.0/0"
  }

}

resource "aws_route_table_association" "public_route_table_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table_association" "private_route_table_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table_association" "private_route_table_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table_association" "private_route_table_association_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Allow ports 80, 443, 22, and 65535"
    tags = {
    Name = "example-security-group"
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 65535
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

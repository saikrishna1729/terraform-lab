resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpcCIDR
  tags = {
    Name = var.VPCName
  }
}

resource "aws_subnet" "subneta" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnetaCIDR
  availability_zone = var.AZ

  tags = {
    Name = "${join(",",[var.SNName, "-A"])}"
  }
}

resource "aws_subnet" "subnetb" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnetbCIDR
  availability_zone = var.AZ

  tags = {
    Name = "${join(",",[var.SNName, "-B"])}"
  }
}

resource "aws_security_group" "SG" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}
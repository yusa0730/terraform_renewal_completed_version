# VPC
resource "aws_vpc" "main" {
  cidr_block           = "11.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.project_name}-${var.env}-vpc"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# Subnet
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.0.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-public1-${var.region}a"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.1.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-public2-${var.region}c"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "protected_subnet" {
  count = length(var.subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[count.index].cidr_block
  availability_zone = "${var.region}${var.subnets[count.index].availability_zone}"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-${var.subnets[count.index].name_suffix}-${var.region}${var.subnets[count.index].availability_zone}"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.4.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-private1-${var.region}a"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.5.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-private2-${var.region}c"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

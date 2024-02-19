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

# resource "aws_subnet" "protected_subnet" {
#   count = length(var.subnets)

#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.subnets[count.index].cidr_block
#   availability_zone = "${var.region}${var.subnets[count.index].availability_zone}"

#   tags = {
#     Name      = "${var.project_name}-${var.env}-subnet-${var.subnets[count.index].name_suffix}-${var.region}${var.subnets[count.index].availability_zone}"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

resource "aws_subnet" "protected_subnet19" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.2.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-protected19-${var.region}a"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "protected_subnet20" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.3.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name      = "${var.project_name}-${var.env}-subnet-protected20-${var.region}c"
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

resource "aws_subnet" "mainte_public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "11.2.30.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name      = "${var.project_name}-${var.env}-mainte-public-a-sbn"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# ルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name      = "${var.project_name}-${var.env}-public-route-table"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "protected" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1c.id
  }
  tags = {
    Name      = "${var.project_name}-${var.env}-protected-route-table"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.env}-private-route-table"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.env}-internet-gateway"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# EIP
resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name      = "${var.project_name}-${var.env}-eip-natgw-1a"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_eip" "nat_1c" {
  vpc = true

  tags = {
    Name      = "${var.project_name}-${var.env}-eip-natgw-1c"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.nat_1a.id

  tags = {
    Name      = "${var.project_name}-${var.env}-nat-1a"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id     = aws_subnet.public_c.id
  allocation_id = aws_eip.nat_1c.id

  tags = {
    Name      = "${var.project_name}-${var.env}-nat-1c"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table_association" "protected" {
#   count          = length(aws_subnet.protected_subnet)
#   subnet_id      = aws_subnet.protected_subnet[count.index].id
#   route_table_id = aws_route_table.protected.id
# }

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "from_api_gateway_to_lambda_sg" {
  name        = "${var.env}-internal-public-lambda-sg"
  description = "${var.env}-internal-public-lambda-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws_batch_sg" {
  name        = "${var.project_name}-${var.env}-private-aws-batch-sg"
  description = "${var.project_name}-${var.env}-private-aws-batch-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-private-aws-batch-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "purchaseinfo_ecstask_sg" {
  name        = "${var.project_name}-${var.env}-purchaseinfo-ecs-sg"
  description = "${var.project_name}-${var.env}-purchaseinfo-ecs-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-purchaseinfo-ecs-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "app_lambda_sg" {
  name        = "${var.project_name}-${var.env}-applambda-sg"
  description = "${var.project_name}-${var.env}-applambda-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   from_port       = 3306
  #   to_port         = 3306
  #   protocol        = "TCP"
  #   security_groups = [aws_security_group.app_rds_sg.id]
  # }

  tags = {
    Name      = "${var.project_name}-${var.env}-applambda-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "mainte_ec2_sg" {
  name        = "${var.project_name}-${var.env}-mainte-sg"
  description = "${var.project_name}-${var.env}-mainte-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-mainte-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "app_rds_sg" {
  name        = "${var.project_name}-${var.env}-apprds-sg"
  description = "${var.project_name}-${var.env}-apprds-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "FROM AWS Batch sg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.aws_batch_sg.id]
  }

  ingress {
    description     = "(${var.project_name}-${var.env}-mainte-sg)"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.mainte_ec2_sg.id]
  }

  ingress {
    description     = "${var.project_name}-${var.env}-purchaseinfo-${var.env}"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.purchaseinfo_ecstask_sg.id]
  }

  ingress {
    description     = "(${var.project_name}-${var.env}-applambda-sg)"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.app_lambda_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-apprds-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "vpc_endpoint_ecr_sg" {
  name        = "${var.project_name}-${var.env}-vpc-endpoint-ecr-sg"
  description = "${var.project_name}-${var.env}-vpc-endpoint-ecr-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "FROM AWS Batch"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.aws_batch_sg.id]
  }

  ingress {
    description     = "purchaseinfo"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.purchaseinfo_ecstask_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-vpc-endpoint-ecr-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "vpc_endpoint_cloudwatch_logs_sg" {
  name        = "${var.project_name}-${var.env}-vpc-endpoint-cloudwatch-logs-sg"
  description = "${var.project_name}-${var.env}-vpc-endpoint-cloudwatch-logs-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "FROM AWS Batch"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.aws_batch_sg.id]
  }

  ingress {
    description     = "purchaseinfo"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.purchaseinfo_ecstask_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-vpc-endpoint-cloudwatch-logs-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "vpc_endpoint_ssm_sg" {
  name        = "${var.project_name}-${var.env}-vpc-endpoint-ssm-sg"
  description = "${var.project_name}-${var.env}-vpc-endpoint-ssm-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "FROM AWS Batch"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.aws_batch_sg.id]
  }

  ingress {
    description     = "purchaseinfo"
    from_port       = 443
    to_port         = 443
    protocol        = "HTTPS"
    security_groups = [aws_security_group.purchaseinfo_ecstask_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-vpc-endpoint-ssm-sg"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

### VPC Endpoint
# resource "aws_vpc_endpoint" "ecr_dkr" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ecr.dkr"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.protected_subnet[18].id, aws_subnet.protected_subnet[19].id]
#   security_group_ids  = [aws_security_group.vpc_endpoint_ecr_sg.id]
#   private_dns_enabled = true

#   tags = {
#     Name      = "${var.project_name}-${var.env}-endpoint-ecr-dkr"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ecr.api"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.protected_subnet[18].id, aws_subnet.protected_subnet[19].id]
#   security_group_ids  = [aws_security_group.vpc_endpoint_ecr_sg.id]
#   private_dns_enabled = true

#   tags = {
#     Name      = "${var.project_name}-${var.env}-endpoint-ecr-api"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint" "cloudwatch_logs" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.logs"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.protected_subnet[18].id, aws_subnet.protected_subnet[19].id]
#   security_group_ids  = [aws_security_group.vpc_endpoint_cloudwatch_logs_sg.id]
#   private_dns_enabled = true

#   tags = {
#     Name      = "${var.project_name}-${var.env}-endpoint-cloudwatch-logs"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint" "ssm" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ssm"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.protected_subnet[18].id, aws_subnet.protected_subnet[19].id]
#   security_group_ids  = [aws_security_group.vpc_endpoint_ssm_sg.id]
#   private_dns_enabled = true

#   tags = {
#     Name      = "${var.project_name}-${var.env}-endpoint-ssm"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint" "ssm_message" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ssmmessages"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.protected_subnet[18].id, aws_subnet.protected_subnet[19].id]
#   security_group_ids  = [aws_security_group.vpc_endpoint_ssm_sg.id]
#   private_dns_enabled = true

#   tags = {
#     Name      = "${var.project_name}-${var.env}-endpoint-ssmmessage"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint" "s3" {
#   vpc_id            = aws_vpc.main.id
#   service_name      = "com.amazonaws.${var.region}.s3"
#   vpc_endpoint_type = "Gateway"
#   route_table_ids   = [aws_route_table.protected.id]

#   tags = {
#     Name      = "${var.project_name}-${var.env}-vpce-s3"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

# resource "aws_vpc_endpoint_route_table_association" "protected_s3" {
#   route_table_id  = aws_route_table.protected.id
#   vpc_endpoint_id = aws_vpc_endpoint.s3.id
# }

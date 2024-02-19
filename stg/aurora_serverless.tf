resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.project_name}-${var.env}-appdb-clu01"
  availability_zones = [
    "${var.region}a",
    "${var.region}c",
    "${var.region}d",
  ]
  engine                       = "aurora-mysql"
  database_name                = var.project_name
  master_username              = data.aws_ssm_parameter.db_user.value
  master_password              = data.aws_ssm_parameter.db_password.value
  backup_retention_period      = 2
  preferred_backup_window      = "17:44-18:14"
  preferred_maintenance_window = "fri:17:00-fri:17:30"
  skip_final_snapshot          = true
  deletion_protection          = true
  vpc_security_group_ids = [
    aws_security_group.app_rds_sg.id
  ]
  db_subnet_group_name = aws_db_subnet_group.aurora_serverless_subnet_group.name
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_parameter_group.name
  enable_global_write_forwarding  = false

  serverlessv2_scaling_configuration {
    min_capacity = 1
    max_capacity = 1
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-aurora-cluster",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  identifier                 = "${var.project_name}-${var.env}-appdb01"
  cluster_identifier         = aws_rds_cluster.aurora_cluster.cluster_identifier
  instance_class             = "db.serverless"
  engine                     = "aurora-mysql"
  auto_minor_version_upgrade = false
  promotion_tier             = 1
  db_parameter_group_name    = aws_db_parameter_group.instance_parameter_group.name

  tags = {
    Name      = "${var.project_name}-${var.env}-appdb01",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_rds_cluster_instance" "reader" {
  identifier                 = "${var.project_name}-${var.env}-appdb01-reader"
  cluster_identifier         = aws_rds_cluster.aurora_cluster.cluster_identifier
  instance_class             = "db.serverless"
  engine                     = "aurora-mysql"
  auto_minor_version_upgrade = false
  promotion_tier             = 1
  db_parameter_group_name    = aws_db_parameter_group.instance_parameter_group.name

  tags = {
    Name      = "${var.project_name}-${var.env}-appdb01-reader",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_rds_cluster_instance" "reader02" {
  identifier                 = "${var.project_name}-${var.env}-appdb01-reader02"
  cluster_identifier         = aws_rds_cluster.aurora_cluster.cluster_identifier
  instance_class             = "db.serverless"
  engine                     = "aurora-mysql"
  auto_minor_version_upgrade = false
  promotion_tier             = 1
  db_parameter_group_name    = aws_db_parameter_group.instance_parameter_group.name

  tags = {
    Name      = "${var.project_name}-${var.env}-appdb01-reader02",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_db_subnet_group" "aurora_serverless_subnet_group" {
  name = "default-vpc-0c56345c89aa5461e"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]

  tags = {
    Name      = "default-vpc-0c56345c89aa5461e",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  name        = "${var.project_name}-${var.env}-rds-clu-parameter-g"
  description = "${var.project_name}-${var.env}-rds-clu-parameter-g"
  family      = "aurora-mysql8.0"

  parameter {
    apply_method = "immediate"
    name         = "character_set_client"
    value        = "utf8"
  }
  parameter {
    apply_method = "immediate"
    name         = "character_set_server"
    value        = "utf8"
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-rds-clu-parameter-g",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

resource "aws_db_parameter_group" "instance_parameter_group" {
  name        = "${var.project_name}-${var.env}-rds-parameter-g"
  description = "${var.project_name}-${var.env}-rds-parameter-g"
  family      = "aurora-mysql8.0"

  parameter {
    apply_method = "immediate"
    name         = "log_connections"
    value        = "1"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-rds-parameter-g",
    Env       = var.env,
    ManagedBy = "Terraform"
  }
}

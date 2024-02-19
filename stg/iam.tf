data "aws_caller_identity" "current" {}

# AWS Batch
resource "aws_iam_role" "batch_job_role" {
  name        = "${var.project_name}-${var.env}-batch-job-role"
  description = "${var.project_name}-${var.env}-batch-job-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        }
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-batch-job-role"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role" "batch_service_role" {
  name        = "${var.project_name}-${var.env}-batch-service-role"
  description = "${var.project_name}-${var.env}-batch-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "batch.amazonaws.com",
        }
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-batch-service-role"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role" "batch_execution_role" {
  name        = "${var.project_name}-${var.env}-batch-task-execution-role"
  description = "${var.project_name}-${var.env}-batch-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        }
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-batch-task-execution-role"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role" "event_bridge_batch_execution_role" {
  name        = "${var.project_name}-${var.env}-event-bridge-batch-execution-role"
  description = "${var.project_name}-${var.env}-event-bridge-batch-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "events.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "scheduler.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-event-bridge-batch-execution-role"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role" "event_bridge_pipe_role" {
  name = "Amazon_EventBridge_Pipe_${var.project_name}-${var.env}-purchase-info-eventbri_e3c17ed3"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "pipes.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" : "arn:aws:pipes:ap-northeast-1:${data.aws_caller_identity.current.account_id}:pipe/${var.project_name}-${var.env}-purchase-info-eventbridgepipes",
            "aws:SourceAccount" : "${data.aws_caller_identity.current.account_id}"
          }
        }
      }
    ]
  })

  tags = {
    Name      = "Amazon_EventBridge_Pipe_${var.project_name}-${var.env}-purchase-info-eventbri_e3c17ed3"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}


resource "aws_iam_policy" "batch_job_policy" {
  name        = "${var.project_name}-${var.env}-batch-job-policy"
  description = "${var.project_name}-${var.env}-batch-job-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ssmmessages:OpenDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:CreateControlChannel"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect = "Allow",
        "Resource" : "arn:aws:ecr:ap-northeast-1:${data.aws_caller_identity.current.account_id}:repository/*"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-batch-job-policy"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "execution_batch_job_policy" {
  name        = "${var.project_name}-${var.env}-batch-task-execution-policy"
  description = "${var.project_name}-${var.env}-batch-task-execution-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ssm:PutParameter",
          "ssm:DeleteParameter",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:DeleteParameters"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/dbuser",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/endpoint",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/pass",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/tmp/dbuser",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/tmp/endpoint",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/tmp/pass",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/user",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/password",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/host",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/rds/${var.env}/database",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/app/${var.env}/applicationId",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/app/${var.env}/secret",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/app/${var.env}/encodeIv",
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/app/${var.env}/encodeKey"
        ]
      },
      {
        Action = [
          "ssm:DescribeParameters"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-batch-task-execution-policy"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "event_bridge_batch_execution_policy" {
  name        = "${var.project_name}-${var.env}-event-bridge-batch-execution-policy"
  description = "${var.project_name}-${var.env}-event-bridge-batch-execution-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "batch:SubmitJob"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.env}-event-bridge-batch-execution-policy"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "ecs_pipe_target_template" {
  name = "EcsPipeTargetTemplate-2a79a1b7"
  path = "/service-role/"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecs:RunTask"
        ],
        Effect = "Allow",
        Resource = [
          "${aws_ecs_task_definition.purchaseinfo_taskdef.arn}:1:*",
          "${aws_ecs_task_definition.purchaseinfo_taskdef.arn}:1"
        ],
        Condition = {
          ArnLike = {
            "ecs:cluster" : "${aws_ecs_cluster.purchaseinfo.arn}"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
        Resource = "*",
        Condition = {
          StringLike = {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name      = "EcsPipeTargetTemplate-2a79a1b7"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

# resource "aws_iam_policy" "sqs_pipe_source_template" {
#   name = "SqsPipeSourceTemplate-68dcc2d6"
#   path = "/service-role/"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "sqs:ReceiveMessage",
#           "sqs:DeleteMessage",
#           "sqs:GetQueueAttributes"
#         ],
#         Effect   = "Allow",
#         Resource = data.aws_sqs_queue.tc_hello.arn
#       }
#     ]
#   })

#   tags = {
#     Name      = "SqsPipeSourceTemplate-68dcc2d6"
#     Env       = var.env
#     ManagedBy = "Terraform"
#   }
# }

data "aws_iam_policy" "s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "ecs_task_execution" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy" "sqs_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

data "aws_iam_policy" "cloudwatch_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

data "aws_iam_policy" "aws_batch_service_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

data "aws_iam_policy" "ecs_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

data "aws_iam_policy" "lambda_full_access" {
  arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "batch_job_policy_attachment" {
  role       = aws_iam_role.batch_job_role.name
  policy_arn = aws_iam_policy.batch_job_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_to_batch_job_role" {
  role       = aws_iam_role.batch_job_role.name
  policy_arn = data.aws_iam_policy.s3_full_access.arn
}

resource "aws_iam_role_policy_attachment" "batch_service_role" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = data.aws_iam_policy.aws_batch_service_role.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_to_batch_execution_role" {
  role       = aws_iam_role.batch_execution_role.name
  policy_arn = data.aws_iam_policy.ecs_task_execution.arn
}

resource "aws_iam_role_policy_attachment" "sqs_to_batch_execution_role" {
  role       = aws_iam_role.batch_execution_role.name
  policy_arn = data.aws_iam_policy.sqs_full_access.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_to_batch_execution_role" {
  role       = aws_iam_role.batch_execution_role.name
  policy_arn = data.aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_role_policy_attachment" "execution_batch_job_policy_attachment" {
  role       = aws_iam_role.batch_execution_role.name
  policy_arn = aws_iam_policy.execution_batch_job_policy.arn
}

resource "aws_iam_role_policy_attachment" "event_bridge_batch_execution_policy_attachment" {
  role       = aws_iam_role.event_bridge_batch_execution_role.name
  policy_arn = aws_iam_policy.event_bridge_batch_execution_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_full_access_to_eb_pipe_policy_attachment" {
  role       = aws_iam_role.event_bridge_pipe_role.name
  policy_arn = data.aws_iam_policy.ecs_full_access.arn
}

resource "aws_iam_role_policy_attachment" "lambda_full_access_to_eb_pipe_policy_attachment" {
  role       = aws_iam_role.event_bridge_pipe_role.name
  policy_arn = data.aws_iam_policy.lambda_full_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_pipe_target_template_to_eb_pipe_policy_attachment" {
  role       = aws_iam_role.event_bridge_pipe_role.name
  policy_arn = aws_iam_policy.ecs_pipe_target_template.arn
}

resource "aws_iam_role_policy_attachment" "sqs_pipe_source_template_to_eb_pipe_policy_attachment" {
  role       = aws_iam_role.event_bridge_pipe_role.name
  policy_arn = aws_iam_policy.sqs_pipe_source_template.arn
}

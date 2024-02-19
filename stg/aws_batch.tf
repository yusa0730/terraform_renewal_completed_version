# ## privateサブネットに設定するプッシュ通知用のバッチ設定
resource "aws_batch_compute_environment" "batch_compute_environment" {
  compute_environment_name = "${var.project_name}-${var.env}-private-compute-environment"
  compute_resources {
    type = "Fargate"
    subnets = [
      aws_subnet.aws_batch_private_a.id,
      aws_subnet.aws_batch_private_c.id,
    ]
    security_group_ids = [aws_security_group.push_notification_aws_batch_sg.id]
    max_vcpus          = 4
  }
  service_role = aws_iam_role.batch_service_role.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch]
}

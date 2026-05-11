output "app_role_arn"          { value = aws_iam_role.app.arn }
output "app_role_name"         { value = aws_iam_role.app.name }
output "gitlab_runner_role_arn" { value = aws_iam_role.gitlab_runner.arn }

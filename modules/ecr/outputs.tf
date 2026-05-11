output "repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}

output "registry_id" {
  value = length(aws_ecr_repository.repos) > 0 ? values(aws_ecr_repository.repos)[0].registry_id : ""
}

output "service_url" {
  value = google_cloud_run_v2_service.test_app.uri
}

output "github_actions_service_account_email" {
  value = google_service_account.github_actions.email
}

output "pool_name" {
  value       = module.github_actions_oidc.pool_name
  description = "GitHub Actions Workload Identity pool name"
}

output "provider_name" {
  value       = module.github_actions_oidc.provider_name
  description = "GitHub Actions Workload Identity provider name"
}

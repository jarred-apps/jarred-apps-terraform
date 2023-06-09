output "service_url" {
  value = google_cloud_run_v2_service.test_app.uri
}

output "github_actions_service_account_email" {
  value = google_service_account.github_actions.email
}

output "cloud_run_test_app_service_account" {
  value = google_service_account.cloud_run_test_app.email
}

output "workload_identity_pool_provider_name" {
  value       = google_iam_workload_identity_pool_provider.main.name
  description = "GitHub Actions Workload Identity provider name"
}

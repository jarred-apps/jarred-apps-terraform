# Service account used by GitHub actions
# The worload identity impersonates this service account
resource "google_service_account" "github_actions" {
  account_id   = "github-actions-service-account"
  display_name = "github-actions-service-account"
}

# Allow github-actions-service-account to impersonate cloud-run-service-account
resource "google_service_account_iam_member" "github_actions" {
  service_account_id = google_service_account.github_actions.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.github_actions.email}"
}

# Project level iam membership for github-actions-service-account
resource "google_project_iam_member" "github_actions" {
  project = var.project
  for_each = toset([
    "roles/run.admin",
    "roles/artifactregistry.writer"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

# Cloud run service account
resource "google_service_account" "cloud_run" {
  account_id   = "cloud-run-service-account"
  display_name = "cloud-run-service-account"
}

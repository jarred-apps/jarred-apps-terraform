# Setup artifact registry
resource "google_artifact_registry_repository" "this" {
  repository_id = "jarred-apps-docker-repo"
  description   = "Main Docker repo for jarred-apps"
  format        = "DOCKER"
  depends_on    = [google_project_service.this]
}

# resource "google_artifact_registry_repository_iam_member" "this" {
#   repository = google_artifact_registry_repository.this.repository_id
#   location   = google_artifact_registry_repository.this.location
#   role       = "roles/artifactregistry.writer"
#   member     = "serviceAccount:${google_service_account.test-app-service-account.email}"
# }

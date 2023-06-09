# Setup artifact registry
resource "google_artifact_registry_repository" "this" {
  repository_id = "jarred-apps-docker-repo"
  description   = "Main Docker repo for jarred-apps"
  format        = "DOCKER"
  depends_on    = [google_project_service.this]
}

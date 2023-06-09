# Setup workload identity pool and provider
# This needs to be run by a user or service account that has the following iam roles:
#   - roles/iam.workloadIdentityPoolAdmin
#   - roles/iam.serviceAccountAdmin

locals {
  workload_identity_pool_id     = "github-actions-wi-pool"
  workload_identity_provider_id = "github-actions-wi-provider"
}

resource "google_iam_workload_identity_pool" "main" {
  project                   = var.project
  workload_identity_pool_id = local.workload_identity_pool_id
  display_name              = local.workload_identity_pool_id
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "main" {
  project                            = var.project
  workload_identity_pool_id          = local.workload_identity_pool_id
  workload_identity_pool_provider_id = local.workload_identity_provider_id
  display_name                       = local.workload_identity_provider_id
  attribute_mapping = {
    "google.subject" : "assertion.sub",
    "attribute.actor" : "assertion.actor",
    "attribute.aud" : "assertion.aud",
    "attribute.repository_owner" : "assertion.repository_owner"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "github_actions_workload_identity_user" {
  service_account_id = google_service_account.github_actions.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.repository_owner/jarred-apps"
}

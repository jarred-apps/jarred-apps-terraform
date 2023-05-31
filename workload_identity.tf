# Setup workload identity pool and provider
# This needs to be run by a user or service account that has the following iam roles:
#   - roles/iam.workloadIdentityPoolAdmin
#   - roles/iam.serviceAccountAdmin
module "github_actions_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version     = "3.1.1"
  project_id  = var.project
  pool_id     = "github-actions-identity-pool"
  provider_id = "github-actions-identity-provider"
  attribute_mapping = {
    "attribute.actor" : "assertion.actor",
    "attribute.aud" : "assertion.aud",
    "attribute.repository" : "assertion.repository",
    "google.subject" : "assertion.sub",
    "attribute.repository_owner" : "assertion.repository_owner"
  }
  sa_mapping = {
    "github_actions" = {
      sa_name   = google_service_account.github_actions.id
      attribute = "attribute.repository_owner/jdglaser"
    }
  }
}

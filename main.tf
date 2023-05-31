terraform {
  required_version = ">= 0.12"
  backend "gcs" {
    bucket = "jarred-apps"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.66.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.66.0"
    }
  }
}

# Enable services
resource "google_project_service" "this" {
  for_each = toset([
    # IAM
    "iam.googleapis.com",
    # IAM Credentials
    "iamcredentials.googleapis.com",
    # Cloud Run
    "run.googleapis.com",
    # Artifcat Registry
    "artifactregistry.googleapis.com",
    # Cloud Resource Manager
    "cloudresourcemanager.googleapis.com",
    # Security Token Service
    "sts.googleapis.com"
  ])
  service = each.key
}

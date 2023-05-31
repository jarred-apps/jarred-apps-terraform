# Cloud run service test-app
resource "google_cloud_run_v2_service" "test_app" {
  name     = "test-app"
  location = "us-central1"

  template {
    max_instance_request_concurrency = 50
    timeout                          = "120s"
    service_account                  = google_service_account.cloud_run.email

    containers {
      image = "gcr.io/cloudrun/placeholder"
      ports {
        container_port = 8080
      }
      resources {
        limits = {
          # CPU usage limit
          # https:#cloud.google.com/run/docs/configuring/cpu
          cpu = "1000m" # 1 vCPU

          # Memory usage limit (per container)
          # https:#cloud.google.com/run/docs/configuring/memory-limits
          memory = "512Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  lifecycle {
    ignore_changes = [template[0].containers[0].image]
  }
}

# Give allUsers access to Cloud Run service
resource "google_cloud_run_v2_service_iam_member" "all-users" {
  location = google_cloud_run_v2_service.test_app.location
  name     = google_cloud_run_v2_service.test_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

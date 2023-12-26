# ----------------------------------------------------------------------------------------
#     Create a random string 
# ----------------------------------------------------------------------------------------

resource "random_string" "secret_value" {
  length  = 16
  special = true
}

# ----------------------------------------------------------------------------------------
#     Create a secret in GCP Secret Manager
# ----------------------------------------------------------------------------------------

resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "db-password-secret"

  labels = {
    secretmanager = "db_password"
  }

  replication {
    auto {}
  }
}

# ----------------------------------------------------------------------------------------
#     Create a version of our secret
# ----------------------------------------------------------------------------------------

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = random_string.secret_value.result
}


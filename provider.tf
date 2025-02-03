terraform {
  required_version = "= 1.4.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.1"
    }
  }

  backend "gcs" {}
}

provider "google" {
  credentials = "/Users/administrator/.config/gcloud/application_default_credentials.json"
  region = "us-central1"
}

resource "google_storage_bucket" "bucket" {
  name                        = var.name
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.bucket_policy_only
  labels                      = var.labels
  force_destroy               = var.force_destroy
  public_access_prevention    = var.public_access_prevention
  
  versioning {
    enabled = var.versioning
  }

  autoclass {
    enabled = var.autoclass
  }
}

resource "google_storage_bucket_object" "subfolder" {
  for_each = toset(var.subfolders)
  
  name    = "${each.value}/"
  content = "foo"
  bucket  = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_iam_member" "bucket_iam" {
  for_each = { for member in var.iam_members : member.member => member }

  bucket = google_storage_bucket.bucket.name
  role   = each.value.role
  member = each.value.member
}

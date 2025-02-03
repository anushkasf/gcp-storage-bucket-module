module "cloud_storage" {
  source                   = "./modules/storage-bucket"
  for_each                 = { for info in var.storage_bucket_info : info.name => info }
  name                     = each.value.name
  project_id               = each.value.project
  location                 = each.value.location
  storage_class            = each.value.storage_class
  bucket_policy_only       = each.value.uniform_bucket_level_access
  labels                   = each.value.labels
  force_destroy            = each.value.force_destroy
  public_access_prevention = each.value.public_access_prevention
  versioning               = each.value.versioning
  autoclass                = each.value.autoclass
  subfolders               = each.value.subfolders
  iam_members              = each.value.iam_members
}

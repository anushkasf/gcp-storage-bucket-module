output "bucket" {
  description = "The created storage bucket"
  value       = module.cloud_storage
}

output "name" {
  description = "Bucket name."
  value       = { for k, v in module.cloud_storage : k => v.name }
}

output "url" {
  description = "Bucket URL."
  value       = { for k, v in module.cloud_storage : k => v.url }
}

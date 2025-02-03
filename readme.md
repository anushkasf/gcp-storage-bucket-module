# Google Cloud Storage Bucket Module

This Terraform module provisions and manages Google Cloud Storage (GCS) buckets with configurable options, including IAM permissions, versioning, autoclass, and folder structures.

## Features
- Creates a GCS bucket with user-defined properties
- Configures IAM permissions for users and roles
- Supports bucket versioning and autoclass
- Allows creation of empty folders within the bucket

## Usage

```hcl
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
  iam_members              = each.value.iam_members
  subfolders               = each.value.subfolders
}
```

## Variables

| Name                        | Type   | Description |
|-----------------------------|--------|-------------|
| `name`                      | string | The name of the GCS bucket |
| `project_id`                | string | The Google Cloud project ID |
| `location`                  | string | The location of the bucket |
| `storage_class`             | string | The storage class (e.g., `STANDARD`, `NEARLINE`) |
| `bucket_policy_only`        | bool   | Enforce bucket policy only mode |
| `labels`                    | map(string) | Labels to assign to the bucket |
| `force_destroy`             | bool   | Allows the bucket to be destroyed without confirmation |
| `public_access_prevention`  | string | Enforce public access prevention (`enforced` or `inherited`) |
| `versioning`                | bool   | Enable or disable object versioning |
| `autoclass`                 | bool   | Enable or disable autoclass |
| `iam_members`               | list(object) | List of IAM members and roles |
| `subfolders`                | list(string) | List of empty folders to create |

## IAM Permissions Example

To assign IAM permissions to users:

```hcl
iam_members = [
  {
    member = "test@gmail.com"
    role   = "roles/storage.admin"
  }
]
```

## Creating Empty Folders

To create empty folders inside the bucket:

```hcl
subfolders = ["dev", "qa"]
```

## Outputs

| Name   | Description |
|--------|-------------|
| `bucket_name` | The name of the created GCS bucket |
| `bucket_url`  | The URL of the GCS bucket |

## Storing Terraform State in GCS

To store the Terraform state in a remote GCS bucket (`syy-cx-shop-np-terraform-state`):

```hcl
terraform {
  backend "gcs" {
    bucket      = "syy-cx-np-terraform-state"
    prefix      = "terraform/devops-state/gcp-bucket-state"
  }
}
```

Add credentials path when It run by local terminal
```
provider "google" {
  credentials = "</path/to/application_default_credentials.json>"
  region = "us-central1"
}
```

Then, initialize Terraform:

```sh
terraform init -backend-config=vars/nonprod/backend.hcl
terraform plan -var-file vars/nonprod/vars.tfvars.json
terraform apply -var-file vars/nonprod/vars.tfvars.json
```
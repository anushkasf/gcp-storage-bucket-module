# variable "storage_bucket_info" {
#   type = any
# }

variable "storage_bucket_info" {
  type = list(object({
    name                        = string
    project                     = string
    location                    = string
    storage_class               = string
    uniform_bucket_level_access = bool
    labels                      = map(string)
    force_destroy               = bool
    public_access_prevention    = string
    versioning                  = bool
    autoclass                   = bool
    subfolders                  = list(string)  # List of subfolders
    iam_members                 = list(object({
                                    member = string
                                    role  = string}))
  }))
  default = []
}
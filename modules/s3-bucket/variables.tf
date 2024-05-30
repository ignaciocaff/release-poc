variable "environment" {
  type        = string
  description = "the environment this database will support"

  validation {
    condition     = can(regex("^(beta|gamma|production)$", var.environment))
    error_message = "Environment must be in [beta|gamma|production]."
  }
}

variable "aws_account_id" {
  description = "The AWS account id which will count as the bucket owner."
  type        = string
}

variable "team_name" {
  description = "Team Directory team name, note that this will be validated and fail if not found"
  type        = string
}

variable "bucket_name" {
  description = "Final bucket name is compass-<env>-<bucket_name>"
  type        = string

  validation {
    condition     = lower(var.bucket_name) == var.bucket_name
    error_message = "Bucket name must be lower case."
  }
  validation {
    condition     = replace(var.bucket_name, "_", "-") == var.bucket_name
    error_message = "Bucket name must only use - for separator."
  }
  validation {
    condition     = can(regex("^[a-z0-9-]*$", var.bucket_name))
    error_message = "Bucket name should be kebab-case."
  }
}

variable "override_bucket_name_enable" {
  description = "Boolean to determine whether we want to override the default bucket name pattern compass-<env>-<bucket_name>. Enables override_bucket_name"
  type        = bool
  default     = false
}

variable "override_bucket_name" {
  description = "Overrides bucket name compass-<env>-<bucket_name>. Don't override without good reason."
  type        = string
  default     = ""
}

variable "description" {
  description = "Describe your bucket in a sentence or two."
  type        = string
}

variable "stores_pii" {
  description = "Bucket stores Personally Identifiable Information"
  type        = bool
}

variable "data_classification" {
  description = "Data classification of the data stored in your resource, used for security and audit purposes. You can find a description of each tier at https://compass-tech.atlassian.net/wiki/spaces/ENG/pages/967344591/Data+Classification"
  type        = string
  validation {
    condition = (
      contains(["public", "internal", "sensitive", "confidential"], var.data_classification)
    )
    error_message = "Data Classification must be one of [public|internal|sensitive|confidential]."
  }
}

variable "public_bucket" {
  description = "Bucket is publicly available on the internet. Currently not supported."
  type        = bool
  default     = false
  validation {
    condition     = var.public_bucket == false
    error_message = "Public buckets are currently not supported."
  }
}

variable "logs_enabled" {
  description = "Enable S3 bucket access logs"
  type        = bool
  default     = false
}

variable "logs_bucket_id" {
  description = "Provide an S3 bucket id to enable s3 access logs"
  type        = string
  default     = null
}

variable "logs_path_prefix" {
  description = "The path inside the bucket to store the logs"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "whether to force destroy the bucket emptying it in the process"
  type        = bool
  default     = false
}
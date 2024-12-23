variable "percentile" {
  description = "The percentile of latency to monitor, (p50,p75,p95,p99)"
  type        = string
  default     = "p99"

  validation {
    condition = (
      contains(["p50", "p75", "p95", "p99"], var.percentile)
    )
    error_message = "Percentile must be one of [p50,p75,p95,p99]."
  }
}

variable "eval_minutes" {
  description = "The time period in minutes to evaluate, [1, 5, 10]"
  type        = number
  default     = 5

  validation {
    condition = (
      contains([1, 5, 10], var.eval_minutes)
    )
    error_message = "Must be of selection 1,5 or 10 minutes."
  }
}

variable "tolerance_seconds" {
  description = "The number of seconds for the query at which to alert"
  type        = string
  default     = 10.0

  validation {
    condition = (
      var.tolerance_seconds > 0
    )
    error_message = "Alert tolerance should be higher than zero."
  }
}

variable "resource_name" {
  description = "Name of resource, e.g. grpc endpoint to monitor, defaults to entire service"
  type        = string
  default     = "*"
}

variable "service_name" {
  description = "The name of the service to monitor"
  type        = string
}

variable "service_display_name" {
  description = "The name of the service to monitor that is displayed in Datadog"
  type        = string
}

variable "service_entrypoint" {
  description = "The entrypoint of the service to monitor"
  type        = string
}

variable "service_separate_endpoints" {
  description = "The endpoints of the service to monitor separate in objects"
  type = list(object({
    name                  = string
    p99_latency_tolerance = number
  }))
  default = []
}

variable "team_name" {
  description = "Team Directory team name, note that this will be validated and fail if not found"
  type        = string
}

variable "priority" {
  description = "Priority to alert monitor on"
  type        = string
  default     = "p3"

  validation {
    condition = (
      substr(var.priority, 0, 1) == "p"
    )
    error_message = "Alert priority should start with p."
  }
  validation {
    condition = (
      contains([1, 2, 3, 4], tonumber(substr(var.priority, 1, 2)))
    )
    error_message = "Alert priority should be p4-p1"
  }
}

variable "extra_tags" {
  description = "A map of additional tags to apply"
  type        = map(any)
  default     = {}
}

variable "include_service_health_endpoint" {
  description = "Include the service health endpoint in latency p99 monitor"
  type        = bool
  default     = true
}

variable "opsgenie_handle" {
  description = "The opsgenie handle to alert if the monitor fails, e.g. '@opsgenie-foundational-infrastructure'"
  type        = string
}

variable "debug" {
  description = "Set to true to temporarily disable slack and opsgenie notifications"
  type        = bool
  default     = false
}

variable "renotify_interval" {
  description = "Number of minutes after the last notification before a monitor will re-notify on the current status"
  type        = number
  default     = 0
}

variable "renotify_two" {
  description = "Testing all"
  type        = number
  default     = 0
}

#minor on datadog with scope


# Testing minor commit first sd


# testing patch last b333434343


# fixing the fixing
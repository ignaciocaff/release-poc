# Is this working?
variable "zone_id" {
  description = "The ID of the hosted zone."
  type        = string
}

variable "name" {
  description = "The name of the DNS record."
  type        = string
}

variable "type" {
  description = "The DNS record type."
  type        = string
}

variable "ttl" {
  description = "The TTL of the DNS record. Not used for alias records."
  type        = number
  default     = 300
}

variable "records" {
  description = "The DNS record values. Not used for alias records."
  type        = list(string)
  default     = []
}

variable "alias" {
  description = "The alias block. Optional."
  type = object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
  })
  default = null
}

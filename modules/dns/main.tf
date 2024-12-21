# Should trigger the complete process for DNS and tag this
resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = var.name

  records = var.alias == null ? var.records : null
  ttl     = var.alias == null ? var.ttl : null

  dynamic "alias" {
    for_each = var.alias != null ? [var.alias] : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}

# Means a new dns module

# Now im going to try a minor
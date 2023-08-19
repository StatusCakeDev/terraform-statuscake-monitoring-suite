locals {
  status_codes = ["204", "205", "206", "303", "400", "401", "402", "403", "404", "405", "406", "408", "410", "413", "444", "429", "494", "495", "496", "499", "500", "501", "502", "503", "504", "505", "506", "507", "508", "509", "510", "511", "520", "521", "522", "523", "524", "598", "599"]
}

resource "statuscake_pagespeed_check" "pagespeed_check" {
  name           = var.check_name
  paused         = var.paused
  check_interval = var.pagespeed_config.check_interval
  region         = var.pagespeed_config.region

  contact_groups = var.contact_groups

  alert_config {
    alert_bigger  = var.pagespeed_config.alert_bigger
    alert_slower  = var.pagespeed_config.alert_slower
    alert_smaller = var.pagespeed_config.alert_smaller
  }

  monitored_resource {
    address = var.website_url
  }
}

resource "statuscake_ssl_check" "ssl_check" {
  paused           = var.paused
  user_agent       = var.user_agent
  check_interval   = var.ssl_config.check_interval
  follow_redirects = var.ssl_config.follow_redirects

  contact_groups = var.contact_groups

  alert_config {
    alert_at = var.ssl_config.alert_at

    on_reminder = var.ssl_config.on_reminder
    on_expiry   = var.ssl_config.on_expiry
    on_broken   = var.ssl_config.on_broken
    on_mixed    = var.ssl_config.on_mixed
  }

  monitored_resource {
    address = var.website_url
  }
}

resource "statuscake_uptime_check" "uptime_check" {
  name           = var.check_name
  paused         = var.paused
  check_interval = var.uptime_config.check_interval
  confirmation   = var.uptime_config.confirmation
  trigger_rate   = var.uptime_config.trigger_rate

  http_check {
    enable_cookies   = var.uptime_config.enable_cookies
    follow_redirects = var.uptime_config.follow_redirects
    final_endpoint   = var.uptime_config.final_endpoint
    timeout          = var.uptime_config.timeout
    user_agent       = var.user_agent
    validate_ssl     = var.uptime_config.validate_ssl

    request_headers     = var.uptime_config.request_headers
    request_method      = var.uptime_config.request_method
    request_payload     = var.uptime_config.request_payload
    request_payload_raw = var.uptime_config.request_payload_raw

    status_codes = coalesce(var.uptime_config.status_codes, local.status_codes)
  }

  monitored_resource {
    address = var.website_url
  }

  contact_groups = var.contact_groups
  regions        = var.uptime_config.regions
  tags           = var.uptime_config.tags
}

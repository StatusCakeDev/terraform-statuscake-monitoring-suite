resource "statuscake_pagespeed_check" "pagespeed_check" {
  name           = var.check_name
  paused         = var.paused
  check_interval = var.pagespeed_check_interval
  region         = var.pagespeed_region

  contact_groups = var.contact_groups

  alert_config {
    alert_bigger  = var.pagespeed_alert_bigger
    alert_slower  = var.pagespeed_alert_slower
    alert_smaller = var.pagespeed_alert_smaller
  }

  monitored_resource {
    address = var.website_url
  }
}

resource "statuscake_ssl_check" "ssl_check" {
  paused           = var.paused
  user_agent       = var.user_agent
  check_interval   = var.ssl_check_interval
  follow_redirects = var.ssl_follow_redirects

  contact_groups = var.contact_groups

  alert_config {
    alert_at = var.ssl_alert_at

    on_reminder = var.ssl_on_reminder
    on_expiry   = var.ssl_on_expiry
    on_broken   = var.ssl_on_broken
    on_mixed    = var.ssl_on_mixed
  }

  monitored_resource {
    address = var.website_url
  }
}

resource "statuscake_uptime_check" "uptime_check" {
  name           = var.check_name
  paused         = var.paused
  check_interval = var.uptime_check_interval
  confirmation   = var.uptime_confirmation
  trigger_rate   = var.uptime_trigger_rate

  http_check {
    enable_cookies   = var.uptime_enable_cookies
    follow_redirects = var.uptime_follow_redirects
    final_endpoint   = var.uptime_final_endpoint
    timeout          = var.uptime_timeout
    user_agent       = var.user_agent
    validate_ssl     = var.uptime_validate_ssl

    request_headers     = var.uptime_request_headers
    request_method      = var.uptime_request_method
    request_payload     = var.uptime_request_payload
    request_payload_raw = var.uptime_request_payload_raw

    status_codes = var.uptime_status_codes
  }

  monitored_resource {
    address = var.website_url
  }

  contact_groups = var.contact_groups
  regions        = var.uptime_regions
  tags           = var.uptime_tags
}

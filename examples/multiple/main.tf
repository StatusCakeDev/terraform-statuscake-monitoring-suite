locals {
  websites = {
    StatusCake = {
      website_url    = "https://www.statuscake.com"
      uptime_regions = ["london", "paris", "frankfurt"]
    }
    Google = {
      website_url      = "https://www.google.com"
      pagespeed_region = "US"
      ssl_on_mixed     = false
      uptime_regions   = ["california", "texas"]
    }
  }
}

# Create an HTTP uptime check, a pagespeed check, and an SSL check for each
# website contained in the local `websites` variable.
module "monitoring_suite" {
  for_each    = local.websites
  source      = "StatusCakeDev/monitoring-suite/statuscake"
  version     = "0.1.0"
  check_name  = each.key
  website_url = each.value.website_url

  pagespeed_config = {
    check_interval = lookup(each.value, "pagespeed_check_interval", 1800)
    region         = lookup(each.value, "pagespeed_region", "UK")
  }

  ssl_check = {
    check_interval = lookup(each.value, "ssl_check_interval", 86400)
    on_mixed       = lookup(each.value, "ssl_on_mixed", false)
  }

  uptime_config = {
    check_interval = lookup(each.value, "uptime_check_interval", 60)
    confirmation   = lookup(each.value, "uptime_confirmation", 2)
    regions        = lookup(each.value, "uptime_regions", [])
    request_method = lookup(each.value, "uptime_request_method", "HTTP")
    status_codes   = lookup(each.value, "uptime_status_codes", ["301"])
    trigger_rate   = lookup(each.value, "uptime_trigger_rate", 30)
    validate_ssl   = lookup(each.value, "uptime_ssl", true)
  }
}

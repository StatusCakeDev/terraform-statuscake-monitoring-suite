resource "statuscake_contact_group" "operations_team" {
  name = "Operations Team"

  email_addresses = [
    "johnsmith@example.com",
    "janesmith@example.com",
  ]
}

resource "statuscake_contact_group" "development_team" {
  name = "Development Team"

  email_addresses = [
    "developers@example.com",
  ]
}

# Create an HTTP uptime check, a pagespeed check, and an SSL check for a single
# website, alerting both contact groups.
module "monitoring_suite" {
  source      = "StatusCakeDev/monitoring-suite/statuscake"
  version     = "0.2.1"
  check_name  = "Google"
  website_url = "https://www.google.com"

  contact_groups = [
    statuscake_contact_group.development_team.id,
    statuscake_contact_group.operations_team.id,
  ]

  pagespeed_config = {
    check_interval = 1800
    region         = "UK"
  }

  ssl_config = {
    check_interval = 86400
    on_mixed       = false
  }

  uptime_config = {
    check_interval = 60
    confirmation   = 2
    regions        = ["london", "new-york", "singapore"]
    request_method = "HTTP"
    status_codes   = ["301"]
    trigger_rate   = 30
    validate_ssl   = true
  }
}

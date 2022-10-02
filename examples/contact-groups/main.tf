provider "statuscake" {}

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

# Create an HTTP uptime check, a pagespeed check, and an SSL check for each
# website contained in the local `websites` variable.
module "monitoring_suite" {
  source  = "StatusCakeDev/monitoring-suite/statuscake"
  version = "0.1.0"

  check_name  = "Google"
  website_url = "https://www.google.com"

  pagespeed_check_interval = 1800
  pagespeed_region         = "UK"

  ssl_check_interval = 86400
  ssl_on_mixed       = false

  uptime_check_interval = 60
  uptime_confirmation   = 2
  uptime_trigger_rate   = 30
  uptime_request_method = "HTTP"
  uptime_status_codes   = ["301"]
  uptime_validate_ssl   = true
  uptime_regions        = ["london"]

  contact_groups = [
    statuscake_contact_group.operations_team.id,
    statuscake_contact_group.operations_team.id,
  ]
}

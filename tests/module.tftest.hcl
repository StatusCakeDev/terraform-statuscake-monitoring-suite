mock_provider "statuscake" {}

variables {
  check_name  = "Example"
  website_url = "https://www.example.com"
}

run "defaults" {
  command = plan

  assert {
    condition     = statuscake_uptime_check.uptime_check.name == "Example" && statuscake_pagespeed_check.pagespeed_check.name == "Example"
    error_message = "The uptime and pagespeed checks should be named after `check_name`."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.monitored_resource[0].address == "https://www.example.com",
      statuscake_pagespeed_check.pagespeed_check.monitored_resource[0].address == "https://www.example.com",
      statuscake_ssl_check.ssl_check.monitored_resource[0].address == "https://www.example.com",
    ])
    error_message = "Every check should monitor `website_url`."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.check_interval == 1800,
      statuscake_uptime_check.uptime_check.confirmation == 2,
      statuscake_uptime_check.uptime_check.http_check[0].request_method == "HTTP",
      statuscake_uptime_check.uptime_check.http_check[0].timeout == 15,
      statuscake_uptime_check.uptime_check.paused == false,
    ])
    error_message = "The uptime check defaults have changed."
  }

  assert {
    condition = alltrue([
      statuscake_pagespeed_check.pagespeed_check.check_interval == 86400,
      statuscake_pagespeed_check.pagespeed_check.region == "UK",
      statuscake_pagespeed_check.pagespeed_check.alert_config[0].alert_bigger == 0,
      statuscake_pagespeed_check.pagespeed_check.alert_config[0].alert_slower == 0,
      statuscake_pagespeed_check.pagespeed_check.alert_config[0].alert_smaller == 0,
    ])
    error_message = "The pagespeed check defaults have changed."
  }

  assert {
    condition = alltrue([
      statuscake_ssl_check.ssl_check.check_interval == 86400,
      statuscake_ssl_check.ssl_check.alert_config[0].alert_at == toset([1, 7, 30]),
      statuscake_ssl_check.ssl_check.alert_config[0].on_broken == true,
      statuscake_ssl_check.ssl_check.alert_config[0].on_expiry == true,
      statuscake_ssl_check.ssl_check.alert_config[0].on_mixed == true,
      statuscake_ssl_check.ssl_check.alert_config[0].on_reminder == true,
    ])
    error_message = "The SSL check defaults have changed."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.contact_groups == null,
      statuscake_pagespeed_check.pagespeed_check.contact_groups == null,
      statuscake_ssl_check.ssl_check.contact_groups == null,
    ])
    error_message = "No contact groups should be set unless they are given."
  }
}

run "shared_settings_reach_every_check" {
  command = plan

  variables {
    contact_groups = ["1", "2"]
    paused         = true
    user_agent     = "terraform-test"
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.contact_groups == toset(["1", "2"]),
      statuscake_pagespeed_check.pagespeed_check.contact_groups == toset(["1", "2"]),
      statuscake_ssl_check.ssl_check.contact_groups == toset(["1", "2"]),
    ])
    error_message = "`contact_groups` should be set on every check."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.paused,
      statuscake_pagespeed_check.pagespeed_check.paused,
      statuscake_ssl_check.ssl_check.paused,
    ])
    error_message = "`paused` should be set on every check."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.http_check[0].user_agent == "terraform-test",
      statuscake_ssl_check.ssl_check.user_agent == "terraform-test",
    ])
    error_message = "`user_agent` should be set on the uptime and SSL checks."
  }
}

run "uptime_config_is_passed_through" {
  command = plan

  variables {
    uptime_config = {
      check_interval   = 60
      confirmation     = 3
      follow_redirects = true
      regions          = ["london", "paris"]
      request_headers  = { Accept = "text/html" }
      request_method   = "HEAD"
      status_codes     = [301, 404]
      tags             = ["production"]
      trigger_rate     = 10
      validate_ssl     = true
    }
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.check_interval == 60,
      statuscake_uptime_check.uptime_check.confirmation == 3,
      statuscake_uptime_check.uptime_check.trigger_rate == 10,
      statuscake_uptime_check.uptime_check.tags == toset(["production"]),
      statuscake_uptime_check.uptime_check.regions == tolist(["london", "paris"]) || statuscake_uptime_check.uptime_check.regions == tolist(["paris", "london"]),
    ])
    error_message = "The uptime check settings were not passed through."
  }

  assert {
    condition = alltrue([
      statuscake_uptime_check.uptime_check.http_check[0].follow_redirects == true,
      statuscake_uptime_check.uptime_check.http_check[0].request_method == "HEAD",
      statuscake_uptime_check.uptime_check.http_check[0].request_headers["Accept"] == "text/html",
      statuscake_uptime_check.uptime_check.http_check[0].status_codes == toset(["301", "404"]),
      statuscake_uptime_check.uptime_check.http_check[0].validate_ssl == true,
    ])
    error_message = "The HTTP check settings were not passed through."
  }
}

run "a_raw_payload_may_be_given_alone" {
  command = plan

  variables {
    uptime_config = {
      request_payload_raw = "key=value"
    }
  }
}

run "a_payload_may_be_given_as_a_map" {
  command = plan

  variables {
    uptime_config = {
      request_payload = { key = "value" }
    }
  }
}

run "both_payloads_are_rejected" {
  command = plan

  variables {
    uptime_config = {
      request_payload     = { key = "value" }
      request_payload_raw = "key=value"
    }
  }

  expect_failures = [var.uptime_config]
}

run "an_unknown_request_method_is_rejected" {
  command = plan

  variables {
    uptime_config = {
      request_method = "POST"
    }
  }

  expect_failures = [var.uptime_config]
}

run "ssl_alerts_need_exactly_three_days" {
  command = plan

  variables {
    ssl_config = {
      alert_at = [1, 7]
    }
  }

  expect_failures = [var.ssl_config]
}

run "ssl_alert_days_must_be_distinct" {
  command = plan

  variables {
    ssl_config = {
      alert_at = [7, 7, 30]
    }
  }

  expect_failures = [var.ssl_config]
}

run "outputs_are_the_check_ids" {
  command = apply

  assert {
    condition = alltrue([
      output.uptime_check_id == statuscake_uptime_check.uptime_check.id,
      output.pagespeed_check_id == statuscake_pagespeed_check.pagespeed_check.id,
      output.ssl_check_id == statuscake_ssl_check.ssl_check.id,
      output.uptime_check_id != "",
    ])
    error_message = "Each output should be the ID of its check."
  }
}

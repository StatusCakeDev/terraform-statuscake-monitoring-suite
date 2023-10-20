# terraform-statuscake-monitoring-suite ![policy](https://github.com/StatusCakeDev/terraform-statuscake-monitoring-suite/workflows/policy/badge.svg)

This repository implements a Terraform module to create a complete StatusCake
monitoring suite for a specific website URL.

It supports creating:

- An HTTP uptime check
- A Pagespeed check
- An SSL check

## Usage

See the [examples](examples) directory for working examples for reference:

```hcl
module "monitoring_suite" {
  source  = "StatusCakeDev/monitoring-suite/statuscake"
  version = "0.2.0"

  check_name  = "Google"
  website_url = "https://www.google.com"
}
```

## Examples

- [basic](examples/basic) - Create an HTTP uptime, Pagespeed, and SSL check for
  a single URL.
- [contact-groups](examples/contact-groups) - Create checks and associate a
  contact group.
- [multiple](examples/multiple) - Create multiple groups of checks for a list of
  URLs.

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| [statuscake](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest) | >= 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [`statuscake_pagespeed_check.pagespeed_check`](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs/resources/pagespeed_check) | resource |
| [`statuscake_ssl_check.ssl_check`](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs/resources/ssl_check) | resource |
| [`statuscake_uptime_check.uptime_check`](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs/resources/uptime_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `check_name` | The name of the checks created | `string` | | yes |
| `website_url` | The URL of the website being monitored by the checks | `string` | | yes |
| `contact_groups` | A list of contact group IDs | `set(string)` | `null` | no |
| `pagespeed_config` | Configuration for the pagespeed check | `object{...}` | `{}` | no |
| `pagespeed_config.alert_bigger` |  An alert will be sent if the size of the page is larger than this value (kb) | `number` | `0` | no |
| `pagespeed_config.alert_slower` |  An alert will be sent if the load time of the page exceeds this value (ms) | `number` | `0` | no |
| `pagespeed_config.alert_smaller` | An alert will be sent if the size of the page is smaller than this value (kb) | `number` | `0` | no |
| `pagespeed_config.check_interval` | The number of seconds between pagespeed checks | `number` | `86400` | no |
| `pagespeed_config.region` | The region on which to run checks | `string` | `UK` | no |
| `paused` | Wheather the checks shoudl be run | `bool` | `false` | no |
| `ssl_config` | Configuration for the SSL check | `object{...}` | `{}` | no |
| `ssl_config.alert_at` | A list representing when alerts should be sent (days). Must be exactly 3 numerical values | `set(number)` | `[1, 7, 30]` | no |
| `ssl_config.check_interval` | The number of seconds between SSL checks | `number` | `86400` | no |
| `ssl_config.follow_redirects` | Whether to follow redirects when testing | `bool` | `false` | no |
| `ssl_config.on_broken` | Whether to enable alerts when SSL certificate issues are found | `bool` | `true` | no |
| `ssl_config.on_expiry` | Whether to enable alerts when the SSL certificate is to expire | `bool` | `true` | no |
| `ssl_config.on_mixed` | Whether to enable alerts when mixed content is found | `bool` | `true` | no |
| `ssl_config.on_reminder` | Whether to enable alert reminders | `bool` | `true` | no |
| `uptime_config` | Configuration for the uptime check | `object{...}` | `{}` | no |
| `uptime_config.check_interval` | The number of seconds between uptime checks | `number` | `1800` | no |
| `uptime_config.confirmation` | The number of confirmation servers to confirm downtime before an alert is triggered | `number` | `2` | no |
| `uptime_config.enable_cookies` | Whether to enable cookie storage | `bool` | `false` | no |
| `uptime_config.final_endpoint` | The URL upon where the redirect chain should end | `string` | `null` | no |
| `uptime_config.follow_redirects` |  Whether to follow redirects when testing | `bool` | `false` | no |
| `uptime_config.regions` | A list of regions on which to run checks. The values required for this parameter can be retrieved from the `GET /v1/uptime-locations` endpoint | `set(string)` | `null` | no |
| `uptime_config.request_headers` | Represents headers to be sent when making requests | `map(string)` | `null` | no |
| `uptime_config.request_method` | The type of HTTP check. Possible values are `HTTP` and `HEAD` | `string` | `HTTP` | no |
| `uptime_config.request_payload_raw` | Raw payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified | `string` | `null` | no |
| `uptime_config.request_payload` | Payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified | `map(string)` | `null` | no |
| `uptime_config.status_codes` | A list of status codes that trigger an alert | `set(number)` | `[default codes...]` | no |
| `uptime_config.tags` | A list of tags to apply to the check | `set(string)` | `null` | no |
| `uptime_config.timeout` | The number of seconds to wait for a response before timing out | `number` | `15` | no |
| `uptime_config.trigger_rate` | The number of minutes to wait before sending an alert | `number` | `null` | no |
| `uptime_config.validate_ssl` | Whether to validate SSL certificates | `bool` | `false` | no |
| `user_agent` | A custom user agent string set when testing | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `pagespeed_check_id` | The ID of the pagespeed check |
| `ssl_check_id` | The ID of the SSL check |
| `uptime_check_id` | The ID of the uptime check |

## License

This project is licensed under the [Mozilla Public License](LICENSE).

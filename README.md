# terraform-statuscake-monitoring-suite [![terraform](https://github.com/StatusCakeDev/terraform-statuscake-monitoring-suite/actions/workflows/terraform.yaml/badge.svg?event=push)](https://github.com/StatusCakeDev/terraform-statuscake-monitoring-suite/actions/workflows/terraform.yaml)

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
  version = "0.2.1"

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

<!-- BEGIN_TF_DOCS -->
<!-- pyml disable md013,md022,md033 -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_statuscake"></a> [statuscake](#requirement\_statuscake) | >= 2.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_statuscake"></a> [statuscake](#provider\_statuscake) | >= 2.3.0 |

## Resources

| Name | Type |
|------|------|
| [statuscake_pagespeed_check.pagespeed_check](https://registry.terraform.io/providers/statuscakedev/statuscake/latest/docs/resources/pagespeed_check) | resource |
| [statuscake_ssl_check.ssl_check](https://registry.terraform.io/providers/statuscakedev/statuscake/latest/docs/resources/ssl_check) | resource |
| [statuscake_uptime_check.uptime_check](https://registry.terraform.io/providers/statuscakedev/statuscake/latest/docs/resources/uptime_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_check_name"></a> [check\_name](#input\_check\_name) | The name of the checks created. | `string` | n/a | yes |
| <a name="input_website_url"></a> [website\_url](#input\_website\_url) | The URL of the website being monitored by the checks. | `string` | n/a | yes |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | A list of contact group IDs. | `set(string)` | `null` | no |
| <a name="input_pagespeed_config"></a> [pagespeed\_config](#input\_pagespeed\_config) | Configuration for the pagespeed check.<br/><br/>(Optional) alert\_bigger - An alert will be sent if the size of the page is larger than this value (kb). Disabled by default.<br/>(Optional) alert\_slower - An alert will be sent if the load time of the page exceeds this value (ms). Disabled by default.<br/>(Optional) alert\_smaller - An alert will be sent if the size of the page is smaller than this value (kb). Disabled by default.<br/>(Optional) check\_interval - The number of seconds between pagespeed checks. Default value is 86400.<br/>(Optional) region - The region on which to run checks. Default value is `UK`. | <pre>object({<br/>    alert_bigger   = optional(number, 0)<br/>    alert_slower   = optional(number, 0)<br/>    alert_smaller  = optional(number, 0)<br/>    check_interval = optional(number, 86400)<br/>    region         = optional(string, "UK")<br/>  })</pre> | `{}` | no |
| <a name="input_paused"></a> [paused](#input\_paused) | Whether the checks should be run. | `bool` | `false` | no |
| <a name="input_ssl_config"></a> [ssl\_config](#input\_ssl\_config) | Configuration for the SSL check.<br/><br/>(Optional) alert\_at - A list representing when alerts should be sent (days). Must be exactly 3 numerical values. Defaults to [1, 7, 30].<br/>(Optional) check\_interval - The number of seconds between SSL checks. Default value is 86400.<br/>(Optional) follow\_redirects - Whether to follow redirects when testing. Disabled by default.<br/>(Optional) on\_broken - Whether to enable alerts when SSL certificate issues are found. Enabled by default.<br/>(Optional) on\_expiry - Whether to enable alerts when the SSL certificate is to expire. Enabled by default.<br/>(Optional) on\_mixed - Whether to enable alerts when mixed content is found. Enabled by default.<br/>(Optional) on\_reminder - Whether to enable alert reminders. Enabled by default. | <pre>object({<br/>    alert_at         = optional(set(number), [1, 7, 30])<br/>    check_interval   = optional(number, 86400)<br/>    follow_redirects = optional(bool, false)<br/>    on_broken        = optional(bool, true)<br/>    on_expiry        = optional(bool, true)<br/>    on_mixed         = optional(bool, true)<br/>    on_reminder      = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_uptime_config"></a> [uptime\_config](#input\_uptime\_config) | Configuration for the uptime check.<br/><br/>(Optional) check\_interval - The number of seconds between uptime checks. Default value is 1800.<br/>(Optional) confirmation - The number of confirmation servers to confirm downtime before an alert is triggered. Default value is 2.<br/>(Optional) enable\_cookies - Whether to enable cookie storage. Disabled by default.<br/>(Optional) final\_endpoint - The URL upon where the redirect chain should end.<br/>(Optional) follow\_redirects - Whether to follow redirects when testing. Disabled by default.<br/>(Optional) regions - A list of regions on which to run checks. The values required for this parameter can be retrieved from the `GET /v1/uptime-locations` endpoint.<br/>(Optional) request\_headers - Represents headers to be sent when making requests.<br/>(Optional) request\_method - The type of HTTP check. Default value is `HTTP`. Possible values are `HTTP` and `HEAD`.<br/>(Optional) request\_payload - Payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified.<br/>(Optional) request\_payload\_raw - Raw payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified.<br/>(Optional) status\_codes - A list of status codes that trigger an alert.<br/>(Optional) tags - A list of tags to apply to the check.<br/>(Optional) timeout - The number of seconds to wait for a response before timing out. Default value is 15.<br/>(Optional) trigger\_rate - The number of minutes to wait before sending an alert.<br/>(Optional) validate\_ssl - Whether to validate SSL certificates. Disabled by default. | <pre>object({<br/>    check_interval      = optional(number, 1800)<br/>    confirmation        = optional(number, 2)<br/>    enable_cookies      = optional(bool, false)<br/>    final_endpoint      = optional(string)<br/>    follow_redirects    = optional(bool, false)<br/>    regions             = optional(set(string))<br/>    request_headers     = optional(map(string))<br/>    request_method      = optional(string, "HTTP")<br/>    request_payload     = optional(map(string))<br/>    request_payload_raw = optional(string)<br/>    status_codes        = optional(set(number))<br/>    tags                = optional(set(string))<br/>    timeout             = optional(number, 15)<br/>    trigger_rate        = optional(number)<br/>    validate_ssl        = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_user_agent"></a> [user\_agent](#input\_user\_agent) | A custom user agent string set when testing. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pagespeed_check_id"></a> [pagespeed\_check\_id](#output\_pagespeed\_check\_id) | The ID of the pagespeed check. |
| <a name="output_ssl_check_id"></a> [ssl\_check\_id](#output\_ssl\_check\_id) | The ID of the SSL check. |
| <a name="output_uptime_check_id"></a> [uptime\_check\_id](#output\_uptime\_check\_id) | The ID of the uptime check. |
<!-- pyml enable md013,md022,md033 -->
<!-- END_TF_DOCS -->

## License

This project is licensed under the [Mozilla Public License](LICENSE).

variable "check_name" {
  description = "The name of the checks created."
  type        = string
}

variable "contact_groups" {
  description = "A list of contact group IDs."
  type        = set(string)
  default     = null
}

variable "pagespeed_config" {
  description = <<EOF
Configuration for the pagespeed check.

(Optional) alert_bigger - An alert will be sent if the size of the page is larger than this value (kb). Disabled by default.
(Optional) alert_slower - An alert will be sent if the load time of the page exceeds this value (ms). Disabled by default.
(Optional) alert_smaller - An alert will be sent if the size of the page is smaller than this value (kb). Disabled by default.
(Optional) check_interval - The number of seconds between pagespeed checks. Default value is 1800.
(Optional) region - The region on which to run checks. Default value is `UK`.
EOF
  type = object({
    alert_bigger   = optional(number, 0)
    alert_slower   = optional(number, 0)
    alert_smaller  = optional(number, 0)
    check_interval = optional(number, 1800)
    region         = optional(string, "UK")
  })
  default  = {}
  nullable = false
}

variable "paused" {
  description = "Whether the checks should be run."
  type        = bool
  default     = false
}

variable "ssl_config" {
  description = <<EOF
Configuration for the SSL check.

(Optional) alert_at - A list representing when alerts should be sent (days). Must be exactly 3 numerical values. Defaults to [1, 7, 30].
(Optional) check_interval - The number of seconds between SSL checks. Default value is 86400.
(Optional) follow_redirects - Whether to follow redirects when testing. Disabled by default.
(Optional) on_broken - Whether to enable alerts when SSL certificate issues are found. Enabled by default.
(Optional) on_expiry - Whether to enable alerts when the SSL certificate is to expire. Enabled by default.
(Optional) on_mixed - Whether to enable alerts when mixed content is found. Enabled by default.
(Optional) on_reminder - Whether to enable alert reminders. Enabled by default.
EOF
  type = object({
    alert_at         = optional(set(number), [1, 7, 30])
    check_interval   = optional(number, 86400)
    follow_redirects = optional(bool, false)
    on_broken        = optional(bool, true)
    on_expiry        = optional(bool, true)
    on_mixed         = optional(bool, true)
    on_reminder      = optional(bool, true)
  })
  default  = {}
  nullable = false
}

variable "uptime_config" {
  description = <<EOF
Configuration for the uptime check.

(Optional) check_interval - The number of seconds between uptime checks. Default value is 1800.
(Optional) confirmation - The number of confirmation servers to confirm downtime before an alert is triggered. Default value is 2.
(Optional) enable_cookies - Whether to enable cookie storage. Disabled by default.
(Optional) final_endpoint - The URL upon where the redirect chain should end.
(Optional) follow_redirects - Whether to follow redirects when testing. Disabled by default.
(Optional) regions - A list of regions on which to run checks. The values required for this parameter can be retrieved from the `GET /v1/uptime-locations` endpoint.
(Optional) request_headers - Represents headers to be sent when making requests.
(Optional) request_method - The type of HTTP check. Default value is `HTTP`. Possible values are `HTTP` and `HEAD`.
(Optional) request_payload - Payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified.
(Optional) request_payload_raw - Raw payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified.
(Optional) status_codes - A list of status codes that trigger an alert.
(Optional) tags - A list of tags to apply to the check.
(Optional) timeout - The number of seconds to wait for a response before timing out. Default value is 15.
(Optional) trigger_rate - The number of minutes to wait before sending an alert.
(Optional) validate_ssl - Whether to validate SSL certificates. Disabled by default.
EOF
  type = object({
    check_interval      = optional(number, 1800)
    confirmation        = optional(number, 2)
    enable_cookies      = optional(bool, false)
    final_endpoint      = optional(string)
    follow_redirects    = optional(bool, false)
    regions             = optional(set(string))
    request_headers     = optional(map(string))
    request_method      = optional(string, "HTTP")
    request_payload     = optional(map(string))
    request_payload_raw = optional(string)
    status_codes        = optional(set(number))
    tags                = optional(set(string))
    timeout             = optional(number, 15)
    trigger_rate        = optional(number)
    validate_ssl        = optional(bool, false)
  })
  default  = {}
  nullable = false
  validation {
    condition     = contains(["HTTP", "HEAD"], var.uptime_config.request_method)
    error_message = "`request_method` must be either `HTTP` or `HEAD`."
  }
  validation {
    condition     = var.uptime_config.request_payload != "" && var.uptime_config.request_payload_raw != ""
    error_message = "Only one of `request_payload` or `request_payload_raw` may be specified."
  }
}

variable "user_agent" {
  description = "A custom user agent string set when testing."
  type        = string
  default     = null
}

variable "website_url" {
  description = "The URL of the website being monitored by the checks."
  type        = string
}

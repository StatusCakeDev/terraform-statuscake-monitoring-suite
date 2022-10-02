variable "check_name" {
  type        = string
  description = "Name of the checks created"
}

variable "website_url" {
  type        = string
  description = "URL of the website being monitored by the checks"
}

variable "paused" {
  type        = bool
  description = "Whether the checks should be run"
  default     = false
}

variable "contact_groups" {
  type        = set(string)
  description = "List of contact group IDs"
  default     = null
}

variable "user_agent" {
  type        = string
  description = "Custom user agent string set when testing"
  default     = "StatusCake monitoring suite"
}

variable "pagespeed_check_interval" {
  type        = number
  description = "Number of seconds between pagespeed checks"
  default     = 1800
}

variable "pagespeed_region" {
  type        = string
  description = "Region on which to run checks"
  default     = "UK"
}

variable "pagespeed_alert_bigger" {
  type        = number
  description = "An alert will be sent if the size of the page is larger than this value (kb)"
  default     = 0
}

variable "pagespeed_alert_slower" {
  type        = number
  description = "An alert will be sent if the load time of the page exceeds this value (ms)"
  default     = 0
}

variable "pagespeed_alert_smaller" {
  type        = number
  description = "An alert will be sent if the size of the page is smaller than this value (kb)"
  default     = 0
}

variable "ssl_check_interval" {
  type        = number
  description = "Number of seconds between SSL checks"
  default     = 86400
}

variable "ssl_follow_redirects" {
  type        = bool
  description = "Whether to follow redirects when testing"
  default     = false
}

variable "ssl_alert_at" {
  type        = set(number)
  description = "List representing when alerts should be sent (days). Must be exactly 3 numerical values"
  default     = [1, 7, 30]
}

variable "ssl_on_reminder" {
  type        = bool
  description = "Whether to enable alert reminders"
  default     = true
}

variable "ssl_on_expiry" {
  type        = bool
  description = "Whether to enable alerts when the SSL certificate is to expire"
  default     = true
}

variable "ssl_on_broken" {
  type        = bool
  description = "Whether to enable alerts when SSL certificate issues are found"
  default     = true
}

variable "ssl_on_mixed" {
  type        = bool
  description = "Whether to enable alerts when mixed content is found"
  default     = true
}

variable "uptime_check_interval" {
  type        = number
  description = "Number of seconds between HTTP checks"
  default     = 1800
}

variable "uptime_confirmation" {
  type        = number
  description = "Number of confirmation servers to confirm downtime before an alert is triggered"
  default     = 2
}

variable "uptime_trigger_rate" {
  type        = number
  description = "The number of minutes to wait before sending an alert"
  default     = null
}

variable "uptime_enable_cookies" {
  type        = bool
  description = "Whether to enable cookie storage"
  default     = true
}

variable "uptime_follow_redirects" {
  type        = bool
  description = "Whether to follow redirects when testing"
  default     = false
}

variable "uptime_final_endpoint" {
  type        = string
  description = "Specify where the redirect chain should end"
  default     = null
}

variable "uptime_timeout" {
  type        = number
  description = "The number of seconds to wait to receive the first byte"
  default     = 15
}

variable "uptime_validate_ssl" {
  type        = bool
  description = "Whether to send an alert if the SSL certificate is soon to expire"
  default     = false
}

variable "uptime_request_headers" {
  type        = map(string)
  description = "Represents headers to be sent when making requests"
  default     = null
}

variable "uptime_request_method" {
  type        = string
  description = "Type of HTTP check. Either HTTP, or HEAD"
  default     = "HTTP"
}

variable "uptime_request_payload" {
  type        = map(string)
  description = "Payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified"
  default     = null
}

variable "uptime_request_payload_raw" {
  type        = string
  description = "Raw payload submitted with the request. Setting this updates the check to use the HTTP POST verb. Only one of `request_payload` or `request_payload_raw` may be specified"
  default     = null
}

variable "uptime_status_codes" {
  type        = set(string)
  description = "List of status codes that trigger an alert"
  default     = ["204", "205", "206", "303", "400", "401", "402", "403", "404", "405", "406", "408", "410", "413", "444", "429", "494", "495", "496", "499", "500", "501", "502", "503", "504", "505", "506", "507", "508", "509", "510", "511", "520", "521", "522", "523", "524", "598", "599"]
}

variable "uptime_regions" {
  type        = list(string)
  description = "List of regions on which to run checks. The values required for this parameter can be retrieved from the `GET /v1/uptime-locations` endpoint"
  default     = null
}

variable "uptime_tags" {
  type        = set(string)
  description = "List of tags"
  default     = null
}

output "pagespeed_check_id" {
  description = "The ID of the pagespeed check."
  value       = statuscake_pagespeed_check.pagespeed_check.id
}

output "ssl_check_id" {
  description = "The ID of the SSL check."
  value       = statuscake_ssl_check.ssl_check.id
}

output "uptime_check_id" {
  description = "The ID of the uptime check."
  value       = statuscake_uptime_check.uptime_check.id
}

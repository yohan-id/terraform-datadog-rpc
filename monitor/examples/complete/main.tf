module "beical_app_monitor_rpc" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  cluster        = "beical-app"

  recipients        = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
  renotify_interval = 0
  notify_audit      = false

  server_latency_p95_thresholds = {
    critical = 1000
    warning  = 500
  }

  server_latency_p95_message            = "Monitor is triggered"
  server_latency_p95_escalation_message = "Monitor isn't resolved for given interval"

  server_exception_thresholds = {
    critical = 100
    warning  = 50
  }

  server_exception_message            = "Monitor is triggered"
  server_exception_escalation_message = "Monitor isn't resolved for given interval"

  client_latency_p95_thresholds = {
    critical = 800
    warning  = 400
  }

  client_latency_p95_message            = "Monitor is triggered"
  client_latency_p95_escalation_message = "Monitor isn't resolved for given interval"

  client_exception_thresholds = {
    critical = 80
    warning  = 40
  }

  client_exception_message            = "Monitor is triggered"
  client_exception_escalation_message = "Monitor isn't resolved for given interval"

  circuit_breaker_status_thresholds = {
    critical = "2"
  }

  circuit_breaker_status_message            = "Monitor is triggered"
  circuit_breaker_status_escalation_message = "Monitor isn't resolved for given interval"
}

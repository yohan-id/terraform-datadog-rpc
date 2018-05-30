module "rpc" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  cluster        = "beical-app"
  environment    = "production"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]

  server_latency_p95_thresholds = {
    critical = 1000
    warning  = 500
  }

  server_exception_thresholds = {
    critical = 100
    warning  = 50
  }

  client_latency_p95_thresholds = {
    critical = 800
    warning  = 400
  }

  client_exception_thresholds = {
    critical = 80
    warning  = 40
  }

  circuit_breaker_status_thresholds = {
    critical = "2"
  }
}

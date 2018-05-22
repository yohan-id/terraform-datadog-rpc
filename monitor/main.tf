module "server_latency_p95" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${var.enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.cluster} - RPC Server Latency is High on Class: {{ classname }} Method: {{ methodname }}"
  query              = "avg(last_5m):avg:rpc.server.ltcy.p95{cluster:${var.cluster}} by {host,classname,methodname}"
  thresholds         = "${var.server_latency_p95_thresholds}"
  message            = "${var.server_latency_p95_message}"
  escalation_message = "${var.server_latency_p95_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "server_exception" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${var.enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.cluster} - RPC Server Exception is High on Class: {{ classname }} Method: {{ methodname }}"
  query              = "avg(last_5m):avg:rpc.server.exc.count{cluster:${var.cluster}} by {host,classname,methodname}"
  thresholds         = "${var.server_exception_thresholds}"
  message            = "${var.server_exception_message}"
  escalation_message = "${var.server_exception_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "client_latency_p95" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${var.enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.cluster} - RPC Client Latency is High on Class: {{ classname }} Method: {{ methodname }} Destination: {{ destnodeid }}"
  query              = "avg(last_5m):avg:rpc.client.ltcy.p95{cluster:${var.cluster}} by {host,classname,methodname,destnodeid}"
  thresholds         = "${var.client_latency_p95_thresholds}"
  message            = "${var.client_latency_p95_message}"
  escalation_message = "${var.client_latency_p95_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "client_exception" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${var.enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.cluster} - RPC Client Exception is High on Class: {{ classname }} Method: {{ methodname }} Destination: {{ destnodeid }}"
  query              = "avg(last_5m):avg:rpc.client.exc.count{cluster:${var.cluster}} by {host,classname,methodname,destnodeid}"
  thresholds         = "${var.client_exception_thresholds}"
  message            = "${var.client_exception_message}"
  escalation_message = "${var.client_exception_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "circuit_breaker_status" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${var.enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.cluster} - Circuit Breaker is Open on Class: {{ classname }} Method: {{ methodname }}"
  query              = "avg(last_5m):avg:CircuitBreaker.status.lastNumber{cluster:${var.cluster}} by {host,classname,methodname}"
  comparison         = ">="
  thresholds         = "${var.circuit_breaker_status_thresholds}"
  message            = "${var.circuit_breaker_status_message}"
  escalation_message = "${var.circuit_breaker_status_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

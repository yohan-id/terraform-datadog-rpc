locals {
  monitor_enabled = "${var.enabled && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "rpc" {
  count = "${var.enabled ? 1 : 0}"

  title       = "${var.product_domain} - ${var.cluster} - ${var.environment} - RPC"
  description = "A generated timeboard for RPC"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "cluster"
  }

  template_variable {
    default = "${var.environment}"
    name    = "environment"
    prefix  = "environment"
  }

  template_variable {
    default = "*"
    name    = "classname"
    prefix  = "classname"
  }

  template_variable {
    default = "*"
    name    = "methodname"
    prefix  = "methodname"
  }

  template_variable {
    default = "*"
    name = "srcnodeid"
    prefix = "srcnodeid"
  }

  template_variable {
    default = "*"
    name = "destnodeid"
    prefix = "destnodeid"
  }

  graph {
    title     = "RPC Client Count (Rollup: Sum)"
    viz       = "timeseries"
    autoscale = true

    request {
      q = "sum:rpc.client.count{$cluster, $environment, $methodname, $destnodeid} by {destnodeid, methodname}.rollup(sum)"

      type = "line"
    }
  }

  graph {
    title     = "RPC Client Latency 95th Percentile"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:rpc.client.ltcy.p95{$cluster, $environment, $methodname, $destnodeid} by {destnodeid, methodname}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Client Exception Count (Rollup: Sum)"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.client.exc.count{$cluster, $environment, $methodname, $destnodeid} by {destnodeid, methodname}.rollup(sum)"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Count (Rollup: Sum)"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.server.count{$cluster, $environment,$classname,$methodname, $srcnodeid} by {host,name,classname,methodname,srcnodeid}.rollup(sum)"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Latency 95th Percentile"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:rpc.server.ltcy.p95{$cluster, $environment,$classname,$methodname, $srcnodeid} by {host,name,classname,methodname,srcnodeid}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Exception Count (Rollup: Sum)"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.server.exc.count{$cluster, $environment,$classname,$methodname, $srcnodeid} by {host,name,classname,methodname,srcnodeid}.rollup(sum)"
      type = "line"
    }
  }

  graph {
    title     = "Circuit Breaker State"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:CircuitBreaker.status.lastNumber{$cluster, $environment} by {host,name,classname,methodname}"
      type = "line"
    }

    marker {
      type  = "ok bold"
      value = "y = 1"
      label = "CLOSE"
    }
    marker {
      type  = "error bold"
      value = "y = 2"
      label = "OPEN"
    }
    marker {
      type  = "warning bold"
      value = "y = 3"
      label = "HALF OPEN"
    }
  }

  graph {
    title     = "Circuit Breaker Failure"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:CircuitBreaker.failure.value{$cluster, $environment} by {host,name,classname,methodname}"
      type = "line"
    }
  }
}

module "monitor_server_latency_p95" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.rpc.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - RPC Server Latency is High on Class: {{ classname }} Method: {{ methodname }}"
  query              = "${coalesce(var.server_latency_p95_custom_query, "avg(last_1m):avg:rpc.server.ltcy.p95{cluster:${var.cluster}, environment:${var.environment}} by {host,classname,methodname} >= ${var.server_latency_p95_thresholds["critical"]}")}"
  thresholds         = "${var.server_latency_p95_thresholds}"
  message            = "${var.server_latency_p95_message}"
  escalation_message = "${var.server_latency_p95_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "monitor_server_exception" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.rpc.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - RPC Server Exception is High on Class: {{ classname }} Method: {{ methodname }}"
  query              = "${coalesce(var.server_exception_custom_query, "avg(last_1m):avg:rpc.server.exc.count{cluster:${var.cluster}, environment:${var.environment}} by {host,classname,methodname} >= ${var.server_exception_thresholds["critical"]}")}"
  thresholds         = "${var.server_exception_thresholds}"
  message            = "${var.server_exception_message}"
  escalation_message = "${var.server_exception_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "monitor_client_latency_p95" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.rpc.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - RPC Client Latency is High on Method: {{ methodname }} Destination: {{ destnodeid }}"
  query              = "${coalesce(var.client_latency_p95_custom_query, "avg(last_1m):avg:rpc.client.ltcy.p95{cluster:${var.cluster}, environment:${var.environment}} by {host,methodname,destnodeid} >= ${var.client_latency_p95_thresholds["critical"]}")}"
  thresholds         = "${var.client_latency_p95_thresholds}"
  message            = "${var.client_latency_p95_message}"
  escalation_message = "${var.client_latency_p95_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "monitor_client_exception" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.rpc.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - RPC Client Exception is High on Method: {{ methodname }} Destination: {{ destnodeid }}"
  query              = "${coalesce(var.client_exception_custom_query, "avg(last_1m):avg:rpc.client.exc.count{cluster:${var.cluster}, environment:${var.environment}} by {host,methodname,destnodeid} >= ${var.client_exception_thresholds["critical"]}")}"
  thresholds         = "${var.client_exception_thresholds}"
  message            = "${var.client_exception_message}"
  escalation_message = "${var.client_exception_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

module "monitor_circuit_breaker_status" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.rpc.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - Circuit Breaker is Open on Class: {{ classname }} Method: {{ methodname }}"
  query              = "${coalesce(var.circuit_breaker_status_custom_query, "avg(last_1m):avg:CircuitBreaker.status.lastNumber{cluster:${var.cluster}, environment:${var.environment}} by {host,classname,methodname} >= ${var.circuit_breaker_status_thresholds["critical"]}")}"
  thresholds         = "${var.circuit_breaker_status_thresholds}"
  message            = "${var.circuit_breaker_status_message}"
  escalation_message = "${var.circuit_breaker_status_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}

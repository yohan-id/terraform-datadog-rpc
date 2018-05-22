resource "datadog_timeboard" "rpc" {
  count = "${var.enabled}"

  title       = "${var.product_domain} - ${var.cluster} - RPC"
  description = "A generated timeboard for RPC"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "cluster"
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

  graph {
    title     = "RPC Client Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.client..count{$cluster} by {host,name,destnodeid}"
      type = "line"
    }

    request {
      q    = "sum:rpc.client.count{$cluster} by {host,name,destnodeid}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Client Latency 95th Percentile"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:rpc.client.ltcy.p95{$cluster} by {host,name,destnodeid}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Client Exception Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.client.exc.count{$cluster} by {host,name,destnodeid}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.server.count{$cluster,$classname,$methodname} by {host,name,classname,methodname}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Latency 95th Percentile"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:rpc.server.ltcy.p95{$cluster,$classname,$methodname} by {host,name,classname,methodname}"
      type = "line"
    }
  }

  graph {
    title     = "RPC Server Exception Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:rpc.server.exc.count{$cluster,$classname,$methodname} by {host,name,classname,methodname}"
      type = "line"
    }
  }
}

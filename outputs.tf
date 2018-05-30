output "timeboard_title" {
  value       = "${join(",", datadog_timeboard.rpc.*.title)}"
  description = "The title of datadog timeboard for RPC"
}

output "monitor_server_latency_p95_name" {
  value       = "${module.monitor_server_latency_p95.name}"
  description = "The name of datadog monitor for RPC Server Latency P95"
}

output "monitor_server_exception_name" {
  value       = "${module.monitor_server_exception.name}"
  description = "The name of datadog monitor for RPC Server Exception"
}

output "monitor_client_latency_p95_name" {
  value       = "${module.monitor_client_latency_p95.name}"
  description = "The name of datadog monitor for RPC Client Latency P95"
}

output "monitor_client_exception_name" {
  value       = "${module.monitor_client_exception.name}"
  description = "The name of datadog monitor for RPC Client Exception"
}

output "monitor_circuit_breaker_status_name" {
  value       = "${module.monitor_circuit_breaker_status.name}"
  description = "The name of datadog monitor for RPC Circuit Breaker Status"
}

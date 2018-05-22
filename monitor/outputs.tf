output "server_latency_p95_name" {
  value       = "${module.server_latency_p95.name}"
  description = "The name of datadog monitor for RPC Server Latency P95"
}

output "server_exception_name" {
  value       = "${module.server_exception.name}"
  description = "The name of datadog monitor for RPC Server Exception"
}

output "client_latency_p95_name" {
  value       = "${module.client_latency_p95.name}"
  description = "The name of datadog monitor for RPC Client Latency P95"
}

output "client_exception_name" {
  value       = "${module.client_exception.name}"
  description = "The name of datadog monitor for RPC Client Exception"
}

output "circuit_breaker_status_name" {
  value       = "${module.circuit_breaker_status.name}"
  description = "The name of datadog monitor for RPC Circuit Breaker Status"
}

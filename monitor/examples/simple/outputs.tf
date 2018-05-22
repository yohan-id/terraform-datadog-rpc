output "beical_app_monitor_rpc_server_latency_p95_name" {
  value = "${module.beical_app_monitor_rpc.server_latency_p95_name}"
}

output "beical_app_monitor_rpc_server_exception_name" {
  value = "${module.beical_app_monitor_rpc.server_exception_name}"
}

output "beical_app_monitor_rpc_client_latency_p95_name" {
  value = "${module.beical_app_monitor_rpc.client_latency_p95_name}"
}

output "beical_app_monitor_rpc_client_exception_name" {
  value = "${module.beical_app_monitor_rpc.client_exception_name}"
}

output "beical_app_monitor_rpc_circuit_breaker_status_name" {
  value = "${module.beical_app_monitor_rpc.circuit_breaker_status_name}"
}

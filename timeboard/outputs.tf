output "title" {
  value       = "${join(",", datadog_timeboard.rpc.*.title)}"
  description = "The title of datadog timeboard for RPC"
}

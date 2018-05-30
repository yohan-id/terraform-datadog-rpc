variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}

variable "product_domain" {
  type        = "string"
  description = "The name of the product domain"
}

variable "service" {
  type        = "string"
  description = "The name of the service"
}

variable "cluster" {
  type        = "string"
  description = "The name of the cluster"
}

variable "environment" {
  type        = "string"
  default     = "*"
  description = "The name of the environment"
}

variable "recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when monitor triggered"
}

variable "renotify_interval" {
  type        = "string"
  default     = "0"
  description = "Time interval in minutes which escalation_message will be sent when monitor is triggered"
}

variable "notify_audit" {
  type        = "string"
  default     = false
  description = "Whether any configuration changes should be notified"
}

variable "server_latency_p95_thresholds" {
  type = "map"

  default = {
    critical = "No default value"
  }

  description = "The warning and critical thresholds for RPC Server Latency P95 monitoring"
}

variable "server_latency_p95_message" {
  type        = "string"
  default     = ""
  description = "The message when RPC Server Latency P95 monitor triggered"
}

variable "server_latency_p95_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when RPC Server Latency P95 monitor isn't resolved for given time"
}

variable "server_exception_thresholds" {
  type = "map"

  default = {
    critical = "No default value"
  }

  description = "The warning and critical thresholds for RPC Server Exception monitoring"
}

variable "server_exception_message" {
  type        = "string"
  default     = ""
  description = "The message when RPC Server Exception monitor triggered"
}

variable "server_exception_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when RPC Server Exception monitor isn't resolved for given time"
}

variable "client_latency_p95_thresholds" {
  type = "map"

  default = {
    critical = "No default value"
  }

  description = "The warning and critical thresholds for RPC Client Latency P95 monitoring"
}

variable "client_latency_p95_message" {
  type        = "string"
  default     = ""
  description = "The message when RPC Client Latency P95 monitor triggered"
}

variable "client_latency_p95_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when RPC Client Latency P95 monitor isn't resolved for given time"
}

variable "client_exception_thresholds" {
  type = "map"

  default = {
    critical = "No default value"
  }

  description = "The warning and critical thresholds for RPC Client Exception monitoring"
}

variable "client_exception_message" {
  type        = "string"
  default     = ""
  description = "The message when RPC Client Exception monitor triggered"
}

variable "client_exception_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when RPC Client Exception monitor isn't resolved for given time"
}

variable "circuit_breaker_status_thresholds" {
  type = "map"

  default = {
    critical = "2"
  }

  description = "The warning and critical thresholds for RPC Circuit Breaker Status monitoring"
}

variable "circuit_breaker_status_message" {
  type        = "string"
  default     = ""
  description = "The message when RPC Circuit Breaker Status monitor triggered"
}

variable "circuit_breaker_status_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when RPC Circuit Breaker Status monitor isn't resolved for given time"
}

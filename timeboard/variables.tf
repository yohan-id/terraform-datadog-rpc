variable "product_domain" {
  type        = "string"
  description = "The name of the product domain which this RPC belongs to"
}

variable "cluster" {
  type        = "string"
  description = "The name of the cluster which this RPC belongs to"
}

variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}

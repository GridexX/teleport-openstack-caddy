variable "image_name" {
  type    = string
  default = "debian-12.0.0"
}

variable "flavor_name" {
  type    = string
  default = "m1.small"
}

variable "public_key_pair_name" {
  type    = string
  default = "teleport"
}

variable "public_key_pair_path" {
  description = "Path to the SSH key pair to use for the instance"
  default     = "~/.ssh/id_k0s.pub"
}

variable "security_groups" {
  default = ["web-http"]
}

variable "public_network_name" {
  default = "public2"
}

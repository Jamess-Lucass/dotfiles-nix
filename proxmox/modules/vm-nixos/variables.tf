variable "name" {
  description = "Name of the VM"
  type        = string
}

variable "vmid" {
  description = "ID of the VM - must be unique across all nodes"
  type        = number
  default = 0
}

variable "desc" {
  description = "Description of the VM"
  type        = string
}

variable "target_node" {
  description = "Proxmox node the VM will be assigned to"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
}

variable "sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Amount of memory in MB"
  type        = number
}

variable "disk_size" {
  description = "Size of the VM Disk"
  type        = string
}

variable "public_ssh_key" {
  description = "Public SSH key"
  type        = string
  sensitive = true
}
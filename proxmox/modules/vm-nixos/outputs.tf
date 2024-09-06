output "vm_id" {
  description = "The ID of the created VM"
  value       = proxmox_vm_qemu.vm-nixos.vmid
}

output "vm_name" {
  description = "The name of the created VM"
  value       = proxmox_vm_qemu.vm-nixos.name
}

output "vm_ip" {
  description = "The IP address of the created VM"
  value       = proxmox_vm_qemu.vm-nixos.default_ipv4_address
}
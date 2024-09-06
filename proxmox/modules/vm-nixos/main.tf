resource "proxmox_vm_qemu" "vm-nixos" {
  name = var.name
  desc = var.desc

  # The target_node has to the same name as the node within Proxmox
  target_node = var.target_node

  # Activate QEMU agent for this VM
  agent = 1

  cores   = var.cores
  sockets = var.sockets
  cpu     = "host"
  numa    = true
  memory  = var.memory

  vmid = var.vmid
  machine                = "q35"
  bios                   = "ovmf"
  define_connection_info = false
  full_clone             = false
  scsihw                 = "virtio-scsi-pci"
  boot                   = "order=scsi0;ide2"
  onboot                 = true
  vm_state               = "running"

  sshkeys = var.public_ssh_key

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/nixos-2024-09-05-x86_64-linux.iso"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage    = "local-lvm"
          size       = var.disk_size
          emulatessd = true
        }
      }
    }
  }
}

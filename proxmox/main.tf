module "k3s-master" {
  source = "./modules/vm-nixos"

  vmid           = 101
  name           = "k3s-master"
  desc           = "NixOS k3s master"
  target_node    = "pve01"
  cores          = 2
  memory         = 4096
  disk_size      = "256G"
}

module "k3s-workers" {
  source = "./modules/vm-nixos"
  count  = 2

  vmid           = count.index + 201
  name           = "k3s-worker-${count.index + 1}"
  desc           = "NixOS k3s worker ${count.index + 1}"
  target_node    = "pve02"
  cores          = 2
  memory         = 8192
  disk_size      = "64G"
}
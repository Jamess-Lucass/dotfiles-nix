module "k3s-master" {
  source = "./modules/vm-nixos"

  vmid           = 101
  name           = "k3s-master"
  desc           = "NixOS k3s master"
  target_node    = "pve01"
  cores          = 2
  memory         = 4096
  disk_size      = "256G"
  public_ssh_key = var.public_ssh_key
}

resource "null_resource" "provision_k3s_master" {
  depends_on = [module.k3s-master]

  provisioner "local-exec" {
    command = "nix run github:nix-community/nixos-anywhere -- --flake '.#homelab@minipc01' nixos@${module.k3s-master.ip_address}"
  }
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
  public_ssh_key = var.public_ssh_key
}

# resource "null_resource" "provision_k3s_workers" {
#   count      = 2
#   depends_on = [module.k3s-workers]

#   provisioner "local-exec" {
#     command = "nix run github:nix-community/nixos-anywhere -- --flake '../#homelab@minipc02' nixos@${module.k3s-workers[count.index].ip_address}"
#   }
# }
# Homelab

The majority of my workloads are deployed to proxmox, I currently have a 2 node proxmox cluster and automate the provisioning of virtual machines with terraform, this is all kept under the `./proxmox` directory.

## NixOS

### Prerequisites

- Install Proxmox on two machines with the node names `pve01` & `pve02`
- Intall `dotenv-cli`
- Upload the [NixOS minimal ISO](https://channels.nixos.org/nixos-24.05/latest-nixos-minimal-x86_64-linux.iso) to each Proxmox node

### Setup

> Assuming we have a 2 node Proxmox cluster with the correctly configured node names and the NixOS ISO image uploaded. We can proceed.

1. `cp .env.example .env`

2. Populate the `.env` file with the correct values

3. Run the terraform automation

    ```bash
    dotenv -- terraform -chdir=./proxmox apply
    ```

4. Grab the IP address of the VM and set a temporary password

    > This will be needed in the following step when we wish to run nixos anywhere.

    ```bash
    ip addr
    ```

    ```bash
    passwd
    ```

5. Run the NixOS automation against the VMs

    > I use [NixOS anywhere](https://github.com/nix-community/nixos-anywhere) to remotely install and configure NixOS.

    ```bash
    nix run github:nix-community/nixos-anywhere -- --flake '.#homelab@k3s-cluster' nixos@<IP-ADDRESS>
    ```

<!-- ### Rebuild

`nixos-rebuild switch --flake '.#<CONFIG>' --target-host "<name>@<ip>" --use-remote-sudo` -->

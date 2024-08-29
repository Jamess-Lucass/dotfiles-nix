{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.homeDirectory = "/home/james";
}
{ config, lib, pkgs, system, ... }:

{
  imports = [
    ./common.nix
  ];

  home.homeDirectory = "/Users/james";
}

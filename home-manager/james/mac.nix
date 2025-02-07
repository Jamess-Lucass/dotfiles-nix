{ config, lib, pkgs, system, ... }:

{
  imports = [
    ./common.nix
  ];

  home.homeDirectory = "/Users/james";

  home.packages = with pkgs; [
    nodePackages."eas-cli"
  ];
}

.PHONY switch:
switch: 
	home-manager switch --flake .#wsl --extra-experimental-features "nix-command flakes"
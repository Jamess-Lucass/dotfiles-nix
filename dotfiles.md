# Dotfiles

> [!NOTE]  
> These dotfiles are for my personal use, due to some elements being hardcoded, I advise you to not install from this repository directly.

## Setup

> Follow this if you wish to use home-manager to manage your local dotfiles.

1. Clone dotfiles

   > This will install nix and home-manager if it's not already present on your machine, then clone the repository into the `.dotfiles` directory.

   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Jamess-Lucass/dotfiles-nix/main/bin/dotfiles)"
   ```

2. Run home-manager configuration

   > Choose the flake from within the `flake.nix` `homeConfigurations` array.

   ```bash
   home-manager switch --flake '<path>#<configuration>' --extra-experimental-features "nix-command flakes"
   ```

   eg. `home-manager switch --flake ~/.dotfiles#james@wsl --extra-experimental-features "nix-command flakes"`

## Updating

1. Pull latest

   > To update the dotfiles just run the `./bin/dotfiles` script again, this will ensure any changes made to the repository are pulled down.

   ```bash
   ~/.dotfiles/bin/dotfiles
   ```

2. Run home-manager configuration

   > Run the correct home-manager flake, exactly as ran in the Setup dotfiles section.

   ```bash
   home-manager switch --flake '<path>#<configuration>'
   ```

## Extra

> [!NOTE]  
> You may need to sym link dotnet for VSCode to work.
> ```bash
> sudo ln -s /home/james/.nix-profile/bin/dotnet /usr/local/bin/dotnet
> ```

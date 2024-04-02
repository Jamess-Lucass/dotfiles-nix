# dotfiles-nix

> [!NOTE]  
> These dotfiles are for my personal use, due to some elements being hardcoded, I advise you to not install from this repository directly.

## Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Jamess-Lucass/dotfiles-nix/main/bin/dotfiles)"
```

## Extra
VS Code on host machine
> settings.json
```json
"go.alternateTools": {
  "go": "/home/james/.nix-profile/bin/go"
}
```

# dotnix

## Enable Nix Falkes

Two experimental features can be enabled via `~/.config/nix/nix.conf`:

```sh
experimental-features = nix-command flakes
```

## Adding this flake to the Nix Store

```sh
nix build --no-link github:Aigeruth/dotnix#homeConfigurations.aige.activationPackage
"$(nix path-info ~/dotfiles#homeConfigurations.aige.activationPackage)"/activate
```

## Activating

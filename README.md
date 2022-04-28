# dotnix

_Note_: new files need to be added to git first (e.g. `git add`).

## Enable Nix Falkes

Two experimental features can be enabled via `~/.config/nix/nix.conf`:

```sh
experimental-features = nix-command flakes
```

## Adding this flake to the Nix Store

This flake contains configuration for multiple machines. They can be added to the Nix Store one by one.

Adding a configuration for `mila` to the Nix Store:

```sh
nix build --no-link github:Aigeruth/dotnix#homeConfigurations.mila.activationPackage
```

## Activating

nix-darwin is installed via Nix Flakes:

```sh
nix build ~/dotnix\#darwinConfigurations.Jill.system
./result/sw/bin/darwin-rebuild switch --flake ~/dotnix
```

Or without a link to `./result`

```sh
nix build --no-link ~/dotnix\#darwinConfigurations.Mila.system
```

Fish shell doesn't allow substitutions for commands, so it needs a workaround:

```sh
darwin_rebuild=(nix path-info ~/dotnix\#darwinConfigurations.Mila.system)/sw/bin/darwin-rebuild $darwin_rebuild switch --flake ~/dotnix\#Mila
```

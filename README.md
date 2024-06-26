# dotnix

_Note_: new files need to be added to git first (e.g. `git add`).

## Enable Nix Falkes

Two experimental features can be enabled via `~/.config/nix/nix.conf`:

```sh
experimental-features = nix-command flakes
```

## Installation

### Darwin

nix-darwin can be installed with `nix build` assuming that the
repository is cloned into `$HOME/dotnix` directory:

```sh
nix build --no-link ~/dotnix\#darwinConfigurations.Mila.system
```

Or directly from GitHub:

```sh
nix build --no-link github:Aigeruth/dotnix\#darwinConfigurations.Mila.system
```

At this state, `darwin-rebuild` is not available in the `$PATH` yet, so
it needs to be run from the build path:

```
$(nix path-info ~/dotnix\#darwinConfigurations.Mila.system)/sw/bin/darwin-rebuild switch --flake ~/dotnix\#Mila
```

After the first successful run and starting a new login shell, `$PATH`
for fish shell should now contain the `darwin-rebuild` command
(see `modules/home-manager/programs/fish.nix`):

```sh
darwin-rebuild switch --flake ~/dotnix\#Mila
```

### Linux

Initial run:

```sh
nix run home-manager/$branch -- init --switch ~/dotnix
```

Updates

```sh
home-manager switch --flake ~/dotnix
```

{ lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.unstable.emacs;
    extraConfig = ''
      (setq inhibit-startup-screen t)

      ;; Appearance
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (add-to-list 'default-frame-alist '(ns-appearance . light))
      (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
      (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

      (setq-default show-trailing-whitespace t)

      (load-theme 'dracula t)

      (evil-mode)
      (evil-set-undo-system 'undo-redo) ;; requires Emacs 28

      (ledger-mode)
      (setq ledger-default-date-format ledger-iso-date-format
            ledger-post-account-alignment-column 2
            ledger-post-amount-alignment-column  64)

      (global-company-mode)
    '';
    extraPackages = lib.attrVals [
      "company"
      "dracula-theme"
      "evil"
      "evil-ledger"
      "ledger-mode"
    ];
  };

  # disable welcome message as inhibit-startup-screen doesn't seem to work
  programs.fish.shellAliases = { emacs = "emacs --no-splash"; };
}

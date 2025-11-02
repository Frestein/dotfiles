;;; tools/daemons/config.el -*- lexical-binding: t; -*-

(use-package! daemons)

(use-package! systemd
  :when (modulep! +systemd)
  :config
  (when (modulep! +lsp)
    (set-eglot-client! 'systemd-mode "systemd-lsp")
    (add-hook 'systemd-mode-hook #'lsp!)))

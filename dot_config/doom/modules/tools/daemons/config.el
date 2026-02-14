;;; tools/daemons/config.el -*- lexical-binding: t; -*-

(use-package! daemons)

(use-package! systemd
  :when (and (modulep! +systemd)
             (executable-find "systemctl"))
  :config
  (when (modulep! +lsp)
    (set-eglot-client! 'systemd-mode '("systemd-lsp"))
    (add-hook 'systemd-mode-hook #'lsp! 'append)))

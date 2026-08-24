;;; tools/daemons/config.el -*- lexical-binding: t; -*-

(use-package! daemons)

(defun +systemd-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("systemd-lsp"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! systemd
  :when (and (modulep! +systemd)
             (executable-find "systemctl"))
  :config
  (+systemd-common-config 'systemd-mode))

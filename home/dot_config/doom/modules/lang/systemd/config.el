;;; lang/systemd/config.el -*- lexical-binding: t; -*-

(defun +systemd-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("systemd-lsp"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! systemd
  :config
  (+systemd-common-config 'systemd-mode))

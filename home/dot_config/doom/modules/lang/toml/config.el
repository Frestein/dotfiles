;;; lang/toml/config.el -*- lexical-binding: t; -*-

(defun +toml-common-config (mode)
  (when (modulep! +lsp)
    (when (executable-find "tombi")
      (set-eglot-client! mode '("tombi" "lsp")))
    (when (executable-find "taplo")
      (set-eglot-client! mode '("taplo" "lsp" "stdio")))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! toml-ts-mode
  :when (and (modulep! +tree-sitter) (treesit-available-p))
  :config
  (+toml-common-config 'toml-ts-mode))

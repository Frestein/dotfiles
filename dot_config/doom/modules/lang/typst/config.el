;;; lang/typst/config.el -*- lexical-binding: t; -*-

(use-package! typst-ts-mode
  :custom
  (typst-ts-watch-options "--open")
  (typst-ts-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (typst-ts-enable-raw-blocks-highlight t)
  :config
  (when (modulep! :tools lsp +eglot)
    (when (and (executable-find "tinymist")
               (modulep! +lsp))
      (set-eglot-client! 'typst-ts-mode "tinymist")))

  (add-hook 'typst-ts-mode-local-vars-hook #'lsp!))

(use-package! typst-preview
  :init
  (setq typst-preview-autostart t)
  (setq typst-preview-open-browser-automatically t)
  :custom
  (typst-preview-browser "default")
  (typst-preview-partial-rendering t))

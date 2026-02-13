;;; lang/hyprlang/config.el -*- lexical-binding: t; -*-

(use-package! hyprlang-ts-mode
  :when (and (modulep! +tree-sitter) (treesit-available-p))
  ;; :hook (hyprlang-ts-mode . eglot-ensure)
  :mode ("/hypr/.*\\.conf\\'" . hyprlang-ts-mode)
  :init
  (after! treesit
    (add-to-list 'treesit-language-source-alist
                 '(hyprlang "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang" "master")))
  :custom
  (hyprlang-ts-mode-indent-offset 4)
  :config
  (when (modulep! :lang org)
    (after! org-src
      (add-to-list 'org-src-lang-modes '("hyprlang" . hyprlang-ts))))

  (when (modulep! :editor format)
    (after! apheleia-mode
      (add-to-list 'apheleia-formatters '(whitespace . whitespace-cleanup))
      (add-to-list 'apheleia-mode-alist '(hyprlang-ts . whitespace))))

  (when (modulep! +lsp)
    (set-eglot-client! 'hyprlang-ts-mode '("hyprls"))
    (add-hook 'typst-ts-mode-local-vars-hook #'lsp! 'append)))

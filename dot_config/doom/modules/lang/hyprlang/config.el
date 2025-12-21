;;; lang/hyprlang/config.el -*- lexical-binding: t; -*-

(after! treesit
  (add-to-list 'treesit-language-source-alist
               '(hyprlang "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang" "master")))

(use-package! hyprlang-ts-mode
  :when (modulep! +tree-sitter)
  :hook (hyprlang-ts-mode . eglot-ensure)
  :mode ("/hypr/.*\\.conf\\'" . hyprlang-ts-mode)
  :custom
  (hyprlang-ts-mode-indent-offset 4)
  :config
  (after! org-src
    (add-to-list 'org-src-lang-modes '("hyprlang" . hyprlang-ts)))

  (after! apheleia-mode
    (add-to-list 'apheleia-formatters '(whitespace . whitespace-cleanup))
    (add-to-list 'apheleia-mode-alist '(hyprlang-ts . whitespace)))

  (when (modulep! +lsp)
    (when (modulep! :tools lsp +eglot)
      (set-eglot-client! 'hyprlang-ts-mode '("hyprls")))

    (add-hook 'typst-ts-mode-local-vars-hook #'lsp!)))

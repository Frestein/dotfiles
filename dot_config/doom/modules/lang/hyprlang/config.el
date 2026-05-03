;;; lang/hyprlang/config.el -*- lexical-binding: t; -*-

(defun +hyprlang-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("hyprls"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! hyprlang-ts-mode
  :when (and (modulep! +tree-sitter) (treesit-available-p))
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
    (setq-hook! 'hyprlang-ts-mode-hook +format-inhibit t)

    (after! apheleia-mode
      (add-to-list 'apheleia-formatters '(whitespace . whitespace-cleanup))
      (add-to-list 'apheleia-mode-alist '(hyprlang-ts . whitespace))))

  (+hyprlang-common-config 'hyprlang-ts-mode))

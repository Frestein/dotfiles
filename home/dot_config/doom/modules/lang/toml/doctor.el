;;; lang/toml/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp).")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter).")

(assert! (or (not (modulep! +tree-sitter))
             (fboundp 'toml-ts-mode))
         "Can't find `toml-ts-mode'; Emacs 30.1+ is required.")

(when (modulep! +lsp)
  (unless (and (executable-find "tombi")
               (executable-find "taplo"))
    (warn! "Couldn't find the tombi or taplo binary. LSP will be disabled.")))

;;; lang/hyprlang/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp).")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter).")

(unless (executable-find "Hyprland")
  (warn! "Couldn't find the Hyprland binary."))

(when (modulep! +lsp)
  (unless (executable-find "hyprls")
    (warn! "Couldn't find the hyprls binary. LSP will be disabled.")))

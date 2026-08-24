;;; lang/pkgbuild/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp).")

(when (modulep! +lsp)
  (unless (executable-find "termux-language-server")
    (warn! "Couldn't find the termux-language-server binary. LSP will be disabled.")))

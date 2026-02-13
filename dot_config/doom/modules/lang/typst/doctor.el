;;; lang/typst/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp)")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(unless (executable-find "typst")
  (warn! "Couldn't find the typst binary."))

(when (and (modulep! :tools lsp)
           (modulep! +lsp))
  (unless (executable-find "tinymist")
    (warn! "Couldn't find the tinymist binary. Live preview with typst-preview will not work.")))

(unless (modulep! :editor format)
  (warn! "Formatting will be disabled."))

(when (modulep! :editor format)
  (unless (executable-find "typstyle")
    (warn! "Couldn't find the typstyle binary. Code formatting with apheleia will not work.")))

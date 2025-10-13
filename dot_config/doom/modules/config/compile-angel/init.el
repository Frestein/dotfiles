;;; config/compile-angel/init.el -*- lexical-binding: t; -*-

(use-package! compile-angel
  :hook (doom-after-modules-config . compile-angel-on-load-mode))

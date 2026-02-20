;;; config/compile-angel/init.el -*- lexical-binding: t; -*-

;; Ensure Emacs loads the most recent byte-compiled files.
(setopt load-prefer-newer t)

;; Ensure that quitting only occurs once Emacs finishes native compiling,
;; preventing incomplete or leftover compilation files in `/tmp`.
(setopt native-comp-async-query-on-exit t)

;; Non-nil means to native compile packages as part of their installation.
(setopt package-native-compile t)

(use-package! compile-angel
  :hook (doom-after-modules-config . compile-angel-on-load-mode))

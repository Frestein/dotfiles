;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Set `compile-angel-verbose' to nil to disable compile-angel messages.
;; (When set to nil, compile-angel won't show which file is being compiled.)
(setq compile-angel-verbose nil)

;; Uncomment the line below to compile automatically when an Elisp file is saved
;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

;; A global mode that compiles .el files before they are loaded
;; using `load' or `require'.
(compile-angel-on-load-mode)

;; Global Auto Revert
;; A buffer can get out of sync with respect to its visited file on disk if that file is changed by another program. To keep it up to date, you can enable Auto Revert mode by typing M-x auto-revert-mode, or you can set it to be turned on globally with ‘global-auto-revert-mode’.  I have also turned on Global Auto Revert on non-file buffers, which is especially useful for ‘dired’ buffers.
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Shell
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shel "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

;; Mappings
(map! (:leader
       (:prefix ("A" . "app")
        (:when (modulep! :app rss)
         :desc "Elfeed" "e" #'elfeed))))

;; Dired
(use-package! nerd-icons-dired :hook (dired-mode . nerd-icons-dired-mode))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Frestein"
      user-mail-address "frestein@tuta.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

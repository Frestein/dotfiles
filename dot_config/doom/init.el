;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       reverse-im

       :completion
       (corfu +orderless +dabbrev +icons)
       (vertico +icons)

       :ui
       colorful
       doom
       hl-todo
       ligatures
       modeline
       ophints
       (popup +defaults)
       (smooth-scroll +interpolate)
       smart-cursor
       ;; tabs
       unicode
       (vc-gutter +pretty)
       volatile-highlights
       workspaces
       (zen +focus)

       :editor
       aas
       (evil +everywhere +vimrc)
       file-templates
       fold
       (format +lsp +onsave)
       ;; lispy
       multiple-cursors
       drag-stuff
       ialign
       cycle-at-point
       snippets
       (symex +ide)
       (whitespace +guess +trim)
       word-wrap
       ripgrep

       :emacs
       (dired +icons +dirvish)
       electric
       eww
       (ibuffer +icons)
       tramp
       undo
       vc

       :term
       eat
       eshell
       (ghostel +everywhere)
       eee

       :checkers
       (syntax +icons)
       jinx

       :tools
       biome
       blamer
       debugger
       (daemons +systemd +lsp)
       disk-usage
       chezmoi
       fj
       0x0
       (eval +overlay)
       (lookup +yandex)
       (lsp +eglot)
       (magit +forge)
       git-auto-commit
       (pass +auth)
       ebuku
       pdf
       nov
       reader
       trashed
       tree-sitter
       tldr
       translate
       zoxide

       :os
       (:if (featurep :system 'macos) macos)
       tty

       :lang
       emacs-lisp
       ;; common-lisp
       ;; (go +lsp +tree-sitter)
       (lua +lsp +tree-sitter +fennel)
       (python +lsp +tree-sitter)
       ;; (scheme +guile)
       (sh +lsp +tree-sitter +fish)
       (qt +lsp +tree-sitter)
       (web +lsp +tree-sitter)
       data
       (json +lsp +tree-sitter)
       (toml +lsp +tree-sitter)
       (yaml +lsp +tree-sitter)
       ;; (nix +lsp +tree-sitter)
       (pkgbuild +lsp)
       (org +roam +dragndrop +contacts)
       (markdown +tree-sitter +grip)
       (typst +lsp +tree-sitter +preview)

       :email
       (mu4e +mbsync +org +gmail)

       :app
       calendar
       qutebrowser
       ement
       osm
       (telega +mnz +icons +sponsored2)
       (rss +org)
       srs
       pomm
       mastodon
       youtube
       xmpp

       :config
       literate
       compile-angel
       (default +bindings +smartparens +gnupg))

(use-package
  compile-angel
  :demand t
  :custom
  ;; Set `compile-angel-verbose` to nil to suppress output from compile-angel.
  ;; Drawback: The minibuffer will not display compile-angel's actions.
  (compile-angel-verbose t)

  :config
  ;; The following directive prevents compile-angel from compiling your init
  ;; files. If you choose to remove this push to `compile-angel-excluded-files'
  ;; and compile your pre/post-init files, ensure you understand the
  ;; implications and thoroughly test your code. For example, if you're using
  ;; `use-package', you'll need to explicitly add `(require 'use-package)` at
  ;; the top of your init file.
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)

  ;; A local mode that compiles .el files whenever the user saves them.
  ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

  ;; A global mode that compiles .el files before they are loaded.
  (compile-angel-on-load-mode))

(use-package
  no-littering
  :hook
  (recentf-mode
    .
    (lambda ()
      (add-to-list
        'recentf-exclude
        (recentf-expand-file-name no-littering-etc-directory))
      (add-to-list
        'recentf-exclude
        (recentf-expand-file-name no-littering-var-directory)))))

(add-hook 'elpaca-after-init-hook #'global-auto-revert-mode)

(add-hook 'elpaca-after-init-hook #'savehist-mode)

(add-hook 'elpaca-after-init-hook #'save-place-mode)

(add-hook
  'elpaca-after-init-hook
  #'
  (lambda ()
    (let ((inhibit-message t))
      (recentf-mode 1))))
(add-hook 'kill-emacs-hook #'recentf-cleanup)

;; Tree-Sitter Setup
(setq treesit-language-source-alist
  '
  ((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (c "https://github.com/tree-sitter/tree-sitter-c")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (common-lisp "https://github.com/theHamsta/tree-sitter-commonlisp")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (css "https://github.com/tree-sitter/tree-sitter-css")
    (csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (go "https://github.com/tree-sitter/tree-sitter-go")
    (go-mod "https://github.com/camdencheek/tree-sitter-go-mod")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    (js
      .
      ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
    (json "https://github.com/tree-sitter/tree-sitter-json")
    (lua "https://github.com/Azganoth/tree-sitter-lua")
    (make "https://github.com/alemuller/tree-sitter-make")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (r "https://github.com/r-lib/tree-sitter-r")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (toml "https://github.com/tree-sitter/tree-sitter-toml")
    (tsx
      .
      ("https://github.com/tree-sitter/tree-sitter-typescript"
        "master"
        "tsx/src"))
    (typescript
      .
      ("https://github.com/tree-sitter/tree-sitter-typescript"
        "master"
        "typescript/src"))
    (typst "https://github.com/uben0/tree-sitter-typst")
    (yaml "https://github.com/ikatyang/tree-sitter-yaml")
    (nix "https://github.com/nix-community/tree-sitter-nix")))

(use-package
  treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; LSP Setup
(use-package
  eglot
  :ensure nil
  :commands (eglot eglot-ensure eglot-rename eglot-format-buffer)
  :config
  (add-to-list
    'eglot-server-programs
    '((python-mode python-ts-mode) "basedpyright-langserver" "--stdio")))

(use-package
  eglot-booster
  :ensure (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config (eglot-booster-mode))

;; Required by evil-collection
(eval-when-compile
  ;; It has to be defined before evil
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-w-in-emacs-state t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-disable-insert-state-bindings t))

;; Uncomment the following if you are using undo-fu
(setq evil-undo-system 'undo-fu)

;; Vim emulation
(use-package
  evil
  :commands (evil-mode evil-define-key)
  :hook (elpaca-after-init . evil-mode)
  :config
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>qq") 'evil-quit-all)
  (evil-define-key 'normal 'global (kbd "<leader>e") 'project-dired)
  (evil-define-key 'normal 'global (kbd "<leader>E") 'dired)
  (evil-define-key 'normal 'global (kbd "<leader>fr") 'recentf)
  (evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>sg") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>sw") 'consult-fd)
  (evil-define-key 'normal 'global (kbd "<leader>sM") 'consult-man)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'evil-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bd") 'evil-delete-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>x") 'execute-extended-command))

(eval-when-compile
  ;; It has to be defined before evil-collection
  (setq evil-collection-setup-minibuffer t))

(use-package evil-collection :after evil :config (evil-collection-init))

(use-package
  evil-commentary
  :after evil
  :hook (evil-mode . evil-commentary-mode))

(use-package
  evil-surround
  :after evil
  :commands global-evil-surround-mode
  :custom
  (evil-surround-pairs-alist
    '
    ((?\( . ("(" . ")"))
      (?\[ . ("[" . "]"))
      (?\{ . ("{" . "}"))
      (?\) . ("(" . ")"))
      (?\] . ("[" . "]"))
      (?\} . ("{" . "}"))
      (?< . ("<" . ">"))
      (?> . ("<" . ">"))))
  :hook (elpaca-after-init . global-evil-surround-mode))

(use-package
  evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Prevent parenthesis imbalance
(use-package
  paredit
  :commands paredit-mode
  :hook (emacs-lisp-mode . paredit-mode)
  :config (define-key paredit-mode-map (kbd "RET") nil))

(use-package
  enhanced-evil-paredit
  :commands enhanced-evil-paredit-mode
  :hook (paredit-mode . enhanced-evil-paredit-mode))

;; The undo-fu package is a lightweight wrapper around Emacs' built-in undo
;; system, providing more convenient undo/redo functionality.
(use-package
  undo-fu
  :commands
  (undo-fu-only-undo
    undo-fu-only-redo
    undo-fu-only-redo-all
    undo-fu-disable-checkpoint)
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z") 'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

;; The undo-fu-session package complements undo-fu by enabling the saving
;; and restoration of undo history across Emacs sessions, even after restarting.
(use-package
  undo-fu-session
  :commands undo-fu-session-global-mode
  :hook (elpaca-after-init . undo-fu-session-global-mode))

(use-package
  corfu
  :commands (corfu-mode global-corfu-mode)
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-popupinfo-delay '(0.4 . 0.2))
  :bind (:map corfu-map ("C-y" . corfu-insert))
  :hook
  ((prog-mode . corfu-mode)
    (shell-mode . corfu-mode)
    (eshell-mode . corfu-mode))
  :config
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

(use-package
  emacs
  :ensure nil
  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil))

(use-package
  cape
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package
  vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :commands vertico-mode
  :hook (elpaca-after-init . vertico-mode))

(use-package
  vertico-directory
  :ensure nil
  :after vertico
  :bind
  (:map
    vertico-map
    ("RET" . vertico-directory-enter)
    ("DEL" . vertico-directory-delete-char)
    ("M-DEL" . vertico-directory-delete-word)))

(use-package
  orderless
  ;; Vertico leverages Orderless' flexible matching capabilities, allowing users
  ;; to input multiple patterns separated by spaces, which Orderless then
  ;; matches in any order against the candidates.
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package
  marginalia
  ;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
  ;; In addition to that, Marginalia also enhances Vertico by adding rich
  ;; annotations to the completion candidates displayed in Vertico's interface.
  :commands (marginalia-mode marginalia-cycle)
  :hook (elpaca-after-init . marginalia-mode))

(use-package
  embark
  ;; Embark is an Emacs package that acts like a context menu, allowing
  ;; users to perform context-sensitive actions on selected items
  ;; directly from the completion interface.
  :commands
  (embark-act
    embark-dwim
    embark-export
    embark-collect
    embark-bindings
    embark-prefix-help-command)
  :bind
  (("C-." . embark-act) ;; pick some comfortable binding
    ("C-;" . embark-dwim) ;; good alternative: M-.
    ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list
    'display-buffer-alist
    '
    ("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
      nil
      (window-parameters (mode-line-format . none)))))

(use-package
  embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package
  consult
  :bind
  ( ;; C-c bindings in `mode-specific-map'
    ("C-c M-x" . consult-mode-command)
    ("C-c h" . consult-history)
    ("C-c k" . consult-kmacro)
    ("C-c m" . consult-man)
    ("C-c i" . consult-info)
    ([remap Info-search] . consult-info)
    ;; C-x bindings in `ctl-x-map'
    ("C-x M-:" . consult-complex-command)
    ("C-x b" . consult-buffer)
    ("C-x 4 b" . consult-buffer-other-window)
    ("C-x 5 b" . consult-buffer-other-frame)
    ("C-x t b" . consult-buffer-other-tab)
    ("C-x r b" . consult-bookmark)
    ("C-x p b" . consult-project-buffer)
    ;; Custom M-# bindings for fast register access
    ("M-#" . consult-register-load)
    ("M-'" . consult-register-store)
    ("C-M-#" . consult-register)
    ;; Other custom bindings
    ("M-y" . consult-yank-pop)
    ;; M-g bindings in `goto-map'
    ("M-g e" . consult-compile-error)
    ("M-g f" . consult-flymake)
    ("M-g g" . consult-goto-line)
    ("M-g M-g" . consult-goto-line)
    ("M-g o" . consult-outline)
    ("M-g m" . consult-mark)
    ("M-g k" . consult-global-mark)
    ("M-g i" . consult-imenu)
    ("M-g I" . consult-imenu-multi)
    ;; M-s bindings in `search-map'
    ("M-s d" . consult-find)
    ("M-s c" . consult-locate)
    ("M-s g" . consult-grep)
    ("M-s G" . consult-git-grep)
    ("M-s r" . consult-ripgrep)
    ("M-s l" . consult-line)
    ("M-s L" . consult-line-multi)
    ("M-s k" . consult-keep-lines)
    ("M-s u" . consult-focus-lines)
    ;; Isearch integration
    ("M-s e" . consult-isearch-history)
    :map
    isearch-mode-map
    ("M-e" . consult-isearch-history)
    ("M-s e" . consult-isearch-history)
    ("M-s l" . consult-line)
    ("M-s L" . consult-line-multi)
    ;; Minibuffer history
    :map
    minibuffer-local-map
    ("M-s" . consult-history)
    ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  ;; Optionally configure the register formatting. This improves the register
  (setq
    register-preview-delay 0.5
    register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq
    xref-show-xrefs-function #'consult-xref
    xref-show-definitions-function #'consult-xref)

  :config
  (consult-customize
    consult-theme
    :preview-key
    '(:debounce 0.2 any)
    consult-ripgrep
    consult-git-grep
    consult-grep
    consult-bookmark
    consult-recent-file
    consult-xref
    consult--source-bookmark
    consult--source-file-register
    consult--source-recent-file
    consult--source-project-recent-file
    ;; :preview-key "M-."
    :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package treesit-fold)

(add-hook 'emacs-lisp-mode-hook #'outline-minor-mode)

(set-frame-font "Maple Mono NF-11" nil t)

(use-package nerd-icons :custom (nerd-icons-font-family "Maple Mono NF"))

(use-package
  nerd-icons-completion
  :after marginalia
  :config (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package
  nerd-icons-corfu
  :after corfu
  :config (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired :hook (dired-mode . nerd-icons-dired-mode))

(use-package doom-modeline :hook (elpaca-after-init . doom-modeline-mode))

(use-package
  which-key
  :ensure nil
  :commands which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 1.5)
  (which-key-idle-secondary-delay 0.25)
  (which-key-add-column-padding 1)
  (which-key-max-description-length 40))

;; Display of relative line numbers in the buffer:
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(unless
  (and (eq window-system 'mac) (bound-and-true-p mac-carbon-version-string))
  ;; Enables `pixel-scroll-precision-mode' on all operating systems and Emacs
  ;; versions, except for emacs-mac.
  ;;
  ;; Enabling `pixel-scroll-precision-mode' is unnecessary with emacs-mac, as
  ;; this version of Emacs natively supports smooth scrolling.
  ;; https://bitbucket.org/mituharu/emacs-mac/commits/65c6c96f27afa446df6f9d8eff63f9cc012cc738
  (setq pixel-scroll-precision-use-momentum nil) ; Precise/smoother scrolling
  (pixel-scroll-precision-mode 1))

(use-package
  dired
  :ensure nil
  :commands (dired)
  :hook ((dired-mode . dired-hide-details-mode) (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package
  dired-subtree
  :after dired
  :bind
  (:map
    dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config (setq dired-subtree-use-backgrounds nil))

(use-package dired-preview :after dired :hook (dired-mode . dired-preview-mode))

(use-package
  org
  :commands (org-mode org-version)
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  (org-startup-truncated t)
  (org-fontify-done-headline t)
  (org-fontify-todo-headline t)
  (org-fontify-whole-heading-line t)
  (org-fontify-quote-and-verse-blocks t))

(use-package rainbow-delimiters :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package
  helpful
  :commands
  (helpful-callable
    helpful-variable
    helpful-key
    helpful-command
    helpful-at-point
    helpful-function)
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-function] . helpful-callable)
  ([remap describe-key] . helpful-key)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  :custom (helpful-max-buffers 7))

(use-package
  elisp-autofmt
  :commands (elisp-autofmt-mode elisp-autofmt-buffer)
  :hook (emacs-lisp-mode . elisp-autofmt-mode)
  :config
  (setq elisp-autofmt-empty-line-max 1)
  (setq elisp-autofmt-style 'fixed))



(use-package ebuku)

(use-package
  telega
  :bind-keymap ("C-c t" . telega-prefix-map)
  :hook (telega-load . telega-appindicator-mode)
  :config
  (setq telega-server-libs-prefix "/usr")
  (setq telega-translate-to-language-by-default "ru"))

(use-package
  telega-mnz
  :ensure nil
  :after telega
  :requires language-detection
  :custom
  (global-telega-mnz-mode t)
  (telega-mnz-use-language-detection 32))

;; (use-package
;;   telega-dashboard
;;   :ensure nil
;;   :after telega
;;   :config (add-to-list 'dashboard-items '(telega-chats . 5)))

(use-package language-detection)

(use-package
  telega-stories
  :ensure nil
  :after telega
  :bind (:map telega-root-mode-map ("v e" . telega-view-emacs-stories))
  :config (telega-stories-mode 1))

(use-package telega-dired-dwim :ensure nil :after telega)

(use-package
  osm
  :bind ("C-c m" . osm-prefix-map)
  :custom
  (osm-server 'default)
  (osm-copyright t))

(use-package
  dashboard
  :hook
  (elpaca-after-init
    .
    (lambda ()
      (dashboard-insert-startupify-lists)
      (dashboard-initialize)))
  :config (dashboard-setup-startup-hook))

(use-package
  chezmoi
  :bind ("C-c C f" . chezmoi-find)
  :bind ("C-c C w" . chezmoi-write))

;; Colorscheme
(mapc #'disable-theme custom-enabled-themes) ; Disable all active themes
(use-package
  gruvbox-theme
  :hook (elpaca-after-init . (lambda () (load-theme 'gruvbox t))))

(require 'man)
(set-face-attribute 'Man-overstrike nil :inherit font-lock-type-face :bold t)
(set-face-attribute 'Man-underline nil
  :inherit font-lock-keyword-face
  :underline t)

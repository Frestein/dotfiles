;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(when (and (not (modulep! :ui doom-dashboard))
           (modulep! :lang org))
  (setopt inhibit-startup-screen t)
  (setopt inhibit-startup-message t)
  (setopt inhibit-startup-echo-area-message (user-login-name))
  (setopt initial-scratch-message "")
  (setopt initial-buffer-choice
          (lambda ()
            (if (get-buffer "*Org Agenda*")
                (if (get-buffer-window "*Org Agenda*" 'visible)
                    (eshell "γνῶθι σεαυτόν")
                  (get-buffer "*Org Agenda*"))
              (progn
                (org-agenda nil "d")
                (delete-other-windows)
                (add-hook 'server-after-make-frame-hook #'org-agenda-redo nil t)
                (get-buffer "*Org Agenda*")))))

  (add-hook 'doom-first-input-hook #'org-agenda-redo))

(setopt doom-theme 'doom-gruvbox)

(custom-theme-set-faces! 'doom-gruvbox
  `(mode-line :background ,(doom-color 'base3) :foreground ,(doom-color 'modeline-fg)))

(setopt doom-font                (font-spec :family "Maple Mono NF" :size 14))
(setq   doom-big-font            (font-spec :family "Maple Mono NF" :size 24))
(setopt doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14))
(setopt doom-serif-font          (font-spec :family "Noto Serif" :size 14))
(setopt doom-emoji-font          (font-spec :family "Twemoji" :size 14))

(setopt doom-symbol-font doom-font)
(setq doom-symbol-fallback-font-families '("Twemoji"))

(when (modulep! :app telega)
  (after! telega
    (setopt telega-emoji-font-family "Twemoji")))

(when (modulep! :ui unicode)
  (after! unicode-fonts
    (setopt unicode-fonts-fallback-font-list doom-symbol-fallback-font-families)

    (dolist (block '("Dingbats"
                     "Emoticons"
                     "Transport and Map Symbols"
                     "Miscellaneous Symbols and Pictographs"
                     "Enclosed Alphanumeric Supplement"
                     "Supplemental Symbols and Pictographs"))
      (push "Twemoji" (cadr (assoc block unicode-fonts-block-font-mapping))))))

(when (modulep! :ui ligatures)
  (after! ligature
    ;; Arrow operators
    (defvar +ligature-arrows
      '("<-" "->" "<--" "-->" "--->" "<---" "->>" "<<-" "<->" "<=>" "=>" "==>" "<=="
        "<==>" "<-->" "<---->" "<===>" "<====>" ">->" "<-<" "|->" "<-|" "~>" "<~"
        "~~>" "<~~" "<~>" "-~" "~-" ">=>" "<=<" ">>-" "-<<" ">-" ">--" "--<" "->-" ">-"
        ">->" "<-<" "|->" "<-|" "~>" "<~" "~~>" "<~~" "<~>" "-~" "~-" ">=>" "<=<"))

    ;; Extra/long arrows
    (defvar +ligature-arrows-extra
      '("=======" "-------" "~~~~~~~" "<==>" "<===>" "<====>" "<<==" "==>>" "<<==>>"
        "|->" "<-|" ">>->" "<<-<<" ">>=>" "<=<<" ">>=>" "<-<<" "|=>" "<=|" "=>>"
        "<<=" "=<<" "=>=" "=<=" ">-" "-<" ">--" "--<" ">---" "<---" "----" "-----"
        "------" "=======" ">>>>" "<<<<" ">>>" "<<<" ">>" "<<"))

    ;; C-like operators
    (defvar +ligature-c-like
      '("<<" "<<<" ">>" ">>>" "&&" "&&&" "||" "++" "+++" "--" "---" "/*" "*/" "//" "///"
        "!=" "!==" "===" "==" ">=" "<=" "|=" "^=" "&=" "+=" "-=" "*=" "/=" "%=" "??" "???"
        "?." "::" ":::" "##" "#?" "#!" "#:" "#=" "#_" "#__" "#_(" "..." ".." ".=" "->"
        "<:" ":>" "<%" "%>" "<:" ":>" "<::" "::>" "##" "#@" "#$" "#!" "#:" "#=" "#_"
        "#__" "#_(" "]#" "#######" "0xA12 0x56 1920x1080"))

    ;; HTML/XML specific
    (defvar +ligature-html
      '("</" "/>" "</>" "<!--" "<!---->" "<#--" "{{--" "{{!--" "--}}"))

    ;; Brackets and similar constructs
    (defvar +ligature-brackets
      '("{{" "}}" "{|" "|}" "[|" "|]" "<|" "|>" "<|>" "<||" "||>" "<|||" "|||>" "_|_"
        "<!" "<?" "?>" "<%" "%>" "<:" ":>" "<=" "=>"))

    ;; Lisp-specific (comments, reader macros)
    (defvar +ligature-lisp
      '(";;" ";;;" "#;" "#!" "#:" "#=" "#_" "#__" "#_(" "#?" "#!" "#:" "#="))

    ;; Markdown headings and separators
    (defvar +ligature-markdown
      '("##" "###" "####" "#####" "######" "--" "---" "----" "-----" "------"))

    ;; Logging markers and special comments
    (defvar +ligature-log
      '("[TRACE]" "[DEBUG]" "[INFO]" "[WARN]" "[ERROR]" "[FATAL]" "[TODO]" "[FIXME]"
        "[NOTE]" "[HACK]" "[MARK]" "[EROR]" "[WARNING]" "todo))" "fixme))"))

    ;; Functional programming operators
    (defvar +ligature-functional
      '("::" ":::" "=>" "=>>" "<=<" ">=>" "<|>" "|>" "<|" "<$>" "<$" "$>" "<*>" "<*" "*>"
        "<~>" "~~" "~-" "~@" "~~~~~~~" "\\/" "/\\" "|-" "-|" "%%" "<~" "~>" "<~>" "-~" "~-"
        "=:" ":=" ":=:" "=:=" "<." "<.>" ".>" "+*" "=*" "(*" "*)"))

    ;; Common letter ligatures
    (defvar +ligature-letters
      '("ff" "tt" "ll" "Cl" "al" "cl" "el" "il" "tl" "ul" "xl" "all" "ell" "ill" "ull"
        "Fl" "Tl" "fi" "fj" "fl" "ft" "www"))

    ;; Global letter ligatures
    (ligature-set-ligatures 't +ligature-letters)

    ;; Programming modes
    (ligature-set-ligatures
     '(prog-mode conf-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-c-like
       ,@+ligature-html
       ,@+ligature-brackets
       ,@+ligature-lisp
       ,@+ligature-functional
       ,@+ligature-log))

    ;; Text modes
    (ligature-set-ligatures
     '(text-mode markdown-mode markdown-ts-mode gfm-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-markdown))

    ;; JavaScript / TypeScript / PHP
    (ligature-set-ligatures
     '(js-mode typescript-mode typescript-ts-mode php-ts-mode php-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-c-like
       ,@+ligature-html
       ,@+ligature-brackets
       ,@+ligature-functional
       ,@+ligature-log))

    ;; C-like language modes
    (ligature-set-ligatures
     '(c-mode c++-mode java-mode java-ts-mode csharp-mode csharp-ts-mode
       rust-mode rust-ts-mode go-mode go-ts-mode zig-mode zig-ts-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-c-like
       ,@+ligature-brackets
       ,@+ligature-functional
       ,@+ligature-log))

    ;; Lisp modes
    (ligature-set-ligatures
     '(emacs-lisp-mode lisp-mode lisp-data-mode common-lisp-mode
       hy-mode scheme-mode geiser-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-lisp
       ,@+ligature-functional))

    ;; Functional languages
    (ligature-set-ligatures
     '(haskell-mode haskell-ts-mode elm-mode elm-ts-mode purescript-mode
       purescript-ts-mode ml-mode caml-mode tuareg-mode fsharp-mode fstar-mode
       fsharp-ts-mode dafny-mode swift-mode coq-mode idris-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-functional
       ,@+ligature-brackets
       ,@+ligature-log))

    ;; HTML/XML modes
    (ligature-set-ligatures
     '(html-mode nxml-mode)
     `(,@+ligature-arrows
       ,@+ligature-arrows-extra
       ,@+ligature-html
       ,@+ligature-brackets
       ,@+ligature-log))))

(custom-set-faces!
  '((font-lock-comment-face font-lock-keyword-face) :slant italic))

(setq doom-reload-command
      (format "%s sync -B -e --aot"
              ;; INFO: /usr/bin/env doesn't exist on Android
              (if (featurep :system 'android)
                  "sh %s"
                "%s")))

(defun fr/current-emacs-is-systemd-service-p ()
  "Check if current Emacs process is started by a systemd user service."
  (let* ((ppid (string-to-number
                (shell-command-to-string
                 (format "ps -o ppid= -p %d" (emacs-pid)))))
         (ppid-cmd (shell-command-to-string
                    (format "ps -o args= -p %d" ppid))))
    (string-match-p "systemd --user" ppid-cmd)))

(defadvice! doom/restart-systemd ()
  "Restart Emacs (use systemd if current process is from a service)."
  :override #'doom/restart
  (interactive)
  (if (fr/current-emacs-is-systemd-service-p)
      (start-process "systemd-restart" nil "systemctl" "--user" "restart" "emacs")
    (unless (fboundp 'restart-emacs)
      (user-error "Cannot restart Emacs 28 or older"))
    (restart-emacs)))

(with-eval-after-load "lib/docs"
  (remove-hook! 'doom-docs-mode-hook #'doom-docs--display-menu-h))

(setopt user-full-name "Frestein"
        user-mail-address "frestein@tuta.io")

(defun toggle-echo-area-messages ()
  "Toggle the log of recent echo-area messages: the `*Messages*' buffer.
The number of messages retained in that buffer is specified by
the variable `message-log-max'."
  (interactive)
  (if-let* ((win (get-buffer-window (messages-buffer))))
      (quit-window nil win)
    (view-echo-area-messages)))

;; Increase how much is read from processes in a single chunk
(setq read-process-output-max (* 4 1024 1024))

(setq process-adaptive-read-buffering nil)

;; Don't ping things that look like domain names.
(setopt ffap-machine-p-known 'reject)

(use-package! xdg
  :demand t)

(setopt shell-file-name (executable-find "bash"))

(when (executable-find "fish")
  (setopt explicit-shell-file-name (executable-find "fish"))
  (after! vterm
    (setopt vterm-shell (executable-find "fish"))))

(when (modulep! :term eshell)
  (after! eshell
    (setopt eshell-history-size 10000)
    (setopt eshell-buffer-maximum-lines 10000)
    (setopt eshell-banner-message ""))    ; Disable top banner message

  (after! esh-mode
    (map! :map eshell-mode-map
          :n [return] #'eshell-send-input
          :n [S-return] #'+eshell/goto-end-of-prompt
          :i "C-p" #'eshell-previous-matching-input-from-input
          :i "C-n" #'eshell-next-matching-input-from-input
          :i "C-k" #'eshell-previous-prompt
          :i "C-j" #'eshell-next-prompt))

  (after! em-term
    (dolist (cmd '("btm" "btop" "cha" "yt-x" "yazi" "journalctl" "fzf" "tv" "hx" "helix"))
      (add-to-list 'eshell-visual-commands cmd))))

(when (modulep! :term eshell)
  (after! em-alias
    (setq +eshell-aliases nil)

    (setq eshell-command-aliases-list
          '(("tb" "nc termbin.com 9999")
            ("q" "exit")
            ("e" "find-file $1")
            ("ee" "find-file-other-window $1")
            ("d" "dired $1")
            ("bd" "eshell-up $1")
            ("gg" "magit-status")
            ("cdp" "cd-to-project")
            ("c" "clear-scrollback")
            ("clear" "clear-scrollback")))

    (defun fr/eshell-append-aliases (alist)
      (setq eshell-command-aliases-list
            (append eshell-command-aliases-list alist)))

    (when (executable-find "eza")
      (defcustom fr/eshell--eza-defaults "--group --group-directories-first"
        "Default flags for eza used by eshell aliases."
        :type 'string
        :group 'eshell)

      (fr/eshell-append-aliases
       `(("lD"  ,(concat "eza -lD " fr/eshell--eza-defaults " $*"))
         ("lS"  ,(concat "eza -lS " fr/eshell--eza-defaults " $*"))
         ("lT"  ,(concat "eza -lT " fr/eshell--eza-defaults " $*"))
         ("laD" ,(concat "eza -laD " fr/eshell--eza-defaults " $*"))
         ("ldot",(concat "eza -ld -a " fr/eshell--eza-defaults " $*"))
         ("l"   ,(concat "eza -l " fr/eshell--eza-defaults " $*"))
         ("ll"  ,(concat "eza -la " fr/eshell--eza-defaults " $*"))
         ("lr"  ,(concat "eza -R " fr/eshell--eza-defaults " $*"))
         ("ls"  ,(concat "eza " fr/eshell--eza-defaults " $*"))
         ("lsd" ,(concat "eza -d " fr/eshell--eza-defaults " $*"))
         ("lsdl",(concat "eza -dl " fr/eshell--eza-defaults " $*")))))

    (when (executable-find "bc")
      (fr/eshell-append-aliases '(("bc" "bc -q $*"))))

    (when (executable-find "btm")
      (fr/eshell-append-aliases '(("btm" "btm -b --hide_avg_cpu $*"))))

    (when (executable-find "trans")
      (fr/eshell-append-aliases
       '(("t" "trans :ru $*")
         ("tt" "trans :en $*")
         ("tl" "trans :ru --shell --brief $*")
         ("ttl" "trans :en --shell --brief $*"))))

    (when (executable-find "fastfetch")
      (fr/eshell-append-aliases
       `(("f" "fastfetch $*")
         ("ff" ,(concat "fastfetch -c " (xdg-config-home) "/fastfetch/config-full.jsonc $*")))))

    (when (executable-find "rg")
      (fr/eshell-append-aliases '(("rg" "rg --color=always $*"))))

    (when (executable-find "git")
      (fr/eshell-append-aliases '(("git" "git --no-pager $*"))))

    (when (executable-find "chezmoi")
      (after! chezmoi
        (fr/eshell-append-aliases '(("cz-magit" "chezmoi-magit-status"))))

      (fr/eshell-append-aliases '(("cz" "chezmoi $*")
                                  ("czx" "CZ_EXT=1 chezmoi $*"))))

    (when (executable-find "systemctl")
      (fr/eshell-append-aliases '(("sc" "systemctl $*")
                                  ("scu" "systemctl --user $*")
                                  ("jctl" "journalctl -p 3 -xb $*"))))

    (when (executable-find "speedtest-go")
      (fr/eshell-append-aliases '(("speedtest" "speedtest-go $*"))))

    (when (executable-find "pacman")
      (fr/eshell-append-aliases
       `(("pacrip" "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -$1 | nl")
         ("pacupg" "doas pacman -Syu $*")
         ("pacin"  "doas pacman -S $*")
         ("paclean" "doas pacman -Sc $*")
         ("pacins" "doas pacman -U $*")
         ("paclr"  "doas pacman -Scc $*")
         ("pacre"  "doas pacman -R $*")
         ("pacrem" "doas pacman -Rns $*")
         ("pacrep" "pacman -Si $*")
         ("pacreps" "pacman -Ss $*")
         ("pacloc" "pacman -Qi $*")
         ("paclocs" "pacman -Qs $*")
         ("paclst" "pacman -Qe $*")
         ("pacinsd" "doas pacman -S --asdeps $*")
         ("pacmir"  "doas pacman -Syy $*")
         ("paclsorphans" "doas pacman -Qdt $*")
         ("pacrmorphans" "doas pacman -Rs $(pacman -Qtdq)")
         ("pacfileupg" "doas pacman -Fy $*")
         ("pacfiles" "pacman -F $*")
         ("pacls"   "pacman -Ql $*")
         ("pacown"  "pacman -Qo $*")
         ("pacupd"  "doas pacman -Sy $*")
         ("pacmanallkeys" "doas pacman-key --refresh-keys $*"))))

    (when (executable-find "yay")
      (fr/eshell-append-aliases
       `(("yaconf" "yay -Pg $*")
         ("yaclean" "yay -Sc $*")
         ("yaclr"  "yay -Scc $*")
         ("yaupg"  "yay -Syu $*")
         ("yasu"   "yay -Syu --noconfirm $*")
         ("yain"   "yay -S $*")
         ("yains"  "yay -U $*")
         ("yare"   "yay -R $*")
         ("yarem"  "yay -Rns $*")
         ("yarep"  "yay -Si $*")
         ("yareps" "yay -Ss $*")
         ("yaloc"  "yay -Qi $*")
         ("yalocs" "yay -Qs $*")
         ("yalst"  "yay -Qe $*")
         ("yaorph" "yay -Qtd $*")
         ("yainsd" "yay -S --asdeps $*")
         ("yamir"  "yay -Syy $*")
         ("yaupd"  "yay -Sy $*"))))))

(use-package! esh-autosuggest
  :when (modulep! :term eshell)
  :hook (eshell-mode . esh-autosuggest-mode)
  :config
  (map! :map eshell-mode-map
        :i "C-\\" #'esh-autosuggest-complete-word))

(use-package! eshell-atuin
  :when (and (modulep! :term eshell)
             (executable-find "atuin"))
  :hook (eshell-mode . eshell-atuin-mode)
  :config
  (when (modulep! :completion vertico)
    (setopt eshell-atuin-search-fields '(time duration command))
    (setopt eshell-atuin-history-format "%-160c %t + %d"))

  (defun fr/eshell-history (&optional arg)
    "Search eshell command history; by default use `+eshell/search-history'.
If called with a prefix argument, use `eshell-atuin-history' instead."
    (interactive "P")
    (if arg
        (eshell-atuin-history)
      (+eshell/search-history)))

  (map! :map eshell-mode-map
        :ni "C-r" #'fr/eshell-history
        (:localleader
         "s" #'fr/eshell-history)))

(use-package! eshell-vterm
  :when (and (modulep! :term eshell)
             (modulep! :term vterm))
  :hook (eshell-load . eshell-vterm-mode))

(when (modulep! :term vterm)
  (after! vterm
    (setopt vterm-always-compile-module t)
    (setopt vterm-max-scrollback 10000)

    (set-popup-rule! "^\\*vterm" :ignore t)
    (set-popup-rule! "^ \\*Install vterm" :height 0.25 :ttl 0)
    (+popup-cleanup-rules-h)

    ;; Thanks - https://github.com/akermu/emacs-libvterm/issues/313#issuecomment-1183650463
    (advice-add #'vterm--redraw :around (lambda (fun &rest args) (let ((cursor-type cursor-type)) (apply fun args))))

    (when (modulep! :tools chezmoi)
      (add-to-list 'vterm-eval-cmds '("chezmoi-magit-status" chezmoi-magit-status)))

    ;; Thanks - https://github.com/akermu/emacs-libvterm/issues/749
    (defadvice! fr/vterm-better-kill (orig-fun &rest args)
      "Override kill-buffer for vterm: kill without confirmation when vterm is idle."
      :around #'kill-buffer
      (if (eq major-mode 'vterm-mode)
          (let ((process (get-buffer-process (current-buffer))))
            (when process
              (if (vterm--at-prompt-p)
                  (set-process-query-on-exit-flag process nil)
                (set-process-query-on-exit-flag process t)))))
      (apply orig-fun args))

    (defun fr/switch-to-buffer-kill (&optional arg)
      (interactive "P")
      (let ((embark-default-action-overrides '((buffer . kill-buffer)))
            ;; Force kill buffer is not in pre-action-hooks, and don't worry if embark-preaction-hooks exist.
            (embark-pre-action-hooks nil)
            embark-quit-after-action)
        (embark-dwim arg)))

    (defun fr/vterm--close-buffer-on-exit (_buffer _event)
      "Close `vterm' buffer and its window upon process exit."
      (let ((buf (current-buffer))
            (win (get-buffer-window (current-buffer))))
        (when (buffer-live-p buf)
          (when (and win (not (one-window-p)))
            (delete-window win))
          (kill-buffer buf))))

    (defun fr/browse-url-text-vterm (url &optional new-buffer)
      "Ask a text browser to load URL inside `vterm'."
      (interactive (browse-url-interactive-arg "Text browser URL: "))
      (let* ((bufname "*vterm text browser*")
             (buf (if new-buffer
                      (generate-new-buffer-name bufname)
                    bufname))
             (proc (when (get-buffer buf) (get-buffer-process buf)))
             (encoded-url (format "\"%s\"" (url-encode-url url)))
             (browser-cmd (format "exec %s %s" browse-url-text-browser encoded-url)))
        (if (or new-buffer (not (get-buffer buf)) (not proc) (not (memq (process-status proc) '(run stop))))
            (progn
              (vterm buf)
              (add-hook 'vterm-exit-functions #'fr/vterm--close-buffer-on-exit nil t)
              (vterm-send-string browser-cmd)
              (vterm-send-return)
              (switch-to-buffer buf)
              (delete-other-windows))
          (switch-to-buffer buf)
          (vterm-send-string (concat "g \C-u" encoded-url "\r"))
          (delete-other-windows))))

    (map! :map minibuffer-local-map
          :ni "M-k" #'fr/switch-to-buffer-kill)

    (map! :map vterm-mode-map
          :ni "C-k" #'vterm-previous-prompt
          :ni "C-j" #'vterm-next-prompt)))

(when (modulep! :app everywhere)
  (setopt emacs-everywhere-window-focus-command (list "hyprctl" "dispatch" "focuswindow" "address:%w"))
  (setopt emacs-everywhere-app-info-function #'emacs-everywhere--app-info-linux-hyprland)

  (require 'json)
  (defun emacs-everywhere--app-info-linux-hyprland ()
    "Return information on the current active window, on a Linux Hyprland session."
    (let* ((json-string (emacs-everywhere--call "hyprctl" "-j" "activewindow"))
           (json-object (json-read-from-string json-string))
           (window-id (cdr (assoc 'address json-object)))
           (app-name (cdr (assoc 'class json-object)))
           (window-title (cdr (assoc 'title json-object)))
           (window-geometry (list (aref (cdr (assoc 'at json-object)) 0)
                                  (aref (cdr (assoc 'at json-object)) 1)
                                  (aref (cdr (assoc 'size json-object)) 0)
                                  (aref (cdr (assoc 'size json-object)) 1))))
      (make-emacs-everywhere-app
       :id window-id
       :class app-name
       :title window-title
       :geometry window-geometry))))

(setopt epg-gpg-home-directory (getenv "GNUPGHOME"))

(when (modulep! :config default +gnupg)
  (use-package! pinentry
    :hook (doom-after-init . pinentry-start)))

(when (modulep! :config default)
  (after! xdg
    (setopt auth-sources (list (concat (xdg-config-home) "/authinfo")
                               (file-name-concat doom-profile-state-dir "authinfo.gpg")))))

(when (modulep! :tools pass)
  ;; INFO: Do not backup gopass files.
  (when (executable-find "gopass")
    (setopt backup-enable-predicate
            (lambda (name)
              (if (string-match-p "/dev/shm/gopass" name)
                  nil
                (normal-backup-enable-predicate name)))))

  (use-package! password-store
    :config
    (when (executable-find "gopass")
      (setq password-store-executable (executable-find "gopass"))))

  (use-package! pass
    :config
    (setopt pass-show-keybindings nil)))

(setopt gnutls-verify-error t) ; Prompts user if there are certificate issues
(setopt tls-checktrust t)      ; Ensure SSL/TLS connections undergo trust verification

(when (modulep! :emacs dired)
  (setopt delete-by-moving-to-trash t)
  (setopt dired-mouse-drag-files t)
  (setopt mouse-drag-and-drop-region-cross-program t)

  (map! :map dired-mode-map
        :v "u" #'dired-unmark))

(when (modulep! :emacs dired +dirvish)
  (use-package! dirvish
    :hook (doom-after-init . dirvish-peek-mode)
    :config
    (setopt dirvish-quick-access-entries
            `(("h" "~/"                                 "Home")
              ("d" ,(xdg-user-dir "DOWNLOAD")           "Downloads")
              ("D" ,(xdg-user-dir "DOCUMENTS")          "Documents")
              ("v" ,(xdg-user-dir "VIDEOS")             "Videos")
              ("m" ,(xdg-user-dir "MUSIC")              "Music")
              ("c" ,(getenv "XDG_CONFIG_HOME")          "Config")
              ("C" "~/.local/share/chezmoi/dot_config/" "Dotfiles")
              ("p" ,(xdg-user-dir "PICTURES")           "Pictures")
              ("P" "~/Projects/"                        "Projects")
              ("M" "/mnt/"                              "Drives")
              ("t" "~/.local/share/Trash/files/"        "TrashCan")))

    (setopt dirvish-attributes '(collapse git-msg file-modes file-time)
            dirvish-side-attributes '(collapse))

    (when (modulep! :emacs dired +icons)
      (setopt dirvish-subtree-always-show-state t)
      (cl-callf append dirvish-attributes '(nerd-icons))
      (cl-callf append dirvish-side-attributes '(nerd-icons)))

    (when (modulep! :ui vc-gutter)
      ;; The vc-gutter module uses `diff-hl-dired-mode' + `diff-hl-margin-mode'
      ;; for diffs in dirvish buffers. `vc-state' uses overlays, so they won't be
      ;; visible in the terminal.
      (when (or (daemonp) (display-graphic-p))
        (push 'vc-state dirvish-side-attributes)))

    (dirvish-define-preview eza (file)
      "Use `eza' to generate directory preview."
      :require ("eza")
      (when (file-directory-p file)
        `(shell . ("eza" "-al" "--group" "--group-directories-first" ,file))))

    (push 'eza dirvish-preview-dispatchers)

    (setopt mouse-1-click-follows-link nil)

    (map! :map dirvish-mode-map
          "<mouse-1>" #'dirvish-subtree-toggle-or-open
          "<mouse-2>" #'dired-mouse-find-file-other-window
          "<mouse-3>" #'dired-mouse-find-file
          :n "gd" #'dirvish-quick-access)))

(setopt default-input-method "russian-computer")
(setopt calendar-week-start-day 1)
(setopt display-line-numbers-type 'relative)
(setopt confirm-kill-emacs nil)
(setopt recentf-max-saved-items 500)

(setopt evil-echo-state nil)

(when (modulep! :editor evil)
  (when (modulep! :app telega)
    (after! telega
      (defun fr/telega-chatbuf-cancel-both ()
        (interactive)
        (telega-chatbuf-filter-cancel)
        (telega-chatbuf-thread-cancel))

      (evil-collection-define-key 'normal 'telega-root-mode-map
        "gVD" #'telega-view-default)

      (evil-collection-define-key 'normal 'telega-chat-mode-map
        "_" #'fr/telega-chatbuf-cancel-both

        "Za" #'telega-chatbuf-attach-animation
        "Zf" #'telega-chatbuf-attach-file
        "Zv" #'telega-chatbuf-attach-video

        (kbd "<tab>") 'telega-button-forward
        (kbd "<backtab>") 'telega-button-backward))))

(when (modulep! :editor evil)
  (after! evil-snipe
    (when (modulep! :app telega)
      (dolist (mode '(telega-root-mode telega-chat-mode telega-chatbuf-mode))
        (unless (memq mode evil-snipe-disabled-modes)
          (push mode evil-snipe-disabled-modes))))
    (when (modulep! :tools ebuku)
      (unless (memq 'ebuku-mode evil-snipe-disabled-modes)
        (push 'ebuku-mode evil-snipe-disabled-modes)))))

(setopt which-key-idle-delay 0.2)
;; (setopt which-key-show-operator-state-maps t) ; BUG: https://github.com/justbur/emacs-which-key/issues/345

(map! :n "C-a" #'evil-numbers/inc-at-pt
      :v "C-a" #'evil-numbers/inc-at-pt-incremental
      :v "C-S-a" #'evil-numbers/inc-at-pt
      :n "C-x" #'evil-numbers/dec-at-pt
      :v "C-x" #'evil-numbers/dec-at-pt-incremental
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      :desc "Previous buffer" :n "<mouse-8>" #'previous-buffer
      :desc "Next buffer" :n "<mouse-9>" #'next-buffer
      :desc "Previous buffer" :n "H" #'previous-buffer
      :desc "Next buffer" :n "L" #'next-buffer
      :v "gss" #'sort-lines
      (:when (modulep! :term vterm )
        :desc "Toggle vterm popup" :n "C-/" #'+vterm/toggle
        :desc "Toggle vterm popup" :i "C-/" #'+vterm/toggle)
      (:when (modulep! :tools zoxide)
        :n "gZ" #'zoxide-find-file))

(map! :leader
      (:prefix ("s" . "search")
               (:when (modulep! :completion vertico)
                 :desc "Ripgrep" "g" #'consult-ripgrep)
               (:when (modulep! :tools pass)
                 "p" nil
                 "P" nil
                 (:prefix ("p" . "project")
                  :desc "Search project" "p" #'+default/search-project
                  :desc "Search other project" "o" #'+default/search-other-project)
                 (:prefix ("P" . "Pass")
                  :desc "Username" "u" #'+pass/copy-user
                  :desc "Password" "p" #'+pass/consult)))
      (:prefix ("i" . "insert")
       :desc "Nerd" "n" #'nerd-icons-insert)
      (:prefix ("p" . "project")
       :desc "Cleanup know projects" "K" #'projectile-cleanup-known-projects)
      (:when (modulep! :app pomm)
        (:prefix ("P" . "pomm")
                 (:prefix ("t" . "Third Time")
                          "s" #'pomm-third-time-start
                          "S" #'pomm-third-time-stop
                          "t" #'pomm-third-time-switch
                          "o" #'pomm-third-time)
                 (:prefix ("p" . "Pomodoro")
                          "s" #'pomm-start
                          "S" #'pomm-stop
                          "o" #'pomm)))
      (:prefix ("o" . "open")
       :desc "Open URL using generic browser" "g" #'browse-url-generic
       :desc "Open URL" "w" #'browse-url
       :desc "Contacts" "c" #'org-contacts
       (:when (modulep! :app pomm)
         :desc "Third Time" "," #'pomm-third-time
         :desc "Pomodoro" "." #'pomm)
       (:when (modulep! :app srs)
         :desc "SRS review" "s" #'+org-srs-review-start-org-directory)
       (:when (modulep! :tools daemons)
         :desc "Daemons" "D" #'daemons)
       (:when (modulep! :term vterm)
         :desc "Open URL using text browser" "W" #'fr/browse-url-text-vterm)
       (:prefix ("a" . "org agenda")
        :desc "Daily Agenda" "d" (lambda () (interactive) (org-agenda nil "d"))
        :desc "Weekly Review" "r" (lambda () (interactive) (org-agenda nil "r"))))
      (:prefix ("c" . "code")
               (:when (modulep! :tools 0x0)
                 :desc "Pastebin code" "p" #'0x0-upload-text)
               (:when (modulep! :tools screenshot)
                 :desc "Screenshot code" "S" #'screenshot))
      (:prefix ("A" . "app")
               (:when (modulep! :tools consult-gh)
                 :desc "Github" "g" #'consult-gh)
               (:when (modulep! :tools ebuku)
                 :desc "Ebuku" "b" #'ebuku)
               (:when (modulep! :tools pass)
                 :desc "Pass" "p" #'pass)
               (:when (modulep! :app osm)
                 :desc "Osm" "m" #'osm-prefix-map)
               (:when (modulep! :app telega)
                 :desc "Telega" "t" telega-prefix-map)
               (:when (modulep! :tools trashed)
                 :desc "Trashed" "T" #'trashed)
               (:when (modulep! :app rss)
                 :desc "Elfeed" "n" #'elfeed)
               (:when (modulep! :app ement)
                 (:prefix ("e" . "ement")
                          "c" #'ement-connect
                          "l" #'ement-room-list
                          "v" #'ement-room-view)))
      (:prefix ("f" . "file")
               (:when (modulep! :tools zoxide)
                 :desc "Zoxide" "z" #'zoxide-find-file)
               (:when (modulep! :emacs dired)
                 :desc "Open directory in dirvish" "m" #'dirvish)
               (:when (modulep! :term eee)
                 :desc "Open directory in yazi" "M" #'ee-yazi))
      (:prefix ("h" . "help")
               "e" #'toggle-echo-area-messages)
      (:prefix ("t" . "toggle")
       :desc "Automatic line breaking" "a" #'auto-fill-mode
       (:when (modulep! :tools blamer)
         :desc "Blamer mode" "B" #'global-blamer-mode)
       (:when (modulep! :ui colorful)
         :desc "Colorful mode" "C" #'global-colorful-mode)
       (:when (modulep! :checkers jinx)
         :desc "Jinx mode" "j" #'jinx-mode))
      (:prefix ("n" . "notes")
               (:when (modulep! :lang org +roam)
                 (:prefix ("r" . "roam")
                          (:when (modulep! :lang org +mem)
                            "s" nil)))))

(defun fr/org-edit-src-code-and-insert ()
  (when (fboundp 'evil-normal-state)
    (evil-normal-state))
  (org-edit-src-code)
  (run-with-timer 0.01 nil
                  (lambda ()
                    (when (fboundp 'evil-insert-state)
                      (evil-insert-state)))))

(when (modulep! :completion corfu)
  (after! corfu
    (setopt corfu-auto nil)))

(when (modulep! :completion corfu)
  (after! (:and corfu eshell)
    (defadvice! fr/corfu-dabbrev-or-next (&optional arg)
      "Invoke `cape-dabbrev' but respect `evil-complete-all-buffers'.

Intended to mimic `evil-complete-next', unless the popup is already open."
      :override #'+corfu/dabbrev-or-next
      (interactive "p")
      (if (and (eq major-mode 'eshell-mode)
               (not (and (frame-live-p corfu--frame) (frame-visible-p corfu--frame))))
          (let ((n (or arg 1)))
            (and (not (memq last-command '(eshell-next-matching-input-from-input
                                           eshell-previous-matching-input-from-input)))
                 (> n 1)
                 (setq n (1+ n)))
            (eshell-next-matching-input-from-input n)
            (setq this-command 'eshell-next-matching-input-from-input))
        (if corfu--candidates
            (corfu-next arg)
          (require 'cape)
          (let ((cape-dabbrev-buffer-function
                 (if (bound-and-true-p evil-complete-all-buffers)
                     #'cape-same-mode-buffers
                   #'current-buffer)))
            (cape-dabbrev t)
            (when (> corfu--total 0)
              (corfu--goto (or arg 0)))))))

    (defadvice! fr/corfu-dabbrev-or-last (&optional arg)
      "Invoke `cape-dabbrev' but respect `evil-complete-all-buffers'.

Intended to mimic `evil-complete-previous', unless the popup is already open."
      :override #'+corfu/dabbrev-or-last
      (interactive "p")
      (if (and (eq major-mode 'eshell-mode)
               (not (and (frame-live-p corfu--frame) (frame-visible-p corfu--frame))))
          ;; Thanks
          ;; https://github.com/emacs-straight/capf-autosuggest/blob/2ba57bf7fcc6183a73f3803edcf6bbcdbc2f5a19/capf-autosuggest.el#L354
          (let ((n (or arg 1)))
            (and (not (memq last-command '(eshell-previous-matching-input-from-input
                                           eshell-next-matching-input-from-input)))
                 (> n 1)
                 (setq n (1+ n)))
            (eshell-previous-matching-input-from-input n)
            (setq this-command 'eshell-previous-matching-input-from-input))
        (if corfu--candidates
            (corfu-previous arg)
          (require 'cape)
          (let ((cape-dabbrev-buffer-function
                 (if (bound-and-true-p evil-complete-all-buffers)
                     #'cape-same-mode-buffers
                   #'current-buffer)))
            (cape-dabbrev t)
            (when (> corfu--total 0)
              (corfu--goto (- corfu--total (or arg 1))))))))))

;; thx Sarg https://github.com/doomemacs/doomemacs/pull/8634/changes
(when (modulep! :completion vertico)
  (with-eval-after-load "lib/help"
    (defvar fr/doom-module-descriptions
      (with-temp-buffer
        (seq-filter
         'identity
         (mapcar
          (lambda (hm)
            (when-let* ((f (cadr hm))
                        (name (car hm))
                        ((file-regular-p f)))
              (insert-file-contents f nil 0 1024 t)
              (goto-char (point-min))
              (when (search-forward "#+subtitle: " nil t)
                (cons name
                      (propertize (string-trim (buffer-substring (point) (line-end-position)))
                                  'face (get-text-property 0 'face name))))))
          (doom--help-modules-list))))))

  (after! marginalia
    (defun marginalia-annotate-doom-module (cand)
      (marginalia--fields
       ((cdr (assoc-string cand fr/doom-module-descriptions)))))

    (add-to-list 'marginalia-prompt-categories '("\\<Describe module\\>" . doom-module))
    (add-to-list 'marginalia-annotators '(doom-module marginalia-annotate-doom-module))))

(when (modulep! :tools eval)
  (set-popup-rule! "^\\*eros inspect" :side 'right :size 0.5 :height 0.5 :ttl 0 :slot 1 :modeline t))

;; BUG: ws-butler removes last line in Org files despite require-final-newline
;; https://github.com/lewang/ws-butler/issues/26
(when (modulep! :editor whitespace +trim)
  (after! ws-butler
    (add-to-list 'ws-butler-global-exempt-modes 'org-mode)))

(when (modulep! :ui smooth-scroll)
  ;; Disable ultra-scroll
  (remove-hook 'doom-first-input-hook #'ultra-scroll-mode)
  (remove-hook 'doom-first-file-hook #'ultra-scroll-mode))

(when (modulep! :ui zen)
  (setq +zen-text-scale 0)
  (setq +zen-mixed-pitch-modes nil)
  (setopt writeroom-width 100))

(when (modulep! :ui hl-todo)
  (after! hl-todo
    (let ((fr/hl-todo-keyword-faces
           '(("TODO" (font-lock-variable-name-face bold) nil)
             ("FIX"  (error bold) nil)
             ("WARN"  (warning bold) ("WARNING" "XXX"))
             ("PERF"  (font-lock-variable-name-face bold) ("OPTIM" "PERFORMANCE" "OPTIMIZE"))
             ("NOTE"  (success bold) ("INFO"))
             ("TEST"  (font-lock-variable-name-face bold) ("TESTING" "PASSED" "FAILED")))))
      (dolist (e fr/hl-todo-keyword-faces)
        (let ((kw (car e)) (faces (cadr e)) (alts (caddr e)))
          (if (assoc kw hl-todo-keyword-faces)
              (when faces
                (setcdr (assoc kw hl-todo-keyword-faces) faces))
            (push (cons kw faces) hl-todo-keyword-faces))
          (dolist (a alts)
            (let ((existing (assoc a hl-todo-keyword-faces)))
              (if existing
                  (when faces (setcdr existing faces))
                (push (cons a faces) hl-todo-keyword-faces)))))))))

(add-to-list 'auto-mode-alist
             '("/\\.?config/git/.*\\'" . gitconfig-mode))

(when (modulep! :tools magit)
  (setopt magit-repository-directories `(("~/Projects" . 2)
                                         (,(xdg-user-dir "DOCUMENTS") . 1)
                                         ("~/.local/share/chezmoi" . 1)))
  (setopt magit-clone-default-directory "~/Projects/git/")

  (after! magit
    ;; HACK: Override magit-log defaults
    (put 'magit-log-mode 'magit-log-default-arguments
         '("--graph" "-n256" "--decorate" "--color" "--show-signature"))))

(when (modulep! :tools magit)
  (after! magit
    (require 'once)

    (defun fr/magit--get-project-unique-identifier ()
      "Generate a unique identifier for the current project."
      (let* ((project-path (magit-toplevel))
             (canonical-path (file-truename project-path)))
        (secure-hash 'md5 canonical-path)))

    ;; Many thanks
    ;; - https://j-e-s-s-e.com/blog/add-conventional-commits-with-scopes-to-your-magit-commit-messages
    ;; - https://github.com/jesse-c/dotfiles/blob/8b9326ea7d37687d365efa9e86cb30056665beec/home/dot_config/emacs/init.el#L551
    (defun fr/magit--find-conventional-commit-scopes ()
      "Find all scopes used in conventional commits in the current Git project."
      (let* ((project-id (fr/magit--get-project-unique-identifier))
             (cache-dir (expand-file-name
                         (format "magit/conventional-commits/%s" project-id)
                         doom-cache-dir))
             (cache-file (expand-file-name "commit-scopes.txt" cache-dir))
             (default-directory (magit-toplevel))
             (temp-buffer (generate-new-buffer " *commit-scopes-temp*")))

        ;; Create cache directory if it doesn't exist
        (unless (file-exists-p cache-dir)
          (make-directory cache-dir t))

        ;; Use Emacs Lisp to extract scopes directly
        (with-current-buffer temp-buffer
          (call-process "git" nil t nil "log" "--pretty=format:%s")
          (goto-char (point-min))

          ;; Extract scopes using a regular expression
          (let ((scopes '()))
            (while (re-search-forward "\\(feat\\|fix\\|docs\\|style\\|refactor\\|perf\\|test\\|build\\|ci\\|chore\\|revert\\)(\\([^)]+\\))" nil t)
              (let ((scope-text (match-string 2)))
                ;; Split by comma and add each scope
                (dolist (scope (split-string scope-text "," t "[ \t]+"))
                  (push (string-trim scope) scopes))))

            ;; Write unique scopes to the cache file
            (with-temp-file cache-file
              (insert (mapconcat #'identity (delete-dups scopes) "\n")))))

        (kill-buffer temp-buffer)

        ;; Return the cache file path
        cache-file))

    (defun fr/magit--get-commit-scopes ()
      "Get commit scopes from cache or generate them if needed."
      (let* ((project-id (fr/magit--get-project-unique-identifier))
             (cache-dir (expand-file-name
                         (format "magit/conventional-commits/%s" project-id)
                         doom-cache-dir))
             (cache-file (expand-file-name "commit-scopes.txt" cache-dir))
             (default-directory (magit-toplevel)))
        (unless (and (file-exists-p cache-file)
                     (> (time-to-seconds (time-since (file-attribute-modification-time (file-attributes cache-file))))
                        (* 60 60 24)))  ; Cache for 24 hours
          (fr/magit--find-conventional-commit-scopes))

        (when (file-exists-p cache-file)
          (with-temp-buffer
            (insert-file-contents cache-file)
            (split-string (buffer-string) "\n" t)))))

    (defun fr/magit-conventional-commit-prompt ()
      "Prompt for conventional commit type with scope completion."
      (let ((commit-types '("feat" "fix" "docs" "style" "refactor" "perf" "test" "build" "ci" "cd" "chore" "revert")))
        (condition-case nil
            (if (y-or-n-p "Use conventional commit format? ")
                (let* ((type (completing-read "Commit type: " commit-types nil t))
                       (scopes (fr/magit--get-commit-scopes))
                       (scope-input (completing-read "Scope (optional, comma-separated for multiple): " scopes nil nil)))
                  (insert type
                          (if (string-empty-p scope-input)
                              ""
                            (concat "(" scope-input ")"))
                          ": ")
                  (save-excursion
                    (newline))
                  (evil-insert-state))
              (evil-insert-state))
          (quit
           (evil-insert-state)))))

    (defadvice! fr/magit-commit-with-conventional-prompt (&rest args)
      "Advice for `magit-commit-create': adds conventional commit prompt only for this command."
      :before #'magit-commit-create
      (once-hook 'git-commit-setup-hook #'fr/magit-conventional-commit-prompt))))

(use-package! magit-delta
  :when (and (modulep! :tools magit +delta)
             (executable-find "delta"))
  :hook (magit-mode . magit-delta-mode)
  :config
  (setopt magit-delta-default-dark-theme "gruvbox-dark")
  (setopt magit-delta-default-light-theme "gruvbox-light")
  (setopt magit-delta-hide-plus-minus-markers nil))

(use-package! magit-todos
  :when (and (modulep! :tools magit)
             (modulep! :ui hl-todo))
  :hook (magit-mode . magit-todos-mode)
  :custom
  (magit-todos-ignored-keywords '("NOTE" "INFO" "MAYBE" "HACK" "TEMP"
                                  "KLUDGE" "DONT" "OKAY" "PROG" "THEM"
                                  "NEXT" "DONE")))

(setopt projectile-project-search-path '(("~/Projects/" . 2)))

(when (modulep! :tools pdf)
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)
  (add-hook 'pdf-view-mode-hook #'(lambda () (hl-line-mode 0)))

  (map! :map pdf-view-mode-map
        :n "gp" #'pdf-view-goto-page))

(when (modulep! :tools pdf)
  (use-package! pdf-misc
    :after pdf-view
    :bind (:map pdf-view-mode-map
                ([remap pdf-misc-print-document] . 'fr/pdf-misc-print-pages))
    :config
    (setopt pdf-misc-print-program-executable (executable-find "lp"))

    (defun fr/pdf-misc-print-pages (filename pages &optional interactive-p)
      "Wrapper for `pdf-misc-print-document' to add page selection support"
      (interactive (list (pdf-view-buffer-file-name)
                         (read-string "Page range (empty for all pages): "
                                      (number-to-string (pdf-view-current-page)))
                         t)
                   pdf-view-mode)
      (let ((pdf-misc-print-program-args
             (if (not (string-blank-p pages))
                 (cons (concat "-P " pages) pdf-misc-print-program-args)
               pdf-misc-print-program-args)))
        (pdf-misc-print-document filename)))))

(after! elisp-mode
  (map! :map emacs-lisp-mode-map
        :localleader
        (:prefix "e"
         :desc "Evaluate buffer" "b" #'eval-buffer
         :desc "Evaluate region" "r" #'eval-region
         :desc "Load library" "l" #'load-library
         (:when (modulep! :tools eval)
           :desc "Evaluate last" "e" #'eros-eval-last-sexp
           :desc "Inspect last" "i" #'eros-inspect-last-result
           :desc "Evaluate defun" "d" #'eros-eval-defun))))

(when (modulep! :lang common-lisp)
  (add-to-list '+lisp-quicklisp-paths (expand-file-name "quicklisp" (xdg-data-home)))

  (after! sly
    (map! :map lisp-mode-map
          :localleader
          (:prefix "e"
                   (:when (modulep! :tools eval)
                     :desc "Evaluate last" "e" #'eros-eval-last-sexp
                     :desc "Inspect last" "i" #'eros-inspect-last-result
                     :desc "Evaluate defun (async)" "f" #'eros-eval-defun)))))

(when (modulep! :lang org)
  (setopt org-directory (expand-file-name "org" (xdg-user-dir "DOCUMENTS")))

  (setopt org-log-into-drawer t)
  (setopt org-log-done 'time)

  (setopt org-hide-emphasis-markers t)
  (setopt org-edit-src-persistent-message nil)

  (setopt org-startup-with-link-previews t)

  (setopt org-read-date-force-compatible-dates nil)

  ;; BUG: The second format is displayed incorrectly.
  ;; For example:
  ;; SCHEDULED: <2025-09-26 Fri 02:00 PM-16:00>
  ;; The end time is shown in 24-hour format instead of using %I:%M %p.
  ;; (setopt org-display-custom-times t)
  ;; (setopt org-timestamp-custom-formats '("%Y-%m-%d %a" . "%Y-%m-%d %a %I:%M %p"))

  (defun fr/org-fold-respect-startup-ignore-tag ()
    "Fold according to `#+STARTUP:' and ignore folding for tags from `#+STARTUP_IGNORE:'."
    (when (eq major-mode 'org-mode)
      (save-excursion
        (goto-char (point-min))
        (let* ((case-fold-search t)
               (ignore-line (when (re-search-forward
                                   "^#\\+STARTUP_IGNORE:[ \t]*\\(.*\\)" nil t)
                              (match-string 1)))
               (ignore-tags (when ignore-line
                              (mapcar #'downcase
                                      (split-string ignore-line "[ \t]+" t)))))
          (org-cycle-set-startup-visibility)
          (when ignore-tags
            (goto-char (point-min))
            (cl-loop while (re-search-forward org-outline-regexp nil t)
                     for tags = (mapcar #'downcase (org-get-tags))
                     when (cl-intersection ignore-tags tags :test #'string=)
                     do (progn
                          (org-show-entry)
                          (org-show-subtree))))))))

  (add-hook 'org-mode-hook #'fr/org-fold-respect-startup-ignore-tag)

  ;; QoL
  (defun fr/org-emphasize-dwim (char)
    "Toggle org emphasis CHAR on word or selected region.
If a region is active, emphasize it, else emphasize the word at point."
    (interactive "cEmphasis char: ")
    (if (use-region-p)
        (org-emphasize char)
      (save-excursion
        (let ((bounds (bounds-of-thing-at-point 'symbol)))
          (when bounds
            (goto-char (car bounds))
            (set-mark (cdr bounds))
            (org-emphasize char)
            (deactivate-mark))))))

  ;; QoL
  (defun fr/org-insert-link-dwim (&optional arg)
    "If region is active use it, otherwise mark the symbol at point (if any), then call `org-insert-link'."
    (interactive "P")
    (cond
     ((use-region-p)
      (org-insert-link))
     ((let ((bounds (bounds-of-thing-at-point 'symbol)))
        (when bounds
          (goto-char (car bounds))
          (set-mark (cdr bounds))
          (if arg
              (call-interactively #'org-insert-link)
            (org-insert-link))
          (deactivate-mark)
          t)))
     (t
      (call-interactively #'org-insert-link))))

  (map! :map org-mode-map
        :after org
        :localleader
        "v" #'org-insert-structure-template
        "B" #'org-babel-tangle
        "D" #'org-insert-drawer
        "E" #'org-export-dispatch
        (:prefix ("l" . "links")
                 "l" #'fr/org-insert-link-dwim)
        (:prefix ("e" . "emphasize")
         :desc "Bold" "b" #'(lambda () (interactive) (fr/org-emphasize-dwim ?*))
         :desc "Italic" "i" #'(lambda () (interactive) (fr/org-emphasize-dwim ?\/))
         :desc "Underline" "u" #'(lambda () (interactive) (fr/org-emphasize-dwim ?_))
         :desc "Strike-through" "s" #'(lambda () (interactive) (fr/org-emphasize-dwim ?\+))
         :desc "Verbatim" "v" #'(lambda () (interactive) (fr/org-emphasize-dwim ?=))
         :desc "Code" "c" #'(lambda () (interactive) (fr/org-emphasize-dwim ?~))))

  (map! :map telega-chat-mode-map
        :when (modulep! :app telega)
        :localleader
        (:prefix ("l" . "links")
                 "c" #'org-cliplink
                 "l" #'fr/org-insert-link-dwim)
        (:prefix ("e" . "emphasize")
         :desc "Bold" "b" #'(lambda () (interactive) (fr/org-emphasize-dwim ?*))
         :desc "Italic" "i" #'(lambda () (interactive) (fr/org-emphasize-dwim ?\/))
         :desc "Underline" "u" #'(lambda () (interactive) (fr/org-emphasize-dwim ?_))
         :desc "Strike-through" "s" #'(lambda () (interactive) (fr/org-emphasize-dwim ?\+))
         :desc "Verbatim" "v" #'(lambda () (interactive) (fr/org-emphasize-dwim ?=))
         :desc "Code" "c" #'(lambda () (interactive) (fr/org-emphasize-dwim ?~))))

  (map! :map org-agenda-mode-map
        "<mouse-8>" #'org-agenda-earlier
        "<mouse-9>" #'org-agenda-later
        (:localleader
         "s" #'org-save-all-org-buffers
         "l" #'org-agenda-open-link)))

(when (modulep! :lang org)
  (after! org
    (setq org-archive-tag "archive")
    (setq org-element-archive-tag "archive")
    (add-to-list 'org-default-properties "CREATED")

    (set-popup-rule! "^\\*Org Src"
      :side 'right :size 0.5 :ttl 0 :quit nil :select t :modeline t)

    (with-no-warnings
      (custom-declare-face '+org-todo-next
                           '((t (:inherit (bold font-lock-variable-name-face org-todo)))) ""))

    (setopt org-todo-keywords
            '((sequence
               "NEXT(n)"                  ; Next Action
               "TODO(t)"                  ; Someday/Maybe
               "PROJ(p)"                  ; Project
               "WAIT(w)"                  ; Waiting for
               "LOOP(l)"                  ; Recurring
               "STRT(s)"                  ; Active/In Progress
               "HOLD(h)"                  ; On Hold
               "|"
               "DONE(d)"                  ; Completed
               )
              (sequence
               "[ ](T)"                   ; Action
               "[-](S)"                   ; Active/In Progress
               "[?](W)"                   ; On Hold
               "|"
               "[X](D)")                  ; Completed
              (sequence
               "|"
               "OKAY(O)"
               "YES(Y)"
               "NO(N)"))
            org-todo-keyword-faces
            '(("NEXT" . +org-todo-next)
              ("PROJ" . +org-todo-project)
              ("WAIT" . +org-todo-onhold)
              ("STRT" . +org-todo-active)
              ("HOLD" . +org-todo-onhold)
              ("[-]"  . +org-todo-active)
              ("[?]"  . +org-todo-onhold)
              ("NO"   . +org-todo-cancel)))

    (setopt org-todo-repeat-to-state "LOOP")

    (defvar +org-capture-inbox-file "inbox.org"
      "Default target for all entries.")

    (defvar +org-capture-metrics-file "metrics.org"
      "Default target for metrics entries.")

    (when (modulep! :email mu4e)
      (setq +org-capture-emails-file
            (expand-file-name "next.org"
                              (car (last org-agenda-files)))))

    (setopt org-capture-templates
            `(("t" "Task" entry
               (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Tasks")
               "* TODO [#B] %?\n:PROPERTIES:\n:CREATED: %U\n:END:"
               :prepend t
               :empty-lines 1)
              ("m" "Metrics")
              ("mw" "Weight" table-line
               (file+headline ,(expand-file-name +org-capture-metrics-file org-directory) "Weight")
               "| %U | %^{Weight} kg | %^{Note} |"
               :prepend t
               :kill-buffer t)))

    (setopt org-refile-targets '((org-agenda-files :maxlevel . 6)))

    ;; INFO: Removed hardcoded "TOC"/"ARCHIVE" checks.
    ;; Now uses toc-org-toc-org-regexp and org-archive-tag.
    (defadvice! fr/org-dwim-at-point (&optional arg)
      "Do-what-I-mean at point.

If on a:
- checkbox list item or todo heading: toggle it.
- citation: follow it
- headline: cycle ARCHIVE subtrees, toggle latex fragments and inline images in
  subtree; update statistics cookies/checkboxes and ToCs.
- clock: update its time.
- footnote reference: jump to the footnote's definition
- footnote definition: jump to the first reference of this footnote
- timestamp: open an agenda view for the time-stamp date/range at point.
- table-row or a TBLFM: recalculate the table's formulas
- table-cell: clear it and go into insert mode. If this is a formula cell,
  recaluclate it instead.
- babel-call: execute the source block
- statistics-cookie: update it.
- src block: execute it
- latex fragment: toggle it.
- link: follow it
- otherwise, refresh all inline images in current tree."
      :override #'+org/dwim-at-point
      (interactive "P")
      (if (button-at (point))
          (call-interactively #'push-button)
        (let* ((context (org-element-context))
               (type (org-element-type context)))
          ;; skip over unimportant contexts
          (while (and context (memq type '(verbatim code bold italic underline strike-through subscript superscript)))
            (setq context (org-element-property :parent context)
                  type (org-element-type context)))
          (pcase type
            ((or `citation `citation-reference)
             (org-cite-follow context arg))

            (`headline
             (cond ((memq (bound-and-true-p org-goto-map)
                          (current-active-maps))
                    (org-goto-ret))
                   ((and (fboundp 'toc-org-insert-toc)
                         (save-excursion
                           (goto-char (org-element-property :begin context))
                           (let ((heading (buffer-substring-no-properties
                                           (line-beginning-position) (line-end-position))))
                             (and (boundp 'toc-org-toc-org-regexp)
                                  (string-match-p toc-org-toc-org-regexp heading)))))
                    (toc-org-insert-toc)
                    (message "Updating table of contents"))
                   ((member org-archive-tag (org-get-tags))
                    (org-force-cycle-archived))
                   ((or (org-element-property :todo-type context)
                        (org-element-property :scheduled context))
                    (org-todo
                     (if (eq (org-element-property :todo-type context) 'done)
                         (or (car (+org-get-todo-keywords-for (org-element-property :todo-keyword context)))
                             'todo)
                       'done))))
             ;; Update any metadata or inline previews in this subtree
             (org-update-checkbox-count)
             (org-update-parent-todo-statistics)
             (when (and (fboundp 'toc-org-insert-toc)
                        (save-excursion
                          (goto-char (org-element-property :begin context))
                          (let ((heading (buffer-substring-no-properties
                                          (line-beginning-position) (line-end-position))))
                            (and (boundp 'toc-org-toc-org-regexp)
                                 (string-match-p toc-org-toc-org-regexp heading)))))
               (toc-org-insert-toc)
               (message "Updating table of contents"))
             (let* ((beg (if (org-before-first-heading-p)
                             (line-beginning-position)
                           (save-excursion (org-back-to-heading) (point))))
                    (end (if (org-before-first-heading-p)
                             (line-end-position)
                           (save-excursion (org-end-of-subtree) (point))))
                    (overlays (ignore-errors (overlays-in beg end)))
                    (latex-overlays
                     (cl-find-if (lambda (o) (eq (overlay-get o 'org-overlay-type) 'org-latex-overlay))
                                 overlays))
                    (image-overlays
                     (cl-find-if (lambda (o) (overlay-get o 'org-image-overlay))
                                 overlays)))
               (+org--toggle-inline-images-in-subtree beg end)
               (if (or image-overlays latex-overlays)
                   (org-clear-latex-preview beg end)
                 (org--latex-preview-region beg end))))

            (`clock (org-clock-update-time-maybe))

            (`footnote-reference
             (org-footnote-goto-definition (org-element-property :label context)))

            (`footnote-definition
             (org-footnote-goto-previous-reference (org-element-property :label context)))

            ((or `planning `timestamp)
             (org-follow-timestamp-link))

            ((or `table `table-row)
             (if (org-at-TBLFM-p)
                 (org-table-calc-current-TBLFM)
               (ignore-errors
                 (save-excursion
                   (goto-char (org-element-property :contents-begin context))
                   (org-call-with-arg 'org-table-recalculate (or arg t))))))

            (`table-cell
             (org-table-blank-field)
             (org-table-recalculate arg)
             (when (and (string-empty-p (string-trim (org-table-get-field)))
                        (bound-and-true-p evil-local-mode))
               (evil-change-state 'insert)))

            (`babel-call
             (org-babel-lob-execute-maybe))

            (`statistics-cookie
             (save-excursion (org-update-statistics-cookies arg)))

            ((or `src-block `inline-src-block)
             (org-babel-execute-src-block arg))

            ((or `latex-fragment `latex-environment)
             (org-latex-preview arg))

            (`link
             (let* ((lineage (org-element-lineage context '(link) t))
                    (path (org-element-property :path lineage)))
               (if (or (equal (org-element-property :type lineage) "img")
                       (and path (image-type-from-file-name path)))
                   (+org--toggle-inline-images-in-subtree
                    (org-element-property :begin lineage)
                    (org-element-property :end lineage))
                 (org-open-at-point arg))))

            ((guard (org-element-property :checkbox (org-element-lineage context '(item) t)))
             (org-toggle-checkbox))

            (`paragraph
             (+org--toggle-inline-images-in-subtree))

            (_
             (if (or (org-in-regexp org-ts-regexp-both nil t)
                     (org-in-regexp org-tsr-regexp-both nil  t)
                     (org-in-regexp org-link-any-re nil t))
                 (call-interactively #'org-open-at-point)
               (+org--toggle-inline-images-in-subtree
                (org-element-property :begin context)
                (org-element-property :end context))))))))))

(when (modulep! :lang org)
  (setopt org-agenda-files (list (expand-file-name "agenda" org-directory)))
  (setopt org-agenda-timegrid-use-ampm t)
  (setopt org-agenda-restore-windows-after-quit t)
  (setopt org-tag-alist
          '((:startgrouptag)
            ("🏡 Place")
            (:grouptags)
            ("@home" . ?H)
            ("@gym" . ?G)
            ("@garage" . ?B)
            ("@street" . ?S)
            ("@shop" . ?M)
            ("@hospital" . ?L)
            (:endgrouptag)

            (:startgrouptag)
            ("💻 Device")
            (:grouptags)
            ("@computer" . ?C)
            ("@phone" . ?P)
            (:endgrouptag)

            (:startgroup)
            ("🕐 Difficulty")
            ("@easy" . ?E)
            (:endgroup)

            (:startgroup)
            ("🏷️ Type")
            ("@tech" . ?T)
            ("@art" . ?A)
            ("@sport" . ?s)
            ("@growth" . ?g)
            (:endgroup)

            (:startgroup)
            ("🏃 Activity")
            ("@research" . ?r)
            ("@management" . ?m)
            ("@drawing" . ?d)
            ("@workout" . ?w)
            ("@writing" . ?t)
            ("@programming" . ?p)
            ("@system" . ?a)
            ("@errands" . ?e)
            (:endgroup)))

  (defun fr/org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

  (defun fr/org-skip-subtree-if-habit ()
    "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "STYLE") "habit")
          subtree-end
        nil)))

  (setopt org-agenda-custom-commands
          '(("d" "Daily Agenda"
             ((agenda ""
                      ((org-agenda-span 'day)
                       (org-agenda-start-day "+0d")
                       (org-deadline-warning-days 7)))
              (tags-todo "+@easy"
                         ((org-agenda-overriding-header "Easy Tasks")
                          (org-agenda-skip-function '(or (fr/org-skip-subtree-if-habit)
                                                         (org-agenda-skip-entry-if 'todo '("PROJ" "WAIT" "DONE"))))))
              (tags-todo "+PRIORITY=\"A\""
                         ((org-agenda-overriding-header "High Priority Next Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("TODO" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"B\""
                         ((org-agenda-overriding-header "Medium Priority Next Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("TODO" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"C\""
                         ((org-agenda-overriding-header "Low Priority Next Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("TODO" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"A\""
                         ((org-agenda-overriding-header "High Priority Waiting For Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "TODO" "PROJ" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"B\""
                         ((org-agenda-overriding-header "Medium Priority Waiting For Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "TODO" "PROJ" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"C\""
                         ((org-agenda-overriding-header "Low Priority Waiting For Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "TODO" "PROJ" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"A\""
                         ((org-agenda-overriding-header "High Priority Someday/Maybe Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"B\""
                         ((org-agenda-overriding-header "Medium Priority Someday/Maybe Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo "+PRIORITY=\"C\""
                         ((org-agenda-overriding-header "Low Priority Someday/Maybe Tasks")
                          (org-agenda-skip-function
                           '(or (org-agenda-skip-entry-if 'scheduled 'deadline)
                                (org-agenda-skip-entry-if 'todo '("NEXT" "PROJ" "WAIT" "DONE" "LOOP"))))))
              (tags-todo ".*"
                         ((org-agenda-files (list (expand-file-name "inbox.org" org-directory)))
                          (org-agenda-overriding-header "Unprocessed Inbox Tasks")))
              (tags-todo "-{.*}"
                         ((org-agenda-overriding-header "Untagged Tasks")))))
            ("r" "Weekly Review"
             ((agenda ""
                      ((org-agenda-overriding-header "Completed Tasks")
                       (org-agenda-start-with-log-mode t)
                       (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
                       (org-agenda-span 'week)))
              (agenda ""
                      ((org-agenda-overriding-header "Unfinished Scheduled Tasks")
                       (org-agenda-start-with-log-mode t)
                       (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                       (org-agenda-span 'week)))))))

  (defmacro ignore-args (fnc)
    "Returns function that ignores its arguments and invokes FNC."
    `(lambda (&rest _rest)
       (funcall ,fnc)))

  (advice-add #'org-priority-up :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-priority-down :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-deadline :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-schedule :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-store-log-note :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-todo :after (ignore-args #'org-save-all-org-buffers))
  (advice-add #'org-refile :after 'org-save-all-org-buffers)
  (advice-add #'org-capture-finalize :after (ignore-args #'org-agenda-redo-all))
  (advice-add #'org-agenda-redo :around #'doom-shut-up-a)

  (dolist (hook '(org-after-tags-change-hook
                  org-after-refile-insert-hook
                  org-after-todo-state-change-hook
                  org-capture-after-finalize-hook))
    (add-hook hook #'org-save-all-org-buffers))

  (defun fr/org-agenda-delete-empty-blocks ()
    "Remove empty agenda blocks. A block is identified as empty
if there are fewer than 2 non-empty lines in the block
(excluding the line with `org-agenda-block-separator' characters)."
    (when org-agenda-compact-blocks
      (user-error "Cannot delete empty compact blocks"))
    (setq buffer-read-only nil)
    (save-excursion
      (goto-char (point-min))
      (let* ((blank-line-re "^\\s-*$")
             (content-line-count (if (looking-at-p blank-line-re) 0 1))
             (start-pos (point))
             (block-re (format "%c\\{10,\\}" org-agenda-block-separator)))
        (while (and (not (eobp)) (forward-line))
          (cond
           ((looking-at-p block-re)
            (when (< content-line-count 2)
              (delete-region start-pos (1+ (point-at-bol))))
            (setq start-pos (point))
            (forward-line)
            (setq content-line-count (if (looking-at-p blank-line-re) 0 1)))
           ((not (looking-at-p blank-line-re))
            (setq content-line-count (1+ content-line-count)))))
        (when (< content-line-count 2)
          (delete-region start-pos (point-max)))
        (goto-char (point-min))
        ;; The above strategy can leave a separator line at the beginning
        ;; of the buffer.
        (when (looking-at-p block-re)
          (delete-region (point) (1+ (point-at-eol))))))
    (setq buffer-read-only t))

  (add-hook 'org-agenda-finalize-hook #'fr/org-agenda-delete-empty-blocks))

(when (modulep! :lang org)
  (after! org
    (add-to-list 'org-modules 'org-habit)

    (setopt org-habit-show-habits-only-for-today nil)
    (setq +org-habit-graph-padding 1)
    (setq +org-habit-graph-window-ratio 0.25)))

(when (modulep! :lang org +roam)
  (after! org-roam
    (setopt org-roam-directory (expand-file-name "roam" org-directory))
    (setopt org-roam-dailies-directory "journal")
    (add-to-list 'org-agenda-files (expand-file-name org-roam-dailies-directory org-roam-directory))

    (dolist (prop '("ROAM_ALIASES" "ROAM_REFS" "ROAM_EXCLUDE"))
      (add-to-list 'org-default-properties prop))

    (setopt org-roam-capture-templates
            '(("d" "default" plain
               "%?"
               :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                  "#+title: ${title}\n")
               :unnarrowed t)))

    (setopt org-roam-dailies-capture-templates
            '(("n" "Note" entry
               "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:"
               :target (file+head "%<%Y-%m-%d>.org"
                                  "#+title: %<%Y-%m-%d>\n\n")
               :empty-lines 1)
              ("s" "Scheduled Task" entry
               "* NEXT [#B] %?\nSCHEDULED: %t\n:PROPERTIES:\n:CREATED: %U\n:END:"
               :target (file+head "%<%Y-%m-%d>.org"
                                  "#+title: %<%Y-%m-%d>\n\n")
               :empty-lines 1)
              ("d" "Deadline Task" entry
               "* NEXT [#B] %?\nDEADLINE: %t\n:PROPERTIES:\n:CREATED: %U\n:END:"
               :target (file+head "%<%Y-%m-%d>.org"
                                  "#+title: %<%Y-%m-%d>\n\n")
               :empty-lines 1)))

    ;; INFO: Filter org-tags-alist keywords.
    ;; https://github.com/org-roam/org-roam/issues/2477
    ;; TODO: Adjust when PR will be merged.
    ;; https://github.com/org-roam/org-roam/pull/2564
    (defadvice! fixed-org-roam-tag-completions ()
      "Return list of tags for completions within Org-roam."
      :override #'org-roam-tag-completions
      (let ((roam-tags (mapcar #'car (org-roam-db-query [:select :distinct [tag] :from tags])))
            (org-tags (seq-filter #'stringp (mapcar #'car org-tag-alist))))
        (seq-uniq (append roam-tags org-tags))))

    ;; INFO: Can go to dailies directly
    ;; https://github.com/org-roam/org-roam/issues/2134
    ;; https://github.com/org-roam/org-roam/pull/2141#issuecomment-3021291947 - Thanks!
    (defadvice! fr/org-roam-dailies--capture-goto-quick (fn time &optional goto keys)
      "Skip prompt for capture template with dailies goto functions."
      :around #'org-roam-dailies--capture
      (apply fn time goto
             (if goto
                 (list (car (car org-roam-dailies-capture-templates)))
               (list keys))))

    ;; INFO: QoL dwim for words
    ;; https://github.com/org-roam/org-roam/pull/2588
    (cl-defun fr/org-roam-node-insert (&optional filter-fn &key templates info)
      "Find an Org-roam node and insert (where the point is) an \"id:\" link to it.
If a region is active the link is put around the region text.
If a word is at point the link is put around that word.
Otherwise the link is inserted with the node's formatted title as description.
FILTER-FN is a function to filter out nodes: it takes an `org-roam-node',
and when nil is returned the node will be filtered out.
The TEMPLATES, if provided, override the list of capture templates (see
`org-roam-capture-'.)
The INFO, if provided, is passed to the underlying `org-roam-capture-'."
      (interactive)
      (unwind-protect
          ;; Group functions together to avoid inconsistent state on quit
          (atomic-change-group
            (let* (beg
                   end
                   (region-text
                    (cond
                     ((region-active-p)
                      (setq beg (set-marker (make-marker) (region-beginning)))
                      (setq end (set-marker (make-marker) (region-end)))
                      (org-link-display-format (buffer-substring-no-properties beg end)))
                     ((thing-at-point 'symbol)
                      (let ((bounds (bounds-of-thing-at-point 'symbol)))
                        (setq beg (set-marker (make-marker) (car bounds)))
                        (setq end (set-marker (make-marker) (cdr bounds)))
                        (org-link-display-format (buffer-substring-no-properties beg end))))))
                   (node (org-roam-node-read region-text filter-fn))
                   (description (or region-text
                                    (org-roam-node-formatted node))))
              (if (org-roam-node-id node)
                  (progn
                    (when region-text
                      (delete-region beg end)
                      (set-marker beg nil)
                      (set-marker end nil))
                    (let ((id (org-roam-node-id node)))
                      (insert (org-link-make-string
                               (concat "id:" id)
                               description))
                      (run-hook-with-args 'org-roam-post-node-insert-hook
                                          id
                                          description)))
                (org-roam-capture-
                 :node node
                 :info info
                 :templates templates
                 :props (append
                         (when (and beg end)
                           (list :region (cons beg end)))
                         (list :link-description description
                               :finalize 'insert-link))))))
        (deactivate-mark)))

    (advice-add #'org-roam-node-insert :override #'fr/org-roam-node-insert)

    (advice-add #'org-roam-tag-remove :after (ignore-args #'org-save-all-org-buffers))
    (advice-add #'org-roam-tag-add :after (ignore-args #'org-save-all-org-buffers))))

(use-package! org-mem
  :when (modulep! :lang org +mem)
  :after org
  :config
  (setopt org-roam-db-update-on-save nil)
  (setopt org-mem-roamy-do-overwrite-real-db t)
  (org-mem-roamy-db-mode t)

  ;; Disable Doom's additional syncs from `+org-init-roam-h'
  (after! org-roam
    (setopt org-mem-watch-dirs (list org-roam-directory))
    (org-roam-db-autosync-disable)

    (undefadvice! +org-roam-try-init-db-a (&rest _)
      :before #'org-roam-db-query)))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setopt org-roam-ui-sync-theme t)
  (setopt org-roam-ui-follow t)
  (setopt org-roam-ui-update-on-save t)
  (setopt org-roam-ui-open-on-start t))

(use-package! org-super-agenda
  :when (modulep! :lang org +super)
  :hook (org-agenda-mode . org-super-agenda-mode))

(use-package! org-contacts
  :when (modulep! :lang org +contacts)
  :after org
  :custom
  (org-contacts-files (list (file-name-concat org-directory "contacts.org")))
  :config
  (setopt org-capture-templates
          (append org-capture-templates
                  `(("c" "Contacts" entry
                     (file ,(car org-contacts-files))
                     "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:PHONE: %^{Phone}
:NICKNAME: %^{Nickname}
:BIO: %^{Bio}
:ADDRESS: %^{Address}
:BIRTHDAY: %^{Birthday}u
:END:"))))

  (when (modulep! :email mu4e)
    (after! mu4e
      (setq mu4e-org-contacts-file (car org-contacts-files))
      (add-to-list 'mu4e-headers-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t)
      (add-to-list 'mu4e-view-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t)))

  ;; Reduce count results for vertico
  (advice-add 'org-contacts :around
              (lambda (orig &rest args)
                (let ((vertico-count 5))
                  (apply orig args))))

  ;; Reset cache
  (advice-add 'org-contacts :before #'org-contacts--candidates-cache-reset)

  ;; Unnecessary variable
  (makunbound 'org-contacts-ahead-space-padding)

  ;; INFO: Corrected the work and improved it
  (defadvice! fr/org-contacts--candidate (headline)
    "Return candidate string from Org HEADLINE epom element node."
    :override #'org-contacts--candidate
    (let* ((org-contacts-icon-size 32)
           (contact-name (org-element-property :raw-value headline))
           (tags (let ((pos (org-element-property :begin headline)))
                   (org-with-point-at pos
                     (split-string (or (org-entry-get nil "ALLTAGS") "") ":" t))))
           (properties (org-entry-properties headline 'standard))
           ;; avatar
           (avatar-image-path
            (when-let* ((avatar-value (org-entry-get headline "AVATAR"))
                        (avatar-link-path (cond
                                           ((or (string-match org-link-bracket-re avatar-value)
                                                (string-match org-link-any-re avatar-value))
                                            (when-let* ((link-internal (or (match-string 1 avatar-value) (match-string 2 avatar-value)))
                                                        (_ (and (or (string-prefix-p "file:" link-internal)
                                                                    (string-prefix-p "attachment:" link-internal))
                                                                (seq-some
                                                                 (lambda (ext) (string-suffix-p ext link-internal))
                                                                 image-file-name-extensions))))
                                              (when (string-match "\\([file\\|attachment]\\):\\(.*\\)" link-internal)
                                                (match-string 2 link-internal))))
                                           ((string-match org-link-plain-re avatar-value)
                                            (match-string 2 avatar-value))
                                           ((string-match (concat (regexp-opt image-file-name-extensions) (rx line-end)) avatar-value)
                                            (match-string 0 avatar-value))))
                        (avatar-absolute-path (file-name-concat
                                               (or org-contacts-directory
                                                   (expand-file-name (file-name-directory (car org-contacts-files))))
                                               avatar-link-path))
                        (_ (org-file-image-p avatar-absolute-path))
                        (_ (file-exists-p avatar-absolute-path)))
              avatar-absolute-path))
           ;; Helper lambda for standard fields
           (field (lambda (prop label face)
                    (let ((val (org-entry-get headline prop)))
                      (when (and val (not (string-empty-p val)))
                        (concat (propertize (concat label ": ") 'face '(:foreground "SlateGray4" :height 90))
                                (propertize val 'face face))))))
           (nickname (funcall field org-contacts-nickname-property "nick"
                              '(:slant italic :foreground "DarkOliveGreen1")))
           (email (funcall field org-contacts-email-property "email"
                           '(:foreground "MediumPurple3")))
           (phone (funcall field "PHONE" "phone" '(:foreground "LightBlue")))
           (address (funcall field "ADDRESS" "address" '(:foreground "LightGreen")))
           (birthday (funcall field "BIRTHDAY" "birthday" '(:foreground "LightGoldenrod")))
           ;; Bio needs string-fill
           (bio (let ((val (org-entry-get headline "Bio")))
                  (when (and val (not (string-empty-p val)))
                    (concat (propertize "bio: " 'face '(:foreground "SlateGray4" :height 90))
                            (propertize (string-fill val
                                                     (or fill-column (abs org-tags-column) (- (window-width) 15)))
                                        'face '(:height 95))))))
           (info-parts (delq nil (list email phone address birthday bio)))
           (info (if info-parts (concat "\n" (mapconcat #'identity info-parts "\n")) "")))
      ;; Check if headline is a contact
      (when (seq-intersection org-contacts-identity-properties-list (mapcar 'car properties))
        (propertize
         (concat
          (if avatar-image-path
              (propertize " " 'display (create-image avatar-image-path nil nil
                                                     :ascent 30
                                                     :width org-contacts-icon-size))
            "")
          (propertize contact-name 'face '(:inherit org-level-1))
          (or (when nickname (concat " (" nickname ")")) "")
          (or (when tags (concat " " (propertize (concat "[" (string-join tags ":") "]")
                                                 'face '(:inherit org-tag)))) ""))
         'contact-name contact-name
         'annotation info)))))

(use-package! org-expose-emphasis-markers
  :hook (org-mode . org-expose-emphasis-markers-mode))

(use-package! corg
  :hook (org-mode . corg-setup))

(custom-theme-set-faces! 'doom-gruvbox
  '(markdown-header-face-1 :inherit outline-1)
  '(markdown-header-face-2 :inherit outline-2)
  '(markdown-header-face-3 :inherit outline-3)
  '(markdown-header-face-4 :inherit outline-4)
  '(markdown-header-face-5 :inherit outline-5)
  '(markdown-header-face-6 :inherit outline-6))

(when (modulep! :lang qt)
  (defun +qt-common-config (mode)
    (when (modulep! :lang qt +lsp)
      (if (and (not (executable-find "qmlls"))
               (executable-find "qmlls6"))
          (set-eglot-client! mode '("qmlls6"))
        (set-eglot-client! mode '("qmlls")))
      (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append))))

(when (modulep! :lang sh +fish)
  (defun +fish-common-config (mode)
    (when (modulep! :lang sh +fish +lsp)
      (set-eglot-client! mode '("fish-lsp" "start"))
      (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

  (use-package! fish-mode
    :config
    (+fish-common-config 'fish-mode)))

(setopt browse-url-text-browser (executable-find "cha"))

(use-package! eww
  :config
  (setopt eww-readable-urls '("lwn\\.net")))

(setopt shr-color-visible-luminance-min 50)

(defcustom eww-urls '("www.opennet.ru" "lwn.net" "www.phoronix.com")
  "List of domains to open using EWW browser."
  :type '(repeat string)
  :group 'eww)

(defun fr/browse-url-function (url &rest args)
  "Open URL with EWW if the host matches a domain in `eww-urls',
otherwise open it with the default browser."
  (let ((host (url-host (url-generic-parse-url url))))
    (if (member host eww-urls)
        (eww-browse-url url)
      (apply #'browse-url-default-browser url args))))

(setopt browse-url-browser-function #'fr/browse-url-function)

(when (executable-find "rdrview")
  (after! eww
    (defcustom eww-rdrview-urls (regexp-opt '("www.opennet.ru" "www.phoronix.com"))
      "List of URLs to automatically enable `eww-rdrview-mode'."
      :type 'regexp
      :group 'eww)

    (define-minor-mode eww-rdrview-mode
      "Toggle whether to use `rdrview' to make EWW buffers more readable."
      :lighter " rdrview"
      (if eww-rdrview-mode
          (progn
            (setq eww-retrieve-command (list (executable-find "rdrview") "-T" "title,sitename,body" "-H"))
            (add-hook 'eww-after-render-hook #'eww-rdrview-update-title))
        (progn
          (setq eww-retrieve-command nil)
          (remove-hook 'eww-after-render-hook #'eww-rdrview-update-title))))

    (defun eww-rdrview-update-title ()
      "Change title key in `eww-data' with first line of buffer.
It should be the title of the web page as returned by `rdrview'."
      (save-excursion
        (goto-char (point-min))
        (plist-put eww-data :title (string-trim (thing-at-point 'line t))))
      (eww--after-page-change))

    (defun eww-rdrview-toggle-and-reload ()
      "Toggle `eww-rdrview-mode' and reload page in current EWW buffer."
      (interactive)
      (if eww-rdrview-mode (eww-rdrview-mode -1)
        (eww-rdrview-mode 1))
      (eww-reload))

    (defun eww-auto-rdrview ()
      "Enable `eww-rdrview-mode' only once for matching URLs."
      (let ((url (or (eww-current-url) "")))
        (when (and (string-match-p eww-rdrview-urls url)
                   (not eww-rdrview-mode))
          (eww-rdrview-toggle-and-reload))))

    (add-hook 'eww-after-render-hook #'eww-auto-rdrview)

    (defun fr/eww-readable (rdrview)
      "Toggle display of only the main \"readable\" parts of the current web page."
      (interactive "P" eww-mode)
      (if rdrview
          (eww-rdrview-toggle-and-reload)
        (eww-readable)))

    (map! :map eww-mode-map
          :n "R" #'fr/eww-readable)))

(when (modulep! :app rss)
  ;;;###autoload
  (defun fr/elfeed-open-and-update ()
    "Wrapper to load the `elfeed' db from disk before opening, force update search and feeds."
    (interactive)
    (elfeed)
    (elfeed-search-update--force)
    (elfeed-update))

  (after! elfeed
    (setopt elfeed-search-filter "@2-week-ago +unread -reddit")

    (map! :map elfeed-show-mode-map
          :n [escape] #'elfeed-kill-buffer
          :n [return] #'elfeed-show-visit)

    (map! :map elfeed-search-mode-map
          :n "R" #'elfeed-update
          :n [tab] #'elfeed-search-show-entry
          (:localleader
           :desc "Update feeds" "u" #'elfeed-update))))

(when (modulep! :app rss)
  (after! elfeed-goodies
    (setopt elfeed-goodies/feed-source-column-width 36)
    (setopt elfeed-goodies/tag-column-width 28)
    (setopt elfeed-goodies/entry-pane-size 0.72)))

(when (modulep! :app rss +org)
  (after! elfeed-org
    ;; INFO: https://github.com/remyhonig/elfeed-org/issues/99
    (defadvice! fixed-rmh-elfeed-org-import-trees (tree-id)
      "Get trees with `:ID:' property or tag of value TREE-ID.
Return trees with TREE-ID as the value of the id property or
with a tag of the same value. Setting an `:ID:' property is not
recommended but I support it for backward compatibility of
current users."
      :override #'rmh-elfeed-org-import-trees
      (org-element-map
          (org-element-parse-buffer)
          'headline
        (lambda (h)
          (when (or (member tree-id (org-get-tags h))
                    (equal tree-id (org-element-property :ID h))) h))))))

(when (modulep! :email mu4e)
  (after! mu4e
    (setopt mu4e-attachment-dir "~/Downloads/mu4e")
    (setopt mu4e-update-interval 300)
    (setopt mu4e-notification-support nil)
    (setopt sendmail-program (executable-find "msmtp"))
    (setopt message-send-mail-function #'message-send-mail-with-sendmail)
    (setopt message-sendmail-f-is-evil t)
    (setopt send-mail-function #'sendmail-send-it)
    (setopt doom-modeline-mu4e t)

    (setopt mu4e-bookmarks
            '((:name "Unread messages"
               :query "maildir:/gmail/inbox AND (flag:new OR flag:unread)"
               :favorite t
               :hide-if-no-unread t
               :key ?u)
              (:name "Today's messages"
               :query "date:today..now"
               :key ?t)
              (:name "Last 7 days"
               :query "date:7d..now"
               :hide-unread t
               :key ?w)
              (:name "Messages with images"
               :query "mime:image/*"
               :key ?p)))

    (defadvice! fr/mu4e-initialise-icons ()
      :override #'+mu4e-initialise-icons
      (setopt mu4e-use-fancy-chars t)
      (setq mu4e-modeline-all-clear     (cons "C:" (+mu4e-normalised-icon "nf-md-email_off" :set "mdicon" :height 1.0 :space-right t))   ; 󱏣
            mu4e-modeline-all-read      (cons "R:" (+mu4e-normalised-icon "nf-md-email_check" :set "mdicon" :height 1.0 :space-right t)) ; 󰪱
            mu4e-modeline-new-items     (cons "N:" (+mu4e-normalised-icon "nf-md-email_sync" :set "mdicon" :height 1.0 :space-right t))  ; 󱋇
            mu4e-modeline-unread-items  (cons "U:" (+mu4e-normalised-icon "nf-md-email_alert" :set "mdicon" :height 1.0 :space-right t)) ; 󰛏
            mu4e-headers-attach-mark    (cons "a"  (+mu4e-normalised-icon "nf-md-attachment" :set "mdicon" :color "silver"))             ; 󰁦
            mu4e-headers-calendar-mark  (cons "c"  (+mu4e-normalised-icon "nf-cod-calendar" :set "codicon"))                             ; 
            mu4e-headers-draft-mark     (cons "d"  (+mu4e-normalised-icon "nf-fa-pencil"))                                               ; 
            mu4e-headers-encrypted-mark (cons "e"  (+mu4e-normalised-icon "nf-cod-lock" :set "codicon"))                                 ; 
            mu4e-headers-flagged-mark   (cons "F"  (+mu4e-normalised-icon "nf-md-flag_outline" :set "mdicon"))                           ; 󰈽
            mu4e-headers-list-mark      (cons "l"  (+mu4e-normalised-icon "nf-fa-list"))                                                 ; 
            mu4e-headers-new-mark       (cons "n"  (+mu4e-normalised-icon "nf-md-new_box" :set "mdicon"))                                ; 󰎔
            mu4e-headers-passed-mark    (cons "P"  (+mu4e-normalised-icon "nf-oct-arrow_right" :set "octicon"))                          ; 
            mu4e-headers-personal-mark  (cons "p"  (+mu4e-normalised-icon "nf-fa-user_o"))                                               ; 
            mu4e-headers-replied-mark   (cons "r"  (+mu4e-normalised-icon "nf-fa-reply"))                                                ; 
            mu4e-headers-seen-mark      (cons "s"  "")
            mu4e-headers-signed-mark    (cons "S"  (+mu4e-normalised-icon "nf-md-shield_outline" :set "mdicon"))                         ; 󰒙
            mu4e-headers-trashed-mark   (cons "t"  (+mu4e-normalised-icon "nf-fa-trash_o"))                                              ; 
            mu4e-headers-unread-mark    (cons "u"  (+mu4e-normalised-icon "nf-fa-eye_slash" :v-adjust 0.05))))                           ; 

    (if (display-graphic-p)
        (fr/mu4e-initialise-icons)
      ;; When it's the server, wait till the first graphical frame
      (add-hook! 'server-after-make-frame-hook
        (defun fr/mu4e-initialise-icons-hook ()
          (when (display-graphic-p)
            (fr/mu4e-initialise-icons)
            (remove-hook 'server-after-make-frame-hook
                         #'fr/mu4e-initialise-icons-hook)))))

    (when (modulep! :email mu4e +gmail)
      ;; don't need to run cleanup after indexing for gmail
      (setopt mu4e-index-cleanup nil)
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      (setopt mu4e-index-lazy-check t))

    (when (modulep! :email mu4e +org)
      (setq +mu4e-compose-org-msg-toggle-next nil))

    ;; Adding emails to the agenda.
    ;; Perfect for when you see an email you want to reply to
    ;; later, but don't want to forget about.
    (defadvice! fr/mu4e-capture-msg-to-agenda (arg)
      "Refile a message and add a entry in `+org-capture-emails-file' with a
deadline.  Default deadline is today.  With one prefix, deadline
is tomorrow.  With two prefixes, select the deadline."
      :override #'+mu4e/capture-msg-to-agenda
      (interactive "p")
      (let ((sec "^* Email")
            (msg (mu4e-message-at-point)))
        (when msg
          ;; put the message in the agenda
          (with-current-buffer (find-file-noselect
                                (expand-file-name +org-capture-emails-file org-directory))
            (save-excursion
              ;; find header section
              (goto-char (point-min))
              (when (re-search-forward sec nil t)
                (let (org-M-RET-may-split-line
                      (lev (org-outline-level))
                      (folded-p (invisible-p (line-end-position)))
                      (from (plist-get msg :from)))
                  (when (consp (car from)) ; Occurs when using mu4e 1.8+.
                    (setq from (car from)))
                  (unless (keywordp (car from)) ; If using mu4e <= 1.6.
                    (setq from (list :name (or (caar from) (cdar from)))))
                  ;; place the subheader
                  (when folded-p (show-branches))   ; unfold if necessary
                  (org-end-of-meta-data)            ; skip property drawer
                  (org-insert-todo-heading 1)       ; insert a todo heading
                  (when (= (org-outline-level) lev) ; demote if necessary
                    (org-do-demote))
                  ;; insert message, context tag, created time and deadline
                  (insert (concat "[#B] Respond to "
                                  "[[mu4e:msgid:"
                                  (plist-get msg :message-id) "]["
                                  (truncate-string-to-width
                                   (plist-get from :name) 25 nil nil t)
                                  " - "
                                  (truncate-string-to-width
                                   (plist-get msg :subject) 80 nil nil t)
                                  "]]. "))
                  (org-set-tags-to "@email")
                  (org-deadline nil
                                (cond ((= arg 1) (format-time-string "%Y-%m-%d"))
                                      ((= arg 4) "+1d")))
                  (org-set-property "CREATED" (format-time-string "[%Y-%m-%d %a %H:%M]"))
                  (org-update-parent-todo-statistics)

                  ;; blank-line
                  ;; (goto-char (org-entry-end-position))
                  ;; (newline)

                  ;; refold as necessary
                  ;; (if folded-p
                  ;;     (progn
                  ;;       (org-up-heading-safe)
                  ;;       (hide-subtree))
                  ;;   (hide-entry))
                  ))))
          ;; refile the message and update
          ;; (cond ((eq major-mode 'mu4e-view-mode)
          ;;        (mu4e-view-mark-for-refile))
          ;;       ((eq major-mode 'mu4e-headers-mode)
          ;;        (mu4e-headers-mark-for-refile)))
          (message "Refiled \"%s\" and added to the agenda for %s"
                   (truncate-string-to-width
                    (plist-get msg :subject) 40 nil nil t)
                   (cond ((= arg 1) "today")
                         ((= arg 4) "tomorrow")
                         (t         "later"))))))

    (map! :map mu4e-main-mode-map
          :n "q" (λ! (mu4e-quit t))
          :n "Q" #'mu4e-quit))

  (set-email-account! "fresteinart@gmail.com"
                      '((mu4e-sent-folder       . "/gmail/sent")
                        (mu4e-drafts-folder     . "/gmail/drafts")
                        (mu4e-trash-folder      . "/gmail/trash")
                        (mu4e-refile-folder     . "/gmail/all")
                        (mu4e-maildir-shortcuts . (("/gmail/inbox" . ?i)
                                                   ("/gmail/important" . ?I)
                                                   ("/gmail/starred" . ?s)
                                                   ("/gmail/sent" . ?S)
                                                   ("/gmail/drafts" . ?d)
                                                   ("/gmail/all" . ?a)
                                                   ("/gmail/spam" . ?t)
                                                   ("/gmail/trash" . ?T)))
                        (smtpmail-smtp-user     . "fresteinart@gmail.com")
                        (user-mail-address      . "fresteinart@gmail.com")
                        (mu4e-compose-signature . "Frestein"))
                      t)

  (defun mu4e-process-running-p ()
    "Check if mu process is running."
    (not (string-equal (shell-command-to-string "pgrep -x mu") "")))

  (unless (mu4e-process-running-p)
    (if (daemonp)
        (add-hook! doom-first-input
          (let ((current (current-buffer)))
            (mu4e 'no-popup)
            (switch-to-buffer current)))
      (add-hook! doom-init-ui (mu4e 'no-popup)))))

(when (modulep! :app telega)
  ;; Fuck you, Russian Pederation's government!
  (after! telega
    (let ((config-file (expand-file-name "TgWsProxy/config.json" (xdg-config-home))))
      (when (file-exists-p config-file)
        (with-temp-buffer
          (insert-file-contents config-file)
          (let* ((json-object-type 'alist)
                 (json-array-type 'list)
                 (json-key-type 'string)
                 (data (json-read))
                 (secret (cdr (assoc "secret" data)))
                 (host (cdr (assoc "host" data)))
                 (port (cdr (assoc "port" data))))
            (when (and secret host port)
              (add-hook 'telega-before-auth-hook
                        (lambda ()
                          (telega--addProxy `(:server ,host
                                              :port ,port
                                              :type (:@type "proxyTypeMtproto"
                                                     :secret ,secret))
                              'enable)))))))))

  ;; Autostart
  (defun telega-server-process-running-p ()
    "Check if telega-server process is running."
    (not (string-equal (shell-command-to-string "pgrep -x telega-server") "")))

  (unless (telega-server-process-running-p)
    (if (daemonp)
        (add-hook! doom-first-input (telega 'no-popup))
      (add-hook! doom-after-init (telega 'no-popup)))))

(when (modulep! :tools biome)
  (after! biome
    (setopt biome-query-coords
            '(("Saint-Petersburg, Russia" 59.938732 30.316229)
              ("Mednogorsk, Russia" 51.404944 57.580314)))))

(when (modulep! :tools fj)
  (after! fj
    (setq fj-user "Frestein")

    (when (modulep! :tools pass +auth)
      (setopt fj-token-use-auth-source nil)

      (defun fr/fj-set-token ()
        (setq fj-token (auth-source-pass-get 'secret "work/git/codeberg.org/api/frestein@tuta.io/fj.el")))

      (if (daemonp)
          (add-hook! doom-first-input (fr/fj-set-token))
        (add-hook! doom-init-ui (fr/fj-set-token))))))

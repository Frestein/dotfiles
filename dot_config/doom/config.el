;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User
(setq user-full-name "Frestein"
      user-mail-address "frestein@tuta.io")

;; Theme
(setq doom-theme 'doom-gruvbox)

;; Global Auto Revert
;; A buffer can get out of sync with respect to its visited file on disk if that
;; file is changed by another program. To keep it up to date, you can enable
;; Auto Revert mode by typing M-x auto-revert-mode, or you can set it to be
;; turned on globally with ‘global-auto-revert-mode’. I have also turned on
;; Global Auto Revert on non-file buffers, which is especially useful for
;; ‘dired’ buffers.
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)

;; Line settings
(setq display-line-numbers-type 'relative)

;; Fonts
(setq doom-font (font-spec :family "Maple Mono NF" :size 14)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
      doom-big-font (font-spec :family "Maple Mono NF" :size 24)
      doom-symbol-font (font-spec :family "JoyPixels" :size 14)
      doom-serif-font (font-spec :family "Noto Serif" :size 14))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Shell
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shel (executable-find "fish")
              explicit-shell-file-name (executable-find "fish"))

;; Smooth scroll
;; Disable ultra-scroll
(remove-hook 'doom-first-input-hook #'ultra-scroll-mode)
(remove-hook 'doom-first-file-hook #'ultra-scroll-mode)

;; Mappings
(map! :map evil-normal-state-map
      "C-h" #'evil-window-left
      "C-j" #'evil-window-down
      "C-k" #'evil-window-up
      "C-l" #'evil-window-right
      "H" #'previous-buffer
      "L" #'next-buffer)

(map!
 (:when (modulep! :term vterm )
   :desc "Toggle vterm popup" :n "C-/" #'+vterm/toggle))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Automatic line breaking" :n "a" #'auto-fill-mode)
      (:prefix ("s" . "search")
               (:when (modulep! :tools pass)
                 :n "p" nil ;; Disable defaults
                 :n "P" nil ;; Disable defaults
                 (:prefix ("p" . "project")
                  :desc "Search project" :n "p" #'+default/search-project
                  :desc "Search other project" :n "o" #'+default/search-other-project)
                 (:prefix ("P" . "Pass")
                  :desc "Username" :n "u" #'+pass/copy-user
                  :desc "Password" :n "p" #'+pass/consult)))
      (:prefix ("A" . "app")
               (:when (modulep! :tools pass)
                 :desc "Pass" :n "p" #'pass)
               (:when (modulep! :app rss)
                 :desc "Elfeed (Summary)" :n "E" #'elfeed-summary
                 :desc "Elfeed" :n "e" #'elfeed))
      (:prefix ("f" . "file")
               (:when (modulep! :emacs dired)
                 :desc "Open directory in dirvish" :n "m" #'dirvish)))

;; Dired
(setq delete-by-moving-to-trash t)
(setq dired-mouse-drag-files t)
(setq mouse-drag-and-drop-region-cross-program t)

(map! :map dired-mode-map
      :v "u" #'dired-unmark)

;; Dirvish
(when (modulep! :emacs dired +dirvish)
  (use-package! dirvish
    :config
    (dirvish-peek-mode t)

    (setq dirvish-quick-access-entries
          '(("h" "~/"                                 "Home")
            ("d" "~/Downloads/"                       "Downloads")
            ("D" "~/Documents/"                       "Documents")
            ("v" "~/Videos/"                          "Videos")
            ("m" "~/Music/"                           "Music")
            ("c" "~/.config/"                         "Config")
            ("C" "~/.local/share/chezmoi/dot_config/" "Dotfiles")
            ("p" "~/Pictures/"                        "Pictures")
            ("P" "~/Projects/"                        "Projects")
            ("M" "/mnt/"                              "Drives")
            ("t" "~/.local/share/Trash/files/"        "TrashCan")))

    (setq dirvish-attributes
          '(collapse git-msg file-modes file-time))

    (setq dirvish-side-attributes
          '(collapse))

    (when (modulep! :emacs dired +icons)
      (setq dirvish-subtree-always-show-state t)
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

    (setq mouse-1-click-follows-link nil)

    (map! :map dirvish-mode-map
          "<mouse-1>" #'dirvish-subtree-toggle-or-open
          "<mouse-2>" #'dired-mouse-find-file-other-window
          "<mouse-3>" #'dired-mouse-find-file
          :n "gd" #'dirvish-quick-access)))

;; Git
;; Magit
(when (modulep! :tools magit)
  (setq magit-repository-directories
        '(("~/Projects/" . 2)
          ("~/.local/share/chezmoi" . 1))))

;; Org
(setq org-directory "~/Documents/org/"
      org-hide-emphasis-markers t)

(when (modulep! :lang org)
  (use-package! corg
    :config (add-hook 'org-mode-hook #'corg-setup)))

;; WWW
(setq browse-url-text-browser (executable-find "cha")
      browse-url-generic-program (executable-find "qutebrowser"))

(defvar eww-urls
  '("www.opennet.ru" "lwn.net")
  "List of domains to open using eww browser.")

(defun frestein-browse-url-function (url &rest args)
  "Open URL with eww if the host matches a domain in `eww-urls`,
otherwise open it with the default browser."
  (let ((host (url-host (url-generic-parse-url url))))
    (if (member host eww-urls)
        (eww-browse-url url)
      (apply #'browse-url-default-browser url args))))

(setq browse-url-browser-function #'frestein-browse-url-function)

;; Eww
;; Dependencies:
;; - rdrview (https://github.com/eafer/rdrview)
(setq shr-color-visible-luminance-min 50)

(use-package! eww
  :hook (eww-after-render . eww-auto-rdrview)
  :config
  (setq eww-readable-urls '("lwn\\.net"))

  (define-minor-mode eww-rdrview-mode
    "Toggle whether to use `rdrview' to make eww buffers more readable."
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
    "Toggle `eww-rdrview-mode' and reload page in current eww buffer."
    (interactive)
    (if eww-rdrview-mode (eww-rdrview-mode -1)
      (eww-rdrview-mode 1))
    (eww-reload))

  (defvar eww-rdrview-urls
    (regexp-opt '("www.opennet.ru"))
    "List of URLs to automatically enable eww-rdrview-mode.")

  (defun eww-auto-rdrview ()
    "Enable eww-rdrview-mode only once for matching URLs."
    (let ((url (or (eww-current-url) "")))
      (when (and (string-match-p eww-rdrview-urls url)
                 (not eww-rdrview-mode))
        (eww-rdrview-toggle-and-reload))))

  (defun frestein-eww-readable (rdrview)
    (interactive "P" eww-mode)
    (if rdrview
        (eww-rdrview-toggle-and-reload)
      (eww-readable)))

  (map! :map eww-mode-map
        :n "R" #'frestein-eww-readable))

;; Elfeed
(when (modulep! :app rss)
  (after! elfeed
    (setq elfeed-search-filter "@2-week-ago +unread -youtube -reddit -x")

    (map! :map elfeed-search-mode-map
          :localleader
          :desc "Update feeds" "u" #'elfeed-update))

  (use-package! elfeed-summary
    :config
    (setq elfeed-summary-other-window t
          elfeed-summary-settings
          '((group
             (:title . "News")
             (:elements (group (:title . "Tech") (:elements (query . (and news tech))))))
            (group
             (:title . "Reddit")
             (:elements (group (:title . "Tech") (:elements (query . (and reddit tech))))))
            (group
             (:title . "YouTube")
             (:elements
              (group (:title . "Fun") (:elements (query . (and youtube fun))))
              (group (:title . "Games") (:elements (query . (and youtube games))))
              (group (:title . "Sport") (:elements (query . (and youtube sport))))
              (group (:title . "Vtubers") (:elements (query . (and youtube vtuber))))
              (group (:title . "Art") (:elements (query . (and youtube art))))
              (group (:title . "Tech") (:elements (query . (and youtube tech))))
              (group (:title . "Music") (:elements (query . (and youtube music))))))))))

;; Zen
(when (modulep! :ui zen)
  (setq +zen-text-scale 0
        writeroom-width 100))

;; Cursor
(defvar last-cursor-position nil
  "Last position where cursor color was updated.")

(defun set-cursor-color-to-foreground-optimized ()
  "Set cursor color to match foreground, but only when position changes."
  (condition-case err
      (unless (equal (point) last-cursor-position)
        (setq last-cursor-position (point))
        (let* ((face (get-text-property (point) 'face))
               (fg-color (cond
                          ;; If face is a list, get the first valid one with a foreground
                          ((listp face)
                           (cl-loop for f in face
                                    for color = (and (symbolp f) ; Only process symbol faces
                                                     (condition-case nil
                                                         (face-foreground f nil t)
                                                       (error nil)))
                                    when (and color (not (eq color 'unspecified)))
                                    return color))
                          ;; If face is a single symbol face
                          ((symbolp face)
                           (condition-case nil
                               (face-foreground face nil t)
                             (error nil)))
                          ;; No face property or invalid face - use nil
                          (t nil))))
          ;; If no specific face color found, use default foreground
          (unless (and fg-color (not (eq fg-color 'unspecified)))
            (setq fg-color (face-foreground 'default nil t)))
          ;; Set cursor color (should always have a color now)
          (when (and fg-color (not (eq fg-color 'unspecified)))
            (set-cursor-color fg-color))))
    (error
     ;; Silently handle errors to avoid disrupting post-command-hook
     nil)))

(add-hook 'post-command-hook 'set-cursor-color-to-foreground-optimized)

;; Printer
(after! lpr
  (setq lpr-lp-system t
        lpr-command "lp"
        lpr-add-switches nil
        lpr-printer-switch "-d"
        printer-name "Samsung_SCX-3200_Series"))

(after! ps-print
  (setq ps-printer-name "Samsung_SCX-3200_Series"))

(when (modulep! :tools pdf)
  (use-package! pdf-misc
    :after pdf-view
    :bind (:map pdf-view-mode-map
                ([remap pdf-misc-print-document] . 'frestein/pdf-misc-print-pages))
    :config
    (setq pdf-misc-print-program-executable (executable-find "lp"))

    (defun frestein/pdf-misc-print-pages(filename pages &optional interactive-p)
      "Wrapper for `pdf-misc-print-document` to add page selection support"
      (interactive (list (pdf-view-buffer-file-name)
                         (read-string "Page range (empty for all pages): "
                                      (number-to-string (pdf-view-current-page)))
                         t) pdf-view-mode)
      (let ((pdf-misc-print-program-args
             (if (not (string-blank-p pages))
                 (cons (concat "-P " pages) pdf-misc-print-program-args)
               pdf-misc-print-program-args)))
        (pdf-misc-print-document filename)))))

;; Pass
(when (modulep! :tools pass)
  (use-package! password-store
    :config
    (setq password-store-executable (executable-find "gopass")))

  (use-package! pass
    :config
    (setq pass-show-keybindings nil)))

;; Misc
(setq-default default-input-method "russian-computer")

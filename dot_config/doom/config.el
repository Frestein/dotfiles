;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(when (not (modulep! :ui doom-dashboard))
  (setq-default inhibit-startup-screen t
                inhibit-startup-message t
                inhibit-startup-echo-area-message t
                initial-scratch-message ""
                initial-buffer-choice (lambda ()
                                        (org-agenda nil "d")
                                        (delete-other-windows)
                                        (get-buffer "*Org Agenda*"))))

(setq user-full-name "Frestein"
      user-mail-address "frestein@tuta.io")

(setq doom-theme 'doom-gruvbox)

(custom-theme-set-faces! 'doom-gruvbox
  `(mode-line :background ,(doom-color 'base3) :foreground ,(doom-color 'modeline-fg)))

(setq doom-font                (font-spec :family "Maple Mono NF" :size 14)
      doom-big-font            (font-spec :family "Maple Mono NF" :size 24)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
      doom-serif-font          (font-spec :family "Noto Serif" :size 14)
      doom-emoji-font          (font-spec :family "Twemoji" :size 14)

      doom-symbol-font doom-font
      doom-symbol-fallback-font-families '("Twemoji"))

(after! telega
  (setq telega-emoji-font-family "Twemoji"))

(after! unicode-fonts
  (setq unicode-fonts-fallback-font-list doom-symbol-fallback-font-families)

  (dolist (block '("Dingbats"
                   "Emoticons"
                   "Transport and Map Symbols"
                   "Miscellaneous Symbols and Pictographs"
                   "Enclosed Alphanumeric Supplement"
                   "Supplemental Symbols and Pictographs"))
    (push "Twemoji" (cadr (assoc block unicode-fonts-block-font-mapping)))))

(custom-set-faces!
  '((font-lock-comment-face font-lock-keyword-face) :slant italic))

(setq doom-upgrade-command
      (format "%s upgrade -B --aot"
              ;; INFO: /usr/bin/env doesn't exist on Android
              (if (featurep :system 'android)
                  "sh %s"
                "%s"))
      doom-reload-command
      (format "%s sync -B -e --aot"
              ;; INFO: /usr/bin/env doesn't exist on Android
              (if (featurep :system 'android)
                  "sh %s"
                "%s")))

(setq shell-file-name (executable-find "bash"))
(when (executable-find "fish")
  (setq-default vterm-shell (executable-find "fish")
                explicit-shell-file-name (executable-find "fish")))

(map! :n "C-a" #'evil-numbers/inc-at-pt
      :v "C-a" #'evil-numbers/inc-at-pt-incremental
      :v "C-S-a" #'evil-numbers/inc-at-pt
      :n "C-x" #'evil-numbers/dec-at-pt
      :v "C-x" #'evil-numbers/dec-at-pt-incremental
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      :desc "Previous buffer" :n "H" #'previous-buffer
      :desc "Next buffer" :n "L" #'next-buffer
      :v "gss" #'sort-lines
      (:when (modulep! :term vterm )
        :desc "Toggle vterm popup" :n "C-/" #'+vterm/toggle
        :desc "Toggle vterm popup" :i "C-/" #'+vterm/toggle))

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
      (:prefix ("o" . "open")
       :desc "Open URL using generic browser" "g" #'browse-url-generic
       :desc "Open URL" "w" #'browse-url
       (:when (modulep! :term vterm)
         :desc "Open URL using text browser" "W" #'browse-url-text-vterm))
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
                 :desc "Elfeed (Summary)" "E" #'elfeed-summary
                 :desc "Elfeed" "e" #'elfeed))
      (:prefix ("f" . "file")
               (:when (modulep! :emacs dired)
                 :desc "Open directory in dirvish" "m" #'dirvish))
      (:prefix ("t" . "toggle")
       :desc "Automatic line breaking" "a" #'auto-fill-mode
       (:when (modulep! :tools blamer)
         :desc "Blamer mode" "B" #'global-blamer-mode)
       (:when (modulep! :ui colorful)
         :desc "Colorful mode" "C" #'global-colorful-mode)
       (:when (modulep! :checkers jinx)
         :desc "Jinx mode" "j" #'jinx-mode)))

(setq evil-echo-state nil)

(when (modulep! :editor evil)
  (when (modulep! :app telega)
    (after! telega
      (defun frestein/telega-chatbuf-cancel-both ()
        (interactive)
        (telega-chatbuf-filter-cancel)
        (telega-chatbuf-thread-cancel))

      (evil-collection-define-key 'normal 'telega-root-mode-map
        "gVD" #'telega-view-default)

      (evil-collection-define-key 'normal 'telega-chat-mode-map
        "_" #'frestein/telega-chatbuf-cancel-both
        "Za" #'telega-chatbuf-attach-animation
        "Zf" #'telega-chatbuf-attach-file
        "Zv" #'telega-chatbuf-attach-video)))

  (after! evil-snipe
    (when (modulep! :app telega)
      (dolist (mode '(telega-root-mode telega-chat-mode telega-chatbuf-mode))
        (unless (memq mode evil-snipe-disabled-modes)
          (push mode evil-snipe-disabled-modes))))
    (when (modulep! :tools ebuku)
      (unless (memq 'ebuku-mode evil-snipe-disabled-modes)
        (push 'ebuku-mode evil-snipe-disabled-modes)))))

(setq which-key-idle-delay 0.2
      ;; BUG: https://github.com/justbur/emacs-which-key/issues/345
      ;; which-key-show-operator-state-maps t
      )

(use-package! xdg
  :demand t)

(when (modulep! :tools magit)
  (setq magit-repository-directories `(("~/Projects" . 2)
                                       (,(xdg-user-dir "DOCUMENTS") . 1)
                                       ("~/.local/share/chezmoi" . 1)))

  (defun my-magit-todos-ignore-tangled-files (filename)
    "Return nil if an `.org` file with the same basename exists in the same directory,
ignoring all other files with the same basename."
    (let* ((basename (file-name-sans-extension (file-name-nondirectory filename)))
           (org-file (concat basename ".org"))
           (dir (file-name-directory filename))
           (org-path (when dir (expand-file-name org-file dir))))
      (if (and org-path (file-exists-p org-path)
               (not (string-suffix-p ".org" filename)))
          nil
        filename)))

  (when (modulep! :ui hl-todo)
    (use-package! magit-todos
      :after magit
      :hook (magit-mode . magit-todos-mode)
      :custom
      (magit-todos-ignored-keywords '("NOTE" "INFO" "MAYBE" "HACK" "TEMP" "KLUDGE" "DONT" "OKAY" "PROG" "THEM" "NEXT" "DONE"))
      (magit-todos-filename-filter #'my-magit-todos-ignore-tangled-files))))

(setq projectile-project-search-path '(("~/Projects/" . 2)))

(setq delete-by-moving-to-trash t
      dired-mouse-drag-files t
      mouse-drag-and-drop-region-cross-program t)

(map! :map dired-mode-map
      :v "u" #'dired-unmark)

(when (modulep! :emacs dired +dirvish)
  (use-package! dirvish
    :config
    (dirvish-peek-mode t)

    (setq dirvish-quick-access-entries
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

    (setq dirvish-attributes '(collapse git-msg file-modes file-time)
          dirvish-side-attributes '(collapse))

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

(setq org-directory (concat (xdg-user-dir "DOCUMENTS") "/org")
      org-agenda-files (list (concat org-directory "/agenda"))
      org-hide-emphasis-markers t
      org-edit-src-persistent-message nil
      org-log-done 'time
      ;; BUG: The second format is displayed incorrectly.
      ;;
      ;; For example:
      ;; SCHEDULED: <2025-09-26 Fri 02:00 PM-16:00>
      ;; The end time is shown in 24-hour format instead of using %I:%M %p.
      ;;
      ;; org-display-custom-times t
      ;; org-timestamp-custom-formats '("%Y-%m-%d %a" . "%Y-%m-%d %a %I:%M %p")
      org-agenda-timegrid-use-ampm t
      org-agenda-restore-windows-after-quit t)

(after! org
  (setq org-archive-tag "archive"
        org-element-archive-tag "archive"))

(when (modulep! :lang org)
  (after! org
    (when (modulep! :email mu4e)
      (setq +org-capture-emails-file "inbox.org"))

    (defvar +org-capture-inbox-file "inbox.org"
      "Default target for all entries.")

    (defvar +org-capture-metrics-file "metrics.org"
      "Default target for metrics entries.")

    (setq org-capture-templates
          `(("p" "Personal Tasks/Notes")
            ("pt" "Personal Task" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Personal Tasks")
             "* TODO %?\n:PROPERTIES:\n:Created: %U\n:END:\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("pn" "Personal Note" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Personal Notes")
             "* %u %?\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("P" "Project Tasks/Notes")
            ("Pt" "Project Task" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Project Tasks")
             "* TODO %?\n:PROPERTIES:\n:Created: %U\n:END:\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("Pn" "Project Note" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Personal Notes")
             "* %u %?\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("w" "Work Tasks/Notes")
            ("wt" "Work Task" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Work Tasks")
             "* TODO %?\n:PROPERTIES:\n:Created: %U\n:END:\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("wn" "Work Note" entry
             (file+headline ,(expand-file-name +org-capture-inbox-file org-directory) "Work Notes")
             "* %u %?\n\n%a\n\n%i"
             :prepend t
             :empty-lines 1)
            ("m" "Metrics")
            ("mw" "Weight" table-line
             (file+headline ,(expand-file-name +org-capture-metrics-file org-directory) "Weight")
             "| %U | %^{Weight} kg | %^{Note} |"
             :prepend t
             :kill-buffer t)
            ("j" "Journal" entry
             (file+olp+datetree ,(expand-file-name +org-capture-journal-file org-directory))
             "* %U %?"
             :prepend t)))

    (set-popup-rule! "^\\*Org Src" :side 'right :size 0.5 :quit nil :select t :autosave t :modeline t :ttl nil))

  (setq org-todo-repeat-to-state "LOOP"
        org-tag-alist '((:startgroup . "Places")
                        ("@home" . ?H)
                        ("@shop" . ?S)
                        ("@hospital" . ?L)
                        (:endgroup)

                        (:startgroup . "Devices")
                        ("@computer" . ?C)
                        ("@phone" . ?P)
                        (:endgroup)

                        (:startgroup . "Transport")
                        ("@bike" . ?b)
                        (:endgroup)

                        (:startgroup . "Activities")
                        ("@work" . ?w)
                        ("@freelance" . ?f)
                        ("@personal" . ?p)
                        ("@research" . ?r)
                        ("@management" . ?m)
                        ("@tech" . ?t)
                        ("@art" . ?a)
                        ("@sport" . ?s)
                        ("@health" . ?h)
                        ("@leisure" . ?l)
                        ("@metrics" . ?M)
                        ("@errands" . ?e)
                        (:endgroup))
        org-agenda-custom-commands '(("d" "Daily Agenda"
                                      ((agenda ""
                                               ((org-agenda-span 'day)
                                                (org-agenda-start-day "+0d")
                                                (org-deadline-warning-days 7)))
                                       (tags-todo ".*"
                                                  ((org-agenda-files '("~/Documents/org/inbox.org"))
                                                   (org-agenda-overriding-header "Unprocessed Inbox Tasks")))
                                       (tags-todo "-{.*}"
                                                  ((org-agenda-overriding-header "Untagged Tasks")))
                                       (tags-todo "+PRIORITY=\"A\""
                                                  ((org-agenda-overriding-header "High Priority Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+PRIORITY=\"B\""
                                                  ((org-agenda-overriding-header "Medium Priority Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+PRIORITY=\"C\""
                                                  ((org-agenda-overriding-header "Low Priority Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))))
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
                                                (org-agenda-span 'week)))))
                                     ("p" "Personal"
                                      ((tags-todo "+@personal+@management-@research"
                                                  ((org-agenda-overriding-header "Management Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@research"
                                                  ((org-agenda-overriding-header "Research Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@tech-@research"
                                                  ((org-agenda-overriding-header "Tech Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@sport-@research"
                                                  ((org-agenda-overriding-header "Sport Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@art-@research"
                                                  ((org-agenda-overriding-header "Art Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+personal+@leisure"
                                                  ((org-agenda-overriding-header "Leisure Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@home"
                                                  ((org-agenda-overriding-header "Home Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+@health-problem-@research"
                                                  ((org-agenda-overriding-header "Health Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@personal+problem"
                                                  ((org-agenda-overriding-header "Problem Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))))
                                     ("P" "Projects"
                                      ((tags-todo "+@project+@personal"
                                                  ((org-agenda-overriding-header "Personal Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@project-@personal"
                                                  ((org-agenda-overriding-header "Contribution Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))))
                                     ("w" "Work"
                                      ((tags-todo "+@work+@personal"
                                                  ((org-agenda-overriding-header "Personal Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP")))))
                                       (tags-todo "+@work+@freelance"
                                                  ((org-agenda-overriding-header "Freelance Tasks")
                                                   (org-agenda-skip-function
                                                    '(org-agenda-skip-entry-if 'todo '("WAIT" "IDEA" "DONE" "LOOP"))))))))
        org-refile-targets '((org-agenda-files :maxlevel . 6)))

  (defmacro ignore-args (fnc)
    "Returns function that ignores its arguments and invokes FNC."
    `(lambda (&rest _rest)
       (funcall ,fnc)))

  (advice-add 'org-deadline :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-schedule :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-store-log-note :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-todo :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (dolist (hook '(org-after-tags-change-hook
                  org-after-refile-insert-hook
                  org-after-todo-state-change-hook
                  org-capture-after-finalize-hook))
    (add-hook hook #'org-save-all-org-buffers))

  (defun frestein/org-agenda-delete-empty-blocks ()
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

  (add-hook 'org-agenda-finalize-hook #'frestein/org-agenda-delete-empty-blocks)

  (defun frestein/org-fold-respect-startup-ignore-tag ()
    "Fold according to #+STARTUP: and ignore folding for tags from #+STARTUP_IGNORE:."
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

  (add-hook 'org-mode-hook #'frestein/org-fold-respect-startup-ignore-tag)

  (defun frestein/org-emphasize-dwim (char)
    "Toggle org emphasis CHAR on word or selected region.
If a region is active, emphasize it, else emphasize the word at point."
    (interactive "cEmphasis char: ")
    (if (use-region-p)
        (org-emphasize char)
      (save-excursion
        (let ((bounds (bounds-of-thing-at-point 'word)))
          (when bounds
            (goto-char (car bounds))
            (set-mark (cdr bounds))
            (org-emphasize char)
            (deactivate-mark))))))

  (map! :map org-mode-map
        :after org
        :localleader
        "B" #'org-babel-tangle
        (:prefix ("e" . "emphasize")
         :desc "Bold" "b" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?*))
         :desc "Italic" "i" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?\/))
         :desc "Underline" "u" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?_))
         :desc "Strike-through" "s" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?\+))
         :desc "Verbatim" "v" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?=))
         :desc "Code" "c" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?~)))
        "E" #'org-export-dispatch)

  (map! :map telega-chat-mode-map
        :when (modulep! :app telega)
        :localleader
        (:prefix ("e" . "emphasize")
         :desc "Bold" "b" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?*))
         :desc "Italic" "i" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?\/))
         :desc "Underline" "u" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?_))
         :desc "Strike-through" "s" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?\+))
         :desc "Verbatim" "v" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?=))
         :desc "Code" "c" #'(lambda () (interactive) (frestein/org-emphasize-dwim ?~))))

  (map! :map org-agenda-mode-map
        :localleader
        "s" #'org-save-all-org-buffers)

  (use-package! org-super-agenda
    :hook (org-agenda-mode . org-super-agenda-mode))

  (use-package! org-expose-emphasis-markers
    :hook (org-mode . org-expose-emphasis-markers-mode))

  (use-package! corg
    :hook (org-mode . corg-setup)))

(custom-theme-set-faces! 'doom-gruvbox
  '(markdown-header-face-1 :inherit outline-1)
  '(markdown-header-face-2 :inherit outline-2)
  '(markdown-header-face-3 :inherit outline-3)
  '(markdown-header-face-4 :inherit outline-4)
  '(markdown-header-face-5 :inherit outline-5)
  '(markdown-header-face-6 :inherit outline-6))

(defun is-arch-linux-p ()
  "Return t if the current system is Arch Linux."
  (with-temp-buffer
    (when (file-readable-p "/etc/os-release")
      (insert-file-contents "/etc/os-release")
      (goto-char (point-min))
      (re-search-forward "^ID=arch" nil t))))

(when (modulep! :tools lsp +eglot)
  (when (is-arch-linux-p)
    (when (modulep! :lang qt)
      (defun +qt-common-config (mode)
        (when (modulep! :lang qt +lsp)
          (set-eglot-client! mode '("qmlls6"))
          (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append))))))

(setq browse-url-text-browser (executable-find "cha")
      browse-url-generic-program (executable-find "qutebrowser"))

(when (modulep! :term vterm)
  (defun close-vterm-buffer-on-exit (_buffer _event)
    "Close vterm buffer and its window upon process exit."
    (let ((buf (current-buffer))
          (win (get-buffer-window (current-buffer))))
      (when (buffer-live-p buf)
        (when (and win (not (one-window-p)))
          (delete-window win))
        (kill-buffer buf))))

  (defun browse-url-text-vterm (url &optional new-buffer)
    "Ask a text browser to load URL inside vterm."
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
            (add-hook 'vterm-exit-functions #'close-vterm-buffer-on-exit nil t)
            (vterm-send-string browser-cmd)
            (vterm-send-return)
            (switch-to-buffer buf)
            (delete-other-windows))
        (switch-to-buffer buf)
        (vterm-send-string (concat "g \C-u" encoded-url "\r"))
        (delete-other-windows)))))

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

(when (modulep! :email mu4e)
  (after! mu4e
    (setq mu4e-root-maildir (expand-file-name "~/Documents/mail")
          mu4e-attachment-dir "~/Downloads/mu4e"
          mu4e-update-interval 300
          sendmail-program (executable-find "msmtp")
          message-send-mail-function #'message-send-mail-with-sendmail
          message-sendmail-f-is-evil t
          send-mail-function #'sendmail-send-it
          doom-modeline-mu4e t)

    (when (modulep! :email mu4e +gmail)
      ;; don't need to run cleanup after indexing for gmail
      (setq mu4e-index-cleanup nil
            ;; because gmail uses labels as folders we can use lazy check since
            ;; messages don't really "move"
            mu4e-index-lazy-check t))

    (when (modulep! :email mu4e +org)
      (setq +mu4e-compose-org-msg-toggle-next nil))

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

(setq epg-gpg-home-directory (getenv "GNUPGHOME"))

(when (modulep! :config default +gnupg)
  (use-package! pinentry
    :hook (doom-after-init . pinentry-start)))

(when (modulep! :tools pass)
  (when (executable-find "gopass")
    (setq backup-directory-alist
          (append
           '(("/dev/shm/gopass.*" . nil))
           backup-directory-alist)))

  (use-package! password-store
    :config
    (when (executable-find "gopass")
      (setq password-store-executable (executable-find "gopass"))))

  (use-package! pass
    :config
    (setq pass-show-keybindings nil)))

(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)

(setq display-line-numbers-type 'relative)

(when (modulep! :ui smooth-scroll)
  ;; Disable ultra-scroll
  (remove-hook 'doom-first-input-hook #'ultra-scroll-mode)
  (remove-hook 'doom-first-file-hook #'ultra-scroll-mode))

(when (modulep! :ui hl-todo)
  (after! hl-todo
    (let ((frestein/hl-todo-keyword-faces
           '(("TODO" (font-lock-variable-name-face bold) nil)
             ("FIX"  (error bold) nil)
             ("WARN"  (warning bold) ("WARNING" "XXX"))
             ("PERF"  (font-lock-variable-name-face bold) ("OPTIM" "PERFORMANCE" "OPTIMIZE"))
             ("NOTE"  (success bold) ("INFO"))
             ("TEST"  (font-lock-variable-name-face bold) ("TESTING" "PASSED" "FAILED")))))
      (dolist (e frestein/hl-todo-keyword-faces)
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

(when (modulep! :ui zen)
  (setq +zen-text-scale 0
        writeroom-width 100))

(when (modulep! :app everywhere)
  (setq emacs-everywhere-window-focus-command (list "hyprctl" "dispatch" "focuswindow" "address:%w"))
  (setq emacs-everywhere-app-info-function #'emacs-everywhere--app-info-linux-hyprland)

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

(setq default-input-method "russian-computer"
      calendar-week-start-day 1
      confirm-kill-emacs nil)

(when (modulep! :app telega)
  (defun telega-server-process-running-p ()
    "Check if telega-server process is running."
    (not (string-equal (shell-command-to-string "pgrep -x telega-server") "")))

  (unless (telega-server-process-running-p)
    (if (daemonp)
        (add-hook! doom-first-input (telega 'no-popup))
      (add-hook! doom-after-init (telega 'no-popup)))))

(when (modulep! :tools biome)
  (after! biome
    (setq biome-query-coords
          '(("Saint-Petersburg, Russia" 59.938732 30.316229)
            ("Mednogorsk, Russia" 51.404944 57.580314)))))

(when (modulep! :tools fj)
  (setq fj-host "https://codeberg.org"
        fj-user "Frestein")

  (when (modulep! :tools pass +auth)
    (setq fj-token-use-auth-source nil)

    (defun frestein/fj-set-token ()
      (setq fj-token (auth-source-pass-get 'secret "work/git/codeberg.org/api/fj.el")))

    (if (daemonp)
        (add-hook! doom-first-input (frestein/fj-set-token))
      (add-hook! doom-init-ui (frestein/fj-set-token)))))

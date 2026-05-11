;;; app/telega/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/telega--init-map-h (&rest _)
  "Initialize custom telega keybindings."
  (evil-collection-define-key 'normal 'telega-chat-mode-map
    (kbd "RET") 'telega-chatbuf-newline-or-input-send)

  (map! (:map telega-root-mode-map
         :n "h" #'telega-button-backward
         :n "l" #'telega-button-forward
         :n "gVD" #'telega-view-default)
        (:map telega-chat-button-map
              "C" nil
              "D" nil
              "h" nil
              "g?" nil
              "d" #'telega-transient-chat-delete
              "A" #'telega-chat-toggle-archive
              "H" #'telega-describe-chat
              "i" #'telega-describe-chat
              (:prefix ("g?" . "describe")
                       "u" #'telega-describe-user
                       "c" #'telega-describe-chat))
        (:map telega-msg-button-map
         "SPC" nil
         :n "C-p" #'telega-msg-previous
         :n "C-n" #'telega-msg-next
         :n "K" #'telega-msg-previous
         :n "J" #'telega-msg-next)
        (:map telega-chat-mode-map
         :n [tab] #'telega-button-forward
         :n [backtab] #'telega-button-backward
         :n "_" #'fr/telega-chatbuf-cancel-dwim
         :n "H" #'telega-describe-chat
         :n "C-p" #'telega-msg-previous
         :n "C-n" #'telega-msg-next
         :n "K" #'telega-msg-previous
         :n "J" #'telega-msg-next
         :n "Za" #'telega-chatbuf-attach-animation
         :n "Zf" #'telega-chatbuf-attach-file
         :n "Zv" #'telega-chatbuf-attach-video
         :n "ZA" #'telega-chatbuf-attach-audio
         :n "Zc" #'telega-chatbuf-attach-clipboard
         :n "ZC" #'telega-chatbuf-attach-checklist
         :n "ZV" #'telega-chatbuf-attach-voice-note
         :n "Zd" #'telega-chatbuf-attach-dice
         :n "Zm" #'telega-chatbuf-attach-media
         :n "Zp" #'telega-chatbuf-attach-poll
         :n "Zs" #'telega-chatbuf-attach-sticker
         :n "Zz" #'telega-chatbuf-attach
         (:localleader
          "@" #'fr/telega-chatbuf-inline-bot-choose
          (:prefix ("t" . "translate")
                   "r" #'telega-translate-region
                   "R" #'telega-translate-region-inplace
                   "a" #'telega-auto-translate-mode)
          (:prefix ("i" . "input")
                   "b" #'fr/telega-chatbuf-inline-bot-choose
                   (:prefix ("f" . "format")
                    :desc "Bold"          "b" #'fr/telega-format-bold
                    :desc "Italic"        "i" #'fr/telega-format-italic
                    :desc "Underline"     "u" #'fr/telega-format-underline
                    :desc "Strikethrough" "s" #'fr/telega-format-strikethrough
                    :desc "Spoiler"       "S" #'fr/telega-format-spoiler
                    :desc "Monospace"     "m" #'fr/telega-format-monospace
                    :desc "Quote"         "q" #'fr/telega-format-quote
                    :desc "Link"          "l" #'fr/telega-format-link
                    :desc "Clear"         "c" #'fr/telega-format-clear))
          (:prefix ("f" . "folder")
                   "a" #'telega-chat-add-to-folder
                   "d" #'telega-chat-remove-from-folder)
          (:prefix ("d" . "describe")
                   "w" #'telega-describe-connected-websites
                   "s" #'telega-describe-active-sessions
                   "n" #'telega-describe-network
                   "N" #'telega-describe-notifications
                   "p" #'telega-describe-privacy-settings
                   "c" #'telega-describe-chat
                   "C" #'telega-describe-chat-members)
          (:prefix ("s" . "search")
                   "s" #'telega-chatbuf-filter-search
                   "S" #'telega-chatbuf-filter-by-sender
                   "t" #'telega-chatbuf-filter-by-topic
                   "p" #'telega-chatbuf-filter-scheduled
                   "h" #'telega-chatbuf-filter-hashtag
                   "f" #'telega-chatbuf-filter
                   "F" #'telega-chatbuf-filter-favorite)
          (:prefix ("S" . "stickers")
                   "f" #'telega-sticker-choose-favorite-or-recent
                   "c" #'telega-stickerset-choose
                   "t" #'telega-stickerset-trends
                   "s" #'telega-stickerset-search)))))

;;;###autoload
(defun fr/telega--override-evil-collection-keys (&rest _)
  "Ensure custom telega keybindings override evil-collection's defaults.
Adds advice to `evil-collection-telega-setup' to run `fr/telega--init-map-h'
after it, so personal bindings always take priority over evil-collection."
  (advice-add #'evil-collection-telega-setup :after #'fr/telega--init-map-h))

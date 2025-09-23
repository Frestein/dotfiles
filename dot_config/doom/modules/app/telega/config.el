;;; app/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :bind-keymap ("C-c t" . telega-prefix-map)
  :bind ((:map telega-msg-button-map
               ("SPC" . nil))
         (:map telega-chat-mode-map
               ("Za" . telega-chatbuf-attach-animation)
               ("ZA" . telega-chatbuf-attach-audio)
               ("Zc" . telega-chatbuf-attach-clipboard)
               ("ZC" . telega-chatbuf-attach-checklist)
               ("Zv" . telega-chatbuf-attach-video)
               ("ZV" . telega-chatbuf-attach-voice-note)
               ("Zd" . telega-chatbuf-attach-dice)
               ("Zf" . telega-chatbuf-attach-file)
               ("Zm" . telega-chatbuf-attach-media)
               ("Zp" . telega-chatbuf-attach-poll)
               ("Zs" . telega-chatbuf-attach-sticker)
               ("Zz" . telega-chatbuf-attach)))
  :hook (telega-load . telega-appindicator-mode)
  :hook (telega-load . telega-mode-line-mode)
  :hook (telega-load . telega-notifications-mode)
  :init
  (setq telega-directory (expand-file-name "~/.local/share/telega")
        telega-database-dir (expand-file-name "~/.local/share/telega")
        telega-cache-dir (expand-file-name "~/.cache/telega/cache")
        telega-temp-dir (expand-file-name "~/.cache/telega/temp"))
  :config
  (setq telega-server-libs-prefix "/usr"
        telega-translate-to-language-by-default "ru"
        telega-video-player-command "mpv"
        telega-use-images t
        telega-sticker-animated-play t ;; WARN: requires tgs2png
        telega-animation-play-inline 20
        telega-date-format-alist '((today          . "%I:%M %p ")
                                   (this-week      . "%I:%M %p ")
                                   (old            . "%d.%m.%y ")
                                   (date           . "%d.%m.%y")
                                   (time           . "%I:%M %p")
                                   (date-time      . "%d.%m.%y %a %I:%M %p")
                                   (date-long      . "%d %B %Y")
                                   (date-break-bar . "%d %B %Y %a"))
        telega-known-inline-bots (append telega-known-inline-bots
                                         '("@vid" "@hbvidbot" "@hlebashbot" "@wiki" "@foursquare"))
        telega-chat-input-markups '("org" nil "markdown2")
        telega-currency-symbols-alist '(("EUR" . "€")     ;; Euro
                                        ("USD" . "$")     ;; US Dollar
                                        ("RUB" . "₽")     ;; Russian Ruble
                                        ("GBP" . "£")     ;; British Pound
                                        ("JPY" . "¥")     ;; Japanese Yen
                                        ("CNY" . "¥")     ;; Chinese Yuan (same symbol as Yen)
                                        ("INR" . "₹")     ;; Indian Rupee
                                        ("KRW" . "₩")     ;; South Korean Won
                                        ("TRY" . "₺")     ;; Turkish Lira
                                        ("UAH" . "₴")     ;; Ukrainian Hryvnia
                                        ("PLN" . "zł")    ;; Polish Zloty (zł)
                                        ("NGN" . "₦")     ;; Nigerian Naira
                                        ("KZT" . "₸")     ;; Kazakhstan Tenge
                                        ("THB" . "฿")     ;; Thai Baht
                                        ("CHF" . "Fr")    ;; Swiss Franc (Fr)
                                        ("AUD" . "A$")    ;; Australian Dollar
                                        ("CAD" . "C$")    ;; Canadian Dollar
                                        ("MXN" . "MX$")   ;; Mexican Peso
                                        ("BRL" . "R$"))   ;; Brazilian Real
        telega-builtin-palettes-alist
        '((light
           ((:outline "#cc241d") (:foreground "#bb3e06")     (:background "#fbf1c7"))
           ((:outline "#d65d0e") (:foreground "DarkOrange3") (:background "#fbf1c7"))
           ((:outline "#897ea6") (:foreground "purple3")     (:background "#fbf1c7"))
           ((:outline "#98971a") (:foreground "#98971a")     (:background "#fbf1c7"))
           ((:outline "#689d6a") (:foreground "cyan4")       (:background "#fbf1c7"))
           ((:outline "#458588") (:foreground "#458588")     (:background "#fbf1c7"))
           ((:outline "#b16286") (:foreground "DeepPink3")   (:background "#fbf1c7")))
          (dark
           ((:outline "#fb4934") (:foreground "#cc241d")     (:background "#282828"))
           ((:outline "#fe8019") (:foreground "DarkOrange2") (:background "#282828"))
           ((:outline "#d3869b") (:foreground "violet")      (:background "#282828"))
           ((:outline "#b8bb26") (:foreground "#b8bb26")     (:background "#282828"))
           ((:outline "#8ec07c") (:foreground "cyan3")       (:background "#282828"))
           ((:outline "#83a598") (:foreground "#83a598")     (:background "#282828"))
           ((:outline "#d3869b") (:foreground "#d3869b")     (:background "#282828"))
           )))

  (when (modulep! +icons)
    (setq telega-emoji-use-images nil
          telega-symbols-emojify
          (cl-reduce (lambda (emojify key)
                       (assq-delete-all key emojify))
                     '(checkmark heavy-checkmark
                       reply reply-quote forward
                       button-close forum verified
                       radiobox-off radiobox-on
                       checkbox-off checkbox-on
                       outline-close outline-open
                       button-left button-right
                       chat-list checklist
                       folder multiple-folders
                       reaction reaction-mark
                       rewind-backward rewind-forward
                       story story-reply
                       video video-chat-active video-chat-passive
                       ;; vbar-left vertical-bar horizontal-bar underline-bar
                       alarm attachment audio author-hidden bell boost bulp
                       contact distance eye failed favorite flames
                       game invoice leave-comment lightning lock location
                       member menu my-notes
                       pause pending phone photo pin poll play premium
                       right-arrow saved-messages-tag-end
                       telegram-star timer-clock typing)
                     :initial-value telega-symbols-emojify)
          telega-symbol-alarm                 "󰯪 "
          telega-symbol-attachment            "󰁦"
          telega-symbol-audio                 ""
          telega-symbol-author-hidden         " "
          telega-symbol-bell                  " "
          telega-symbol-blocked               (propertize "󰂭" 'face 'error)
          telega-symbol-boost                 " "
          telega-symbol-bulp                  " "
          telega-symbol-chat-list             " "
          telega-symbol-checklist             " "
          telega-symbol-circle                ""
          telega-symbol-codeblock             ""
          telega-symbol-contact               " "
          telega-symbol-copyright             ""
          telega-symbol-credit-card           ""
          telega-symbol-direct-messages       "󰍥"
          telega-symbol-distance              " "
          telega-symbol-eye                   " "
          telega-symbol-failed                (propertize "" 'face 'error)
          telega-symbol-favorite              ""
          telega-symbol-flames                ""
          telega-symbol-forum                 "󰠢"
          telega-symbol-forward               ""
          telega-symbol-game                  " "
          telega-symbol-invoice               "󰗋 "
          telega-symbol-keyboard              " "
          telega-symbol-leave-comment         " "
          telega-symbol-lightning             " "
          telega-symbol-location              " "
          telega-symbol-lock                  " "
          telega-symbol-member                " "
          telega-symbol-mode                  ""
          telega-symbol-my-notes              ""
          telega-symbol-online-status         ""
          telega-symbol-outline-close         "󰍟"
          telega-symbol-outline-open          "󰍝"
          telega-symbol-pause                 ""
          telega-symbol-pending               "󰔟"
          telega-symbol-phone                 " "
          telega-symbol-photo                 ""
          telega-symbol-pin                   (propertize "" 'face 'telega-shadow)
          telega-symbol-play                  ""
          telega-symbol-poll                  ""
          telega-symbol-premium               (propertize "" 'face 'telega-blue)
          telega-symbol-reaction              ""
          telega-symbol-reaction-mark         ""
          telega-symbol-reply                 ""
          telega-symbol-right-arrow           " 󰧂 "
          telega-symbol-star                  (propertize "󰓎" 'face 'error)
          telega-symbol-story                 " "
          telega-symbol-story-reply           (compose-chars ? ?)
          telega-symbol-telegram              (propertize " " 'face '(italic telega-blue))
          telega-symbol-telegram-star         (propertize "󰓎" 'face '(:foreground "goldenrod"))
          telega-symbol-timer-clock           "󰔛 "
          telega-symbol-verified              (propertize " " 'face 'telega-blue)
          telega-symbol-video                 ""
          telega-symbol-video-chat            "󰯜"
          telega-symbol-video-chat-active     (propertize "󰯜" 'face 'success)
          telega-symbol-video-chat-passive    (propertize "󰯛" 'face 'telega-shadow)
          telega-symbol-horizontal-bar        "─"
          telega-symbol-vertical-bar          "│"
          telega-symbol-folder                "󰉖 "
          telega-symbol-multiple-folders      "󰉕 "
          telega-symbol-checkmark             "󰄬"
          telega-symbol-heavy-checkmark       "󰄭"
          telega-symbol-checkbox-on           ""
          telega-symbol-checkbox-off          ""
          telega-symbol-radiobox-on           "󰝥"
          telega-symbol-radiobox-off          "󰝦"
          telega-symbol-poll-options          (list "󰝦" "󰝥")
          telega-symbol-poll-multiple-options (list "󰄱" "󰱒")
          telega-symbol-dice-list             (list "󱅊" "󰇊" "󰇋" "󰇌" "󰇍" "󰇎" "󰇏")
          telega-folder-icons-alist '(("Airplane" . " ")
                                      ("All"      . "󰻞 ")
                                      ("Book"     . " ")
                                      ("Bots"     . " ")
                                      ("Cat"      . "󰄛 ")
                                      ("Channels" . " ")
                                      ("Crown"    . "󱇐 ")
                                      ("Custom"   . "󰉖 ")
                                      ("Favorite" . " ")
                                      ("Flower"   . "󰉊 ")
                                      ("Game"     . " ")
                                      ("Groups"   . "󰭘 ")
                                      ("Home"     . " ")
                                      ("Light"    . " ")
                                      ("Like"     . " ")
                                      ("Love"     . " ")
                                      ("Mask"     . "󰴂 ")
                                      ("Money"    . " ")
                                      ("Note"     . "󰺿 ")
                                      ("Palette"  . "󰸌 ")
                                      ("Party"    . " ")
                                      ("Private"  . " ")
                                      ("Setup"    . "󰨸 ")
                                      ("Sport"    . "󱅝 ")
                                      ("Study"    . " ")
                                      ("Trade"    . "󰄨 ")
                                      ("Travel"   . " ")
                                      ("Unmuted"  . " ")
                                      ("Unread"   . " ")
                                      ("Work"     . " "))))

  ;; INFO: Disable TODO debug message.
  (defun telega--on-updateSuggestedActions (event)
    (let ((added-actions (append (plist-get event :added_actions) nil))
          (removed-actions (append (plist-get event :removed_actions) nil)))
      (setq telega--suggested-actions
            (append (seq-difference telega--suggested-actions removed-actions
                                    #'equal)
                    added-actions))))

  ;; WARN: TOS violation. Block sponsored messages.
  ;; sponsored - Fetch messages but don't draw them.
  ;; sponsored2 - Don't fetch messages.
  (when (or (modulep! +sponsored) (modulep! +sponsored2))
    (setq telega-inserter-for-sponsored-msg-button nil)

    (defun telega-chatbuf--sponsored-messages-fetch ()
      "Asynchronously fetch sponsored messages for the chatbuf."
      (when (modulep! +sponsored)
        (let* ((chat telega-chatbuf--chat)
               (tsm-orig (plist-get chat :telega-sponsored-messages)))
          (plist-put chat :telega-sponsored-messages nil)
          (when (telega-chat-match-p chat '(type channel))
            (telega--getChatSponsoredMessages telega-chatbuf--chat
              (lambda (reply)
                (plist-put chat :telega-sponsored-messages reply))))))))

  (defun frestein/telega-chatbuf-inline-bot-choose ()
    "Select an inline bot from telega-known-inline-bots and insert it."
    (interactive)
    (let ((bot (completing-read "Choose inline bot: " telega-known-inline-bots nil t)))
      (when bot
        (insert bot))))

  (map! :map telega-chat-mode-map
        (:localleader
         "@" #'frestein/telega-chatbuf-inline-bot-choose
         (:prefix ("t" . "translate")
                  "r" #'telega-translate-region
                  "R" #'telega-translate-region-inplace
                  "a" #'telega-auto-translate-mode)
         (:prefix ("i" . "input")
                  "b" #'frestein/telega-chatbuf-inline-bot-choose
                  "f" #'telega-chatbuf-input-formatting-set)
         (:prefix ("s" . "stickers")
                  "f" #'telega-sticker-choose-favorite-or-recent
                  "c" #'telega-stickerset-choose
                  "t" #'telega-stickerset-trends
                  "s" #'telega-stickerset-search)
         (:when (modulep! :lang org)
           "c" #'org-cliplink))))

(use-package! telega-mnz
  :when (modulep! +mnz)
  :after-call telega
  :hook (telega-load  . global-telega-mnz-mode)
  :config
  (setq telega-mnz-use-language-detection 32))

(use-package! language-detection
  :when (modulep! +mnz))

;; TODO: WIP
;; (use-package! telega-dashboard
;;   :when (modulep! +dashboard)
;;   :after-call telega
;;   :config
;;   (add-to-list '+doom-dashboard-menu-sections
;;                '("Important telega chats"
;;                  :icon (nerd-icons-faicon "nf-fa-comment" :face 'doom-dashboard-menu-title)
;;                  :action (lambda () (telega-dashboard-show))
;;                  :when (featurep 'telega-dashboard))
;;                t))

(use-package! telega-emacs-stories
  :when (modulep! +stories)
  :after-call telega
  :hook (telega-load  . telega-emacs-stories-mode)
  :bind (:map telega-root-mode-map
              ("v e" . telega-view-emacs-stories)))

(use-package! telega-url-shorten-nerd
  :when (modulep! +icons)
  :after-call telega
  :hook (telega-load  . global-telega-url-shorten-nerd-mode))

(use-package! telega-adblock
  :when (modulep! +adblock)
  :after-call telega
  :hook (telega-load  . telega-adblock-mode))

(use-package! telega-dired-dwim
  :when (modulep! :emacs dired)
  :after-call telega)

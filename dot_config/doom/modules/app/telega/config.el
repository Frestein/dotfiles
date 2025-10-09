;;; app/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :hook ((telega-load . telega-appindicator-mode)
         (telega-load . telega-mode-line-mode)
         (telega-load . telega-notifications-mode)
         (telega-load . telega-autoplay-mode)
         (telega-chat-mode . turn-off-smartparens-mode)
         (telega-chat-mode . doom-disable-show-paren-mode-h))
  :init
  (setq telega-directory (concat (getenv "XDG_DATA_HOME") "/telega")
        telega-database-dir (concat (getenv "XDG_DATA_HOME") "/telega/db")
        telega-cache-dir (concat (getenv "XDG_CACHE_HOME") "/telega/cache")
        telega-temp-dir (concat (getenv "XDG_CACHE_HOME") "/telega/temp"))
  :config
  (setq telega-server-libs-prefix "/usr"
        telega-msg-save-dir (concat (xdg-user-dir "DOWNLOAD") "/telega")
        telega-root-default-view-function 'telega-view-folders
        telega-translate-to-language-by-default "ru"
        telega-video-player-command "mpv"
        telega-chat-show-deleted-messages-for '(not saved-messages)
        telega-sticker-size '(8 . 26)
        telega-use-images t
        telega-sticker-animated-play t ;; WARN: requires tgs2png
        telega-animation-play-inline 60
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
        telega-chat-input-markups '("org" "markdown2")
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
           ((:outline "#d3869b") (:foreground "#d3869b")     (:background "#282828")))))

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
          telega-chat-prompt-insexp
          '(telega-ins--with-face (unless (telega-chatbuf-match-p 'can-send-or-post)
                                    'telega-shadow)
             (telega-chatbuf-prompt-ins-default-sender-avatar)
             (telega-chatbuf-prompt-ins-body)
             (when (or (telega-chatbuf-match-p 'has-default-sender)
                       (telega-chatbuf-match-p 'can-send-or-post))
               (telega-chatbuf-prompt-ins-chat-avatar))
             (telega-chatbuf-prompt-ins-topic 25)
             (telega-auto-translate--chatbuf-prompt-ins-translation)
             (telega-ins "  "))
          telega-symbol-alarm                 "󰯪 "
          telega-symbol-attachment            "󰁦"
          telega-symbol-audio                 ""
          telega-symbol-author-hidden         " "
          telega-symbol-bell                  " "
          telega-symbol-blocked               (propertize "󰂭" 'face 'error)
          telega-symbol-boost                 " "
          telega-symbol-bulp                  " "
          telega-symbol-button-close          "󰅘"
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
          telega-symbol-premium               (propertize " 󰦥" 'face 'telega-blue)
          telega-symbol-reaction              ""
          telega-symbol-reaction-mark         ""
          telega-symbol-reply                 ""
          telega-symbol-reply-quote           ""
          telega-symbol-right-arrow           "  "
          telega-symbol-star                  (propertize "󰓎" 'face 'error)
          telega-symbol-story                 ""
          telega-symbol-story-reply           ""
          telega-symbol-telegram              (propertize " " 'face '(italic telega-blue))
          telega-symbol-telegram-star         (propertize "󰓎" 'face '(:foreground "goldenrod"))
          telega-symbol-timer-clock           "󰔛 "
          telega-symbol-typing                ""
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

  ;; INFO: Add space after vertical bar in folder prefix
  (defun telega-folders-insert-default (&optional fmt-spec)
    "Default inserter for the folders prefixing chat's title."
    (let ((fmt-spec (or fmt-spec (eval-when-compile
                                   (propertize "%F" 'face 'bold)))))
      (if telega-tdlib--chat-folder-tags-p
          (telega-folders-insert-as-tags fmt-spec telega-chat-folders)
        (when (cond ((> (length telega-chat-folders) 1)
                     (telega-ins (telega-symbol 'multiple-folders)))
                    (telega-chat-folders
                     (telega-ins (telega-folder-format
                                  fmt-spec (car telega-chat-folders)))))
          (telega-ins (concat (telega-symbol 'vertical-bar) " "))))))

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

  ;; INFO: Ignore messages from blocked senders.
  (when (modulep! +blocked)
    (add-hook 'telega-msg-ignore-predicates
              (telega-match-gen-predicate 'msg '(sender is-blocked))))

  (defun frestein/telega-chatbuf-inline-bot-choose ()
    "Select an inline bot from telega-known-inline-bots and insert it."
    (interactive)
    (let ((bot (completing-read "Choose inline bot: " telega-known-inline-bots nil t)))
      (when bot
        (insert bot))))

  (map! (:map telega-msg-button-map
         "SPC" nil
         :n "C-p" #'telega-msg-previous
         :n "C-n" #'telega-msg-next)
        (:map telega-chat-mode-map
         :n "C-p" #'telega-msg-previous
         :n "C-n" #'telega-msg-next
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
          "@" #'frestein/telega-chatbuf-inline-bot-choose
          (:prefix ("t" . "translate")
                   "r" #'telega-translate-region
                   "R" #'telega-translate-region-inplace
                   "a" #'telega-auto-translate-mode)
          (:prefix ("i" . "input")
                   "b" #'frestein/telega-chatbuf-inline-bot-choose
                   "f" #'telega-chatbuf-input-formatting-set)
          (:prefix ("d" . "describe")
                   "w" #'telega-describe-connected-websites
                   "s" #'telega-describe-active-sessions
                   "n" #'telega-describe-network
                   "N" #'telega-describe-notifications
                   "p" #'telega-describe-privacy-settings
                   "c" #'telega-describe-chat
                   "C" #'telega-describe-chat-members)
          (:prefix ("s" . "stickers")
                   "f" #'telega-sticker-choose-favorite-or-recent
                   "c" #'telega-stickerset-choose
                   "t" #'telega-stickerset-trends
                   "s" #'telega-stickerset-search)
          (:when (modulep! :lang org)
            "c" #'org-cliplink)))))

(use-package! telega-mnz
  :when (modulep! +mnz)
  :after-call telega
  :hook (telega-load  . global-telega-mnz-mode)
  :config
  (setq telega-mnz-use-language-detection 32))

(use-package! language-detection
  :when (modulep! +mnz))

(use-package! telega-emacs-stories
  :when (modulep! +stories)
  :after-call telega
  :hook (telega-load  . telega-emacs-stories-mode)
  :bind (:map telega-root-mode-map
              ("gVe" . telega-view-emacs-stories)))

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

(use-package! ol-telega
  :when (modulep! :lang org)
  :after-call telega)

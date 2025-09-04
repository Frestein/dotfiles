;;; app/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :bind-keymap ("C-c t" . telega-prefix-map)
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
        telega-use-images t
        telega-emoji-use-images nil
        telega-currency-symbols-alist
        '(("EUR" . "€")     ;; Euro
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
          ("BRL" . "R$")))   ;; Brazilian Real

  (when (modulep! +icons)
    (setq
     telega-symbol-alarm "󰯪 "
     telega-symbol-attachment "󰁦 "
     telega-symbol-audio " "
     telega-symbol-bell " "
     telega-symbol-blocked "󰂭 "
     telega-symbol-boost " "
     telega-symbol-bulp " "
     telega-symbol-chat-list "󱉯 "
     telega-symbol-circle " "
     telega-symbol-codeblock " "
     telega-symbol-contact " "
     telega-symbol-copyright ""
     telega-symbol-credit-card " "
     telega-symbol-distance " "
     telega-symbol-eye " "
     telega-symbol-failed ""
     telega-symbol-favorite ""
     telega-symbol-flames ""
     telega-symbol-forum "󰠢 "
     telega-symbol-forward " "
     telega-symbol-game " "
     telega-symbol-invoice "󰗋 "
     telega-symbol-keyboard " "
     telega-symbol-leave-comment " "
     telega-symbol-lightning " "
     telega-symbol-location " "
     telega-symbol-lock " "
     telega-symbol-member " "
     telega-symbol-mode "󰧀 "
     telega-symbol-online-status ""
     telega-symbol-outline-close "󰍟"
     telega-symbol-outline-open "󰍝"
     telega-symbol-pause ""
     telega-symbol-pending "󰔟 "
     telega-symbol-phone " "
     telega-symbol-photo " "
     telega-symbol-pin " "
     telega-symbol-play ""
     telega-symbol-poll ""
     telega-symbol-premium " "
     telega-symbol-reaction " "
     telega-symbol-reaction-mark " "
     telega-symbol-reply " "
     telega-symbol-right-arrow "󰧂 "
     telega-symbol-star "󰓎 "
     telega-symbol-story " "
     telega-symbol-story-reply (compose-chars ? ?)
     telega-symbol-telegram " "
     telega-symbol-telegram-star (propertize "󰓎" 'face '(:foreground "goldenrod"))
     telega-symbol-timer-clock "󰔛 "
     telega-symbol-verified " "
     telega-symbol-video "󰯜 "
     telega-symbol-video-chat-active "󰯜 "
     telega-symbol-video-chat-passive "󰯛 "
     telega-symbol-folder "󰉖 "
     telega-symbol-multiple-folders "󰉕 "
     telega-symbol-checkmark "󰄬"
     telega-symbol-heavy-checkmark "󰄭"
     telega-symbol-checkbox-on ""
     telega-symbol-checkbox-off ""
     telega-symbol-radiobox-on "󰝥"
     telega-symbol-radiobox-off "󰝦"
     telega-symbol-poll-options (list "󰝦" "󰝥")
     telega-symbol-poll-multiple-options (list "󰄱" "󰱒")
     telega-symbol-dice-list (list "󱅊" "󰇊" "󰇋" "󰇌" "󰇍" "󰇎" "󰇏")
     telega-folder-icons-alist
     '(("All"      . "󰻞 ")
       ("Airplane" . " ")
       ("Art"      . "󰸌 ")
       ("Book"     . " ")
       ("Bots"     . " ")
       ("Cat"      . "󰄛 ")
       ("Channels" . " ")
       ("Code"     . " ")
       ("Crown"    . "󱇐 ")
       ("Favorite" . " ")
       ("Flower"   . "󰉊 ")
       ("Game"     . " ")
       ("Groups"   . "󰭘 ")
       ("Home"     . " ")
       ("Like"     . " ")
       ("Love"     . " ")
       ("Mask"     . "󰴂 ")
       ("Money"    . " ")
       ("Note"     . "󰺿 ")
       ("Party"    . " ")
       ("Private"  . " ")
       ("Setup"    . " ")
       ("Sport"    . "󱅝 ")
       ("Study"    . " ")
       ("Tech"     . " ")
       ("Trade"    . "󰄨 ")
       ("Travel"   . " ")
       ("Unmuted"  . " ")
       ("Unread"   . " ")
       ("Work"     . " ")))))

(map! (:leader
       (:prefix ("A" . "app")
        :desc "Telega" :n "t" telega-prefix-map)))

(map! :map telega-msg-button-map
      "SPC" nil)

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

(use-package! telega-dired-dwim :after-call telega)

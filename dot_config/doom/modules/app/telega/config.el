;;; app/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :hook ((telega-load . telega-appindicator-mode)
         (telega-load . telega-mode-line-mode)
         (telega-load . telega-autoplay-mode)
         (telega-chat-mode . turn-off-smartparens-mode)
         (telega-chat-mode . telega-completions-setup-capf)
         (telega-chat-mode . doom-disable-show-paren-mode-h))
  :init
  (setopt telega-directory    (concat (getenv "XDG_DATA_HOME")  "/telega")
          telega-database-dir (concat (getenv "XDG_DATA_HOME")  "/telega/db")
          telega-cache-dir    (concat (getenv "XDG_CACHE_HOME") "/telega/cache")
          telega-temp-dir     (concat (getenv "XDG_CACHE_HOME") "/telega/temp"))
  :config
  (setopt telega-server-libs-prefix "/usr")
  (setopt telega-msg-save-dir (concat (xdg-user-dir "DOWNLOAD") "/telega"))
  (setopt telega-root-default-view-function 'telega-view-folders)
  (setopt telega-translate-to-language-by-default "ru")
  (setopt telega-chat-show-deleted-messages-for '(not saved-messages))
  (setopt telega-chat-input-markups '("org" "markdown2"))
  (setopt telega-sticker-size '(8 . 26))
  (setopt telega-use-images t)
  (setopt telega-animation-play-inline 60)

  (setopt telega-video-player-command (cond ((executable-find "mpv")
                                             '(concat "mpv"
                                               (when telega-ffplay-media-timestamp
                                                 (format " --start=%f" telega-ffplay-media-timestamp))
                                               (when telega-video-play-incrementally
                                                 " --cache=no")))
                                            ((executable-find "ffplay")
                                             '(concat "ffplay -autoexit"
                                               (when telega-ffplay-media-timestamp
                                                 (format " -ss %f" telega-ffplay-media-timestamp))))))

  (when (executable-find "tgs2png")
    (setopt telega-sticker-animated-play t))

  (setopt telega-known-inline-bots (append telega-known-inline-bots
                                           '("@vid" "@hbvidbot" "@hlebashbot" "@wiki" "@foursquare")))

  (setopt telega-filter-button-width '(0.10 10 20))

  (setopt telega-filters-custom '(("Main" . main)
                                  ("lng_filters_type_no_archived" . archive)))

  (setopt telega-date-format-alist '((today          . "%I:%M %p ")
                                     (this-week      . "%I:%M %p ")
                                     (old            . "%d.%m.%y ")
                                     (date           . "%d.%m.%y")
                                     (time           . "%I:%M %p")
                                     (date-time      . "%d.%m.%y %a %I:%M %p")
                                     (date-long      . "%d %B %Y")
                                     (date-break-bar . "%d %B %Y %a")))

  ;; TODO: Use 'setopt' after issue will be closed.
  ;; https://github.com/zevlg/telega.el/issues/547
  (setq telega-builtin-palettes-alist
        `((light
           ((:outline "#cc241d") (:foreground "#bb3e06")     (:background ,(doom-color 'bg)))
           ((:outline "#d65d0e") (:foreground "DarkOrange3") (:background ,(doom-color 'bg)))
           ((:outline "#897ea6") (:foreground "purple3")     (:background ,(doom-color 'bg)))
           ((:outline "#98971a") (:foreground "#98971a")     (:background ,(doom-color 'bg)))
           ((:outline "#689d6a") (:foreground "cyan4")       (:background ,(doom-color 'bg)))
           ((:outline "#458588") (:foreground "#458588")     (:background ,(doom-color 'bg)))
           ((:outline "#b16286") (:foreground "DeepPink3")   (:background ,(doom-color 'bg))))
          (dark
           ((:outline "#fb4934") (:foreground "#cc241d")     (:background ,(doom-color 'bg)))
           ((:outline "#fe8019") (:foreground "DarkOrange2") (:background ,(doom-color 'bg)))
           ((:outline "#d3869b") (:foreground "violet")      (:background ,(doom-color 'bg)))
           ((:outline "#b8bb26") (:foreground "#b8bb26")     (:background ,(doom-color 'bg)))
           ((:outline "#8ec07c") (:foreground "cyan3")       (:background ,(doom-color 'bg)))
           ((:outline "#83a598") (:foreground "#83a598")     (:background ,(doom-color 'bg)))
           ((:outline "#d3869b") (:foreground "#d3869b")     (:background ,(doom-color 'bg))))))

  (custom-set-faces!
    `(telega-msg-heading :background ,(doom-color 'base3) :extend t)
    '(telega-entity-type-code :inherit font-lock-number-face))

  (setopt telega-chat-header-line-format
          '((:eval (telega-chatbuf-header-concat
                    " " (telega-chatbuf-header-msg-filter)))
            (:eval (telega-chatbuf-header-concat
                    " " (telega-chatbuf-header-preview-mode)))
            (:eval (telega-chatbuf-header-concat
                    " " (telega-chatbuf-header-highlight-text)))
            (:eval (telega-mode-line-align
                    'center
                    (telega-chatbuf-header-concat
                     " " (telega-chatbuf-header-messages-count))
                    telega-chat-fill-column))
            (:eval (telega-mode-line-align
                    'right
                    (telega-chatbuf-header-concat
                     " " (telega-chatbuf-header-topic 30))
                    telega-chat-fill-column))))

  (when (modulep! +icons)
    ;; Unified function to get icons with padding and color
    (cl-defun fr/telega-icon (name &key color left-pad right-pad)
      "Return Nerd icon string with optional face and spaces."
      (let* ((set-name (progn (string-match "\\`nf-\\([a-z]+\\)-" name) (match-string 1 name)))
             (icon-set-name
              (cond
               ((member set-name '("md")) "mdicon")
               ((member set-name '("fa" "fae")) "faicon")
               ((member set-name '("cod")) "codicon")
               ((member set-name '("weather")) "wicon")
               ((member set-name '("oct")) "octicon")
               ((member set-name '("linux")) "flicon")
               ((member set-name '("seti" "custom")) "sucicon")
               ((member set-name '("pl" "ple" "pom")) "pomicon")
               ((member set-name '("iec")) "ipsicon")
               ((member set-name '("dev")) "devicon")))
             (icon-func (intern (concat "nerd-icons-" icon-set-name)))
             (icon (if color
                       (funcall icon-func name :face color)
                     (funcall icon-func name))))
        (when left-pad (setq icon (concat " " icon)))
        (when right-pad (setq icon (concat icon " ")))
        icon))

    (setopt telega-emoji-use-images nil)

    (setopt telega-symbols-emojify
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
                       :initial-value telega-symbols-emojify))

    (setopt telega-chat-prompt-insexp
            '(telega-ins--with-face (unless (telega-chatbuf-match-p 'can-send-or-post)
                                      'telega-shadow)
               (telega-chatbuf-prompt-ins-default-sender-avatar)
               (telega-chatbuf-prompt-ins-body)
               (when (or (telega-chatbuf-match-p 'has-default-sender)
                         (telega-chatbuf-match-p 'can-send-or-post))
                 (telega-chatbuf-prompt-ins-chat-avatar))
               (telega-chatbuf-prompt-ins-topic 20 t)
               (telega-auto-translate--chatbuf-prompt-ins-translation)
               (telega-ins (fr/telega-icon "nf-fa-angle_right" :left-pad t :right-pad t)))) ; 

    (setopt telega-symbol-alarm                 (fr/telega-icon "nf-md-alarm_light_outline" :right-pad t) ; 󰯪
            telega-symbol-attachment            (fr/telega-icon "nf-md-attachment") ; 󰁦
            telega-symbol-audio                 (fr/telega-icon "nf-seti-audio") ; 
            telega-symbol-author-hidden         (fr/telega-icon "nf-fa-user_secret" :right-pad t) ; 
            telega-symbol-bell                  (fr/telega-icon "nf-oct-bell" :right-pad t) ; 
            telega-symbol-blocked               (fr/telega-icon "nf-md-block_helper" :color 'error)
            telega-symbol-boost                 (fr/telega-icon "nf-oct-rocket" :right-pad t) ; 
            telega-symbol-bulp                  (fr/telega-icon "nf-fa-lightbulb" :right-pad t) ; 
            telega-symbol-button-close          (fr/telega-icon "nf-md-close_box_outline") ; 󰅘
            telega-symbol-chat-list             (fr/telega-icon "nf-fa-comments_o" :right-pad t) ; 
            telega-symbol-checklist             (fr/telega-icon "nf-fa-tasks" :right-pad t) ; 
            telega-symbol-circle                (fr/telega-icon "nf-fa-circle_o") ; 
            telega-symbol-codeblock             (fr/telega-icon "nf-fa-code") ; 
            telega-symbol-contact               (fr/telega-icon "nf-fa-user_o" :right-pad t) ; 
            telega-symbol-copyright             (fr/telega-icon "nf-fa-copyright") ; 
            telega-symbol-credit-card           (fr/telega-icon "nf-fa-credit_card_alt") ; 
            telega-symbol-direct-messages       (fr/telega-icon "nf-md-message_outline") ; 󰍥
            telega-symbol-distance              (fr/telega-icon "nf-fa-ruler" :right-pad t) ; 
            telega-symbol-eye                   (fr/telega-icon "nf-oct-eye" :left-pad t) ; 
            telega-symbol-failed                (fr/telega-icon "nf-fa-circle_exclamation" :color 'error) ; 
            telega-symbol-favorite              (fr/telega-icon "nf-fa-star_o") ; 
            telega-symbol-flames                (fr/telega-icon "nf-oct-flame") ; 
            telega-symbol-forum                 (fr/telega-icon "nf-md-forum_outline") ; 󰠢
            telega-symbol-forward               (fr/telega-icon "nf-fa-share") ; 
            telega-symbol-game                  (fr/telega-icon "nf-cod-game" :right-pad t) ; 
            telega-symbol-invoice               (fr/telega-icon "nf-md-account_voice" :right-pad t) ; 󰗋
            telega-symbol-keyboard              (fr/telega-icon "nf-fa-keyboard" :right-pad t) ; 
            telega-symbol-leave-comment         (fr/telega-icon "nf-fa-comment_dots" :right-pad t) ; 
            telega-symbol-lightning             (fr/telega-icon "nf-fa-bolt" :right-pad t) ; 
            telega-symbol-location              (fr/telega-icon "nf-oct-location" :right-pad t) ; 
            telega-symbol-lock                  (fr/telega-icon "nf-oct-lock" :right-pad t) ; 
            telega-symbol-member                (fr/telega-icon "nf-fa-user_o" :right-pad t) ; 
            telega-symbol-mode                  ""
            telega-symbol-my-notes              (fr/telega-icon "nf-cod-notebook") ; 
            telega-symbol-menu                  (fr/telega-icon "nf-md-menu") ; 󰍜
            telega-symbol-online-status         (fr/telega-icon "nf-oct-dot_fill") ; 
            telega-symbol-outline-close         (fr/telega-icon "nf-md-menu_right") ; 󰍟
            telega-symbol-outline-open          (fr/telega-icon "nf-md-menu_down") ; 󰍝
            telega-symbol-pause                 (fr/telega-icon "nf-fa-pause_circle_o") ; 
            telega-symbol-pending               (fr/telega-icon "nf-md-timer_sand") ; 󰔟
            telega-symbol-phone                 (fr/telega-icon "nf-fa-phone" :right-pad t) ; 
            telega-symbol-photo                 (fr/telega-icon "nf-fa-image") ; 
            telega-symbol-pin                   (fr/telega-icon "nf-oct-pin" :color 'telega-shadow) ; 
            telega-symbol-play                  (fr/telega-icon "nf-oct-play") ; 
            telega-symbol-poll                  (fr/telega-icon "nf-fa-square_poll_horizontal") ; 
            telega-symbol-premium               (fr/telega-icon "nf-md-star_face" :left-pad t :color 'telega-blue) ; 󰦥
            telega-symbol-reaction              (fr/telega-icon "nf-cod-reactions") ; 
            telega-symbol-reaction-mark         (fr/telega-icon "nf-cod-reactions") ; 
            telega-symbol-reply                 (fr/telega-icon "nf-fa-reply") ; 
            telega-symbol-reply-quote           (concat (fr/telega-icon "nf-fa-reply") (fr/telega-icon "nf-fa-quote_right")) ; 
            telega-symbol-right-arrow           (fr/telega-icon "nf-fa-angles_right" :left-pad t :right-pad t) ; 
            telega-symbol-star                  (fr/telega-icon "nf-md-star" :color 'error) ; 󰓎
            telega-symbol-story                 (fr/telega-icon "nf-fa-circle") ; 
            telega-symbol-story-reply           (concat (fr/telega-icon "nf-fa-circle") (fr/telega-icon "nf-fa-reply")) ; 
            telega-symbol-telegram              (fr/telega-icon "nf-fae-telegram" :right-pad t :color '(italic telega-blue)) ; 
            telega-symbol-telegram-star         (fr/telega-icon "nf-md-star" :color '(:foreground "goldenrod")) ; 󰓎
            telega-symbol-timer-clock           (fr/telega-icon "nf-md-timer_outline" :right-pad t) ; 󰔛
            telega-symbol-topic                 " #"
            telega-symbol-typing                (fr/telega-icon "nf-fa-pen") ; 
            telega-symbol-verified              (fr/telega-icon "nf-cod-verified_filled" :right-pad t :color 'telega-blue) ; 
            telega-symbol-video                 (fr/telega-icon "nf-oct-video") ; 
            telega-symbol-video-chat            (fr/telega-icon "nf-md-video_outline") ; 󰯜
            telega-symbol-video-chat-active     (fr/telega-icon "nf-md-video_outline" :color 'success) ; 󰯜
            telega-symbol-video-chat-passive    (fr/telega-icon "nf-md-video_off_outline" :color 'telega-shadow) ; 󰯛
            telega-symbol-horizontal-bar        "─"
            telega-symbol-vertical-bar          "│"
            telega-symbol-folder                (fr/telega-icon "nf-md-folder_outline" :right-pad t) ; 󰉖
            telega-symbol-multiple-folders      (fr/telega-icon "nf-md-folder_multiple_outline" :right-pad t) ; 󰉕
            telega-symbol-checkmark             (fr/telega-icon "nf-md-check") ; 󰄬
            telega-symbol-heavy-checkmark       (fr/telega-icon "nf-md-check_all") ; 󰄭
            telega-symbol-checkbox-on           (fr/telega-icon "nf-oct-checkbox") ; 
            telega-symbol-checkbox-off          (fr/telega-icon "nf-seti-checkbox_unchecked") ; 
            telega-symbol-radiobox-on           (fr/telega-icon "nf-fa-circle") ; 
            telega-symbol-radiobox-off          (fr/telega-icon "nf-fa-circle_o") ; 
            telega-symbol-poll-options          (list (fr/telega-icon "nf-fa-circle_o") ; 
                                                      (fr/telega-icon "nf-fa-circle")) ; 
            telega-symbol-poll-multiple-options (list (fr/telega-icon "nf-seti-checkbox_unchecked") ; 
                                                      (fr/telega-icon "nf-oct-checkbox")) ; 
            telega-symbol-dice-list             (list (fr/telega-icon "nf-fa-dice") ; 
                                                      (fr/telega-icon "nf-md-dice_1") ; 󰇊
                                                      (fr/telega-icon "nf-md-dice_2") ; 󰇋
                                                      (fr/telega-icon "nf-md-dice_3") ; 󰇌
                                                      (fr/telega-icon "nf-md-dice_4") ; 󰇍
                                                      (fr/telega-icon "nf-md-dice_5") ; 󰇎
                                                      (fr/telega-icon "nf-md-dice_6")) ; 󰇏
            telega-folder-icons-alist `(("Airplane" . ,(fr/telega-icon "nf-fae-telegram" :right-pad t)) ; 
                                        ("All"      . ,(fr/telega-icon "nf-md-chat_outline" :right-pad t)) ; 󰻞
                                        ("Book"     . ,(fr/telega-icon "nf-fa-book" :right-pad t)) ; 
                                        ("Bots"     . ,(fr/telega-icon "nf-fa-robot" :right-pad t)) ; 
                                        ("Cat"      . ,(fr/telega-icon "nf-md-cat" :right-pad t)) ; 󰄛
                                        ("Channels" . ,(fr/telega-icon "nf-oct-megaphone" :right-pad t)) ; 
                                        ("Crown"    . ,(fr/telega-icon "nf-md-crown_outline" :right-pad t)) ; 󱇐
                                        ("Custom"   . ,(fr/telega-icon "nf-md-folder_outline" :right-pad t)) ; 󰉖
                                        ("Favorite" . ,(fr/telega-icon "nf-fa-star" :right-pad t)) ; 
                                        ("Flower"   . ,(fr/telega-icon "nf-md-flower" :right-pad t)) ; 󰉊
                                        ("Game"     . ,(fr/telega-icon "nf-cod-game" :right-pad t)) ; 
                                        ("Groups"   . ,(fr/telega-icon "nf-md-account_group_outline" :right-pad t)) ; 󰭘
                                        ("Home"     . ,(fr/telega-icon "nf-cod-home" :right-pad t)) ; 
                                        ("Light"    . ,(fr/telega-icon "nf-fa-lightbulb" :right-pad t)) ; 
                                        ("Like"     . ,(fr/telega-icon "nf-oct-thumbsup" :right-pad t)) ; 
                                        ("Love"     . ,(fr/telega-icon "nf-fa-heard_o" :right-pad t)) ; 
                                        ("Mask"     . ,(fr/telega-icon "nf-md-drama_masks" :right-pad t)) ; 󰴂
                                        ("Money"    . ,(fr/telega-icon "nf-fa-money_bill_1_wave" :right-pad t)) ; 
                                        ("Note"     . ,(fr/telega-icon "nf-md-notebook_outline" :right-pad t)) ; 󰺿
                                        ("Palette"  . ,(fr/telega-icon "nf-md-palette_outline" :right-pad t)) ; 󰸌
                                        ("Party"    . ,(fr/telega-icon "nf-fa-champagne_glasses" :right-pad t)) ; 
                                        ("Private"  . ,(fr/telega-icon "nf-fa-user_o" :right-pad t)) ; 
                                        ("Setup"    . ,(fr/telega-icon "nf-md-clipboard_text_outline" :right-pad t)) ; 󰨸
                                        ("Sport"    . ,(fr/telega-icon "nf-md-weight_lifter" :right-pad t)) ; 󱅝
                                        ("Study"    . ,(fr/telega-icon "nf-fa-graduation_cap" :right-pad t)) ; 
                                        ("Trade"    . ,(fr/telega-icon "nf-md-chart_bar" :right-pad t)) ; 󰄨
                                        ("Travel"   . ,(fr/telega-icon "nf-fa-suitcase" :right-pad t)) ; 
                                        ("Unmuted"  . ,(fr/telega-icon "nf-oct-bell" :right-pad t)) ; 
                                        ("Unread"   . ,(fr/telega-icon "nf-oct-checkbox" :right-pad t)) ; 
                                        ("Work"     . ,(fr/telega-icon "nf-fa-briefcase" :right-pad t)))) ; 

    (setq telega-chat-preview-mode-lighter
          (concat " " (telega-symbol 'mode) "Preview"))
    (setq telega-edit-file-mode-lighter
          (concat " " (telega-symbol 'mode) "Edit"))
    (setq telega-auto-translate-mode-lighter
          (concat " " (telega-symbol 'mode) "Translate"))
    (setq telega-chat-auto-fill-mode-lighter
          (concat " " (telega-symbol 'mode) "Auto-Fill"))
    (setq telega-highlight-text-mode-lighter
          (concat " " (telega-symbol 'mode) "Highlight"))
    (setq telega-squash-message-mode-lighter
          (concat " " (telega-symbol 'mode) "Squash"))
    (setq telega-play-media-sequence-mode-lighter
          (concat " " (telega-symbol 'mode) "Media Sequence"))
    (when (modulep! +mnz)
      (after! telega-mnz
        (setq telega-mnz-mode-lighter
              (concat " " (telega-symbol 'mode) "Mnz")))))

  ;; INFO: Redesign, make topic icon optional.
  (defadvice! fr/telega-chatbuf-prompt-ins-topic (&optional max-width with-topic-icon-p)
    "Inserter for the current topic in the chatbuf's input prompt."
    :override #'telega-chatbuf-prompt-ins-topic
    (telega-chatbuf--dirtiness-init "topic")

    (when (telega-topic-match-p telega-chatbuf--topic
            '(type forum sm dm))
      (telega-ins--with-attrs (list :max max-width :align 'left :elide t
                                    :face 'telega-shadow)
        (telega-ins (telega-symbol 'topic))
        (telega-ins--topic-title telega-chatbuf--topic
          :with-icon-p with-topic-icon-p
          :with-maybe-pin-p t))))

  ;; INFO: Redesign, make topic icon optional.
  (defadvice! fr/telega-chatbuf-header-topic (&optional max-width with-topic-icon-p)
    "Formatter for the chatbuf's topic or messages thread."
    :override #'telega-chatbuf-header-topic
    (telega-chatbuf--dirtiness-init "topic")

    (when telega-chatbuf--topic
      (telega-ins--as-string
       (telega-ins--with-attrs (list :max (or max-width 40) :align 'left :elide t)
         (if (telega-topic-match-p telega-chatbuf--topic '(type thread))
             (progn
               (telega-ins--with-face 'telega-shadow
                 (telega-ins (telega-symbol 'reply)))
               (telega-ins--content-one-line (telega-chatbuf--topic-thread-msg)))
           (telega-ins (telega-symbol 'topic))
           (telega-ins--topic-title telega-chatbuf--topic
             :with-icon-p with-topic-icon-p
             :with-maybe-pin-p t))))))

  ;; INFO: Redesign topic.
  (defadvice! fr/telega-ins--message-header (msg &optional msg-chat msg-sender
                                                 addon-inserter)
    "Insert message's MSG header, everything except for message content.
MSG-CHAT - Chat for which to insert message header.
MSG-SENDER - Sender of the message.
If ADDON-INSERTER function is specified, it is called with one
argument - MSG to insert additional information after header."
    :override #'telega-ins--message-header
    (let* ((date-and-status
            (when (eq telega-msg-heading-trail 'date-and-status)
              (telega-ins--as-string
               (telega-ins--message-date-and-status msg))))
           (dwidth (- telega-chat-fill-column
                      (if (stringp date-and-status)
                          (string-width date-and-status)
                        0)))
           (chat (or msg-chat (telega-msg-chat msg)))
           (sender (or msg-sender (telega-msg-sender msg)))
           (telega-palette-context 'msg-header)
           (palette (telega-msg-sender-palette sender)))
      (cl-assert sender)
      (telega-ins--with-props
          (list 'action (lambda (button)
                          ;; NOTE: check for custom message :action first
                          ;; - [RESEND] button uses :action
                          ;; - via @bot link uses :action
                          (or (telega-button--action button)
                              (telega-describe-msg-sender sender))))
        (telega-ins--with-face
            (telega-face-with-palette 'telega-msg-heading palette :background)
          (telega-ins--with-attrs (list :max (- dwidth (telega-current-column))
                                        :align 'left
                                        :elide t
                                        :elide-trail 20)
            ;; NOTE: if channel post has a signature, then use it instead
            ;; of username to shorten message header
            (let ((signature (telega-tl-str msg :author_signature)))
              (telega-ins--msg-sender sender
                :with-username-p (not signature))
              (when signature
                (telega-ins--with-face (telega-msg-sender-title-faces sender)
                  (telega-ins " --" signature))))

            ;; Admin badge if any
            (when (telega-user-p sender)
              (when-let ((admin (telega-chat-admin-get chat sender)))
                (telega-ins--with-face 'telega-shadow
                  (telega-ins " ("
                              (or (telega-tl-str admin :custom_title)
                                  (if (plist-get admin :is_owner)
                                      (telega-i18n "lng_owner_badge")
                                    (telega-i18n "lng_admin_badge")))
                              ")"))))

            ;; Sender's boost count
            (let ((boost-count (plist-get msg :sender_boost_count)))
              (unless (telega-zerop boost-count)
                (telega-ins--with-face (assq :foreground palette)
                  (telega-ins " " (telega-symbol 'boost))
                  (when (> boost-count 1)
                    (telega-ins-fmt "%d" boost-count)))))

            ;; Paid stars
            (let ((paid-stars (plist-get msg :paid_message_star_count)))
              (unless (telega-zerop paid-stars)
                (telega-ins " " (telega-symbol 'telegram-star))
                (telega-ins-fmt "%d" paid-stars)))

            ;; via <bot>
            (when-let* ((via-bot-user-id (plist-get msg :via_bot_user_id))
                        (via-bot (unless (zerop via-bot-user-id)
                                   (telega-user-get via-bot-user-id)))
                        (bot-title (telega-ins--as-string
                                    ;; Use custom :action for clickable @bot link
                                    (telega-ins--text-button
                                        (telega-user-title via-bot 'username)
                                      'face 'telega-username
                                      :action (lambda (_msg_ignored)
                                                (telega-describe-user via-bot))))))
              (telega-ins " " (telega-i18n "lng_inline_bot_via"
                                :inline_bot bot-title)))

            ;; Edited date
            (let ((edited-date (plist-get msg :edit_date)))
              (unless (zerop edited-date)
                (telega-ins--with-face 'telega-shadow
                  (telega-ins " " (telega-i18n "lng_edited") " ")
                  (telega-ins--date (plist-get msg :edit_date)))))

            ;; Interaction info
            (telega-ins--msg-interaction-info msg chat)

            (when-let ((fav (telega-msg-favorite-p msg)))
              (telega-ins " " (telega-symbol 'favorite))
              ;; Also show comment to the favorite message
              (telega-ins--with-face 'telega-shadow
                (telega-ins-prefix "("
                  (when (telega-ins (plist-get fav :comment))
                    (telega-ins ")")))))

            ;; Maybe pinned message?
            (when (plist-get msg :is_pinned)
              (telega-ins " " (telega-symbol 'pin)))

            ;; message auto-deletion time
            (let ((auto-delete-in (plist-get msg :auto_delete_in)))
              (unless (telega-zerop auto-delete-in)
                (telega-ins " " (telega-symbol 'flames)
                            (telega-duration-human-readable auto-delete-in 1))))

            ;; AI summary
            (when (plist-get msg :summary_language_code)
              (telega-ins " ")
              (telega-ins--text-button
                  (if (plist-get msg :telega-summary)
                      (telega-symbol 'summarize-out)
                    (telega-symbol 'summarize-in))
                'face 'telega-link
                'help-echo (if (plist-get msg :telega-summary)
                               "Disable AI summary"
                             "Enable AI summary")
                :action #'telega-msg-summarize))

            (when (numberp telega-debug)
              (telega-ins-fmt " (ID=%d)" (plist-get msg :id)))

            ;; Resend button in case message sent failed
            ;; Use custom :action to resend message
            (when-let ((send-state (plist-get msg :sending_state)))
              (when (and (eq (telega--tl-type send-state)
                             'messageSendingStateFailed)
                         (plist-get send-state :can_retry))
                (telega-ins " ")
                (telega-ins--box-button "RESEND"
                  :action #'telega-msg-resend)))

            (when addon-inserter
              (cl-assert (functionp addon-inserter))
              (funcall addon-inserter msg))

            ;; Message's topic aligned to the right
            (when-let* ((topic (telega-msg-topic msg))
                        (show-topic-p
                         (telega-msg-match-p msg telega-msg-temex-show-topic))
                        (topic-title (telega-ins--as-string
                                      (telega-ins (telega-symbol 'topic))
                                      (telega-ins--topic-title topic
                                        :with-icon-p t
                                        :with-maybe-pin-p t))))
              (telega-ins--move-to-column
               (- dwidth (string-width topic-title)))
              (telega-ins--with-props
                  (list 'face 'telega-topic-button
                        :action #'telega-msg-show-topic-info
                        :help-echo "Show topic info")
                (telega-ins topic-title))))

          (when telega-msg-heading-trail
            (telega-ins--move-to-column dwidth))
          (telega-ins date-and-status)

          (telega-ins "\n")))))

  ;; TODO: Adjust when debug message will be deleted.
  ;; INFO: Disable debug message.
  (defadvice! fixed-telega--on-updateSuggestedActions (event)
    :override #'telega--on-updateSuggestedActions
    (let ((added-actions (append (plist-get event :added_actions) nil))
          (removed-actions (append (plist-get event :removed_actions) nil)))
      (setq telega--suggested-actions
            (append (seq-difference telega--suggested-actions removed-actions
                                    #'equal)
                    added-actions))))

  ;; INFO: Add space after vertical bar in folder prefix.
  (defun fr/telega-folders-insert-personalized (&optional fmt-spec)
    "Frestein's inserter for the folders prefixing chat's title."
    (let ((fmt-spec (or fmt-spec (eval-when-compile
                                   (propertize "%F" 'face 'bold)))))
      (if telega-tdlib--folder-tags-enabled-p
          (telega-folders-insert-as-tags fmt-spec telega-chat-folders)
        (when (cond ((> (length telega-chat-folders) 1)
                     (telega-ins (telega-symbol 'multiple-folders)))
                    (telega-chat-folders
                     (telega-ins (telega-folder-format
                                  fmt-spec (car telega-chat-folders)))))
          (telega-ins (concat (telega-symbol 'vertical-bar) " "))))))

  (setopt telega-chat-folders-insexp 'fr/telega-folders-insert-personalized)

  ;; INFO: Override default notification logic.
  ;; Many thanks - tychoish!
  ;; https://github.com/tychoish/.emacs.d/blob/bc32c80e53f0bc4ad7655871ee4672ff31693b77/lisp/tychoish-core.el#L1267
  (defun fr/telega--chat-observable-p (msg)
    "Return non-nil if CHAT is observable."
    (let ((chat (telega-msg-chat msg)))
      (with-telega-chatbuf chat
        (and (telega-chatbuf--msg-observable-p msg)
             (not (telega-chatbuf--history-state-get :newer-freezed))))))

  (defun fr/telega-notifications-msg-notify-p (msg)
    "Return non-nil if message MSG should pop-up notification."
    (let* ((chat (telega-msg-chat msg))
           (title (plist-get chat :title)))
      (cond
       ;; Chat window is open and viable: skip
       ((fr/telega--chat-observable-p msg)
        (progn (telega-debug "NOTIFY-CHECK: observed chat [%s], skip notify" title) nil))

       ;; If it's muted: skip
       ((telega-chat-muted-p chat)
        (progn (telega-debug "NOTIFY-CHECK: muted chat [%s], skip notify" title) nil))

       ;; For group chats where I am not a member: skip
       ((telega-chat-match-p chat '(and (type basicgroup supergroup channel) (not me-is-member)))
        (progn (telega-debug "NOTIFY-CHECK: group chat where I am not a member [%s], skip notify" title) nil))

       ;; Message I sent (from another device): skip
       ((telega-msg-match-p msg '(sender me))
        (progn (telega-debug "NOTIFY-CHECK: message I sent [%s], skip notify" title) nil))

       ;; Message that is a mention but notification of mentions are disabled: skip
       ((and (plist-get msg :contains_unread_mention)
             (telega-chat-notification-setting chat :disable_mention_notifications))
        (progn (telega-debug "NOTIFY-CHECK: contains a mention [%s], skip notify" title) nil))

       ;; For chats that are DM, secret or bots: notify
       ((telega-chat-match-p chat '(or (type private secret bot)))
        (progn (telega-debug "NOTIFY-CHECK: is DM or BOT [%s], can notify" title) t))

       ;; For groups where I am a member: notify
       ((telega-chat-match-p chat 'me-is-member)
        (progn (telega-debug "NOTIFY-CHECK: member of a group [%s], can notify" title) t))

       ;; Otherwise notify anyway with a warning message
       (t
        (progn (message (format "TELEGA-NOTIFY: unexpected message [%s], notifying anyway" title)) t)))))

  (setopt telega-notifications-msg-temex 'fr/telega-notifications-msg-notify-p)

  ;; WARN: TOS violation. Block sponsored messages.
  ;; sponsored - Fetch messages but don't draw them.
  ;; sponsored2 - Don't fetch messages.
  (when (or (modulep! +sponsored) (modulep! +sponsored2))
    (setopt telega-inserter-for-sponsored-msg-button #'ignore)

    (defadvice! fr/telega-chatbuf--sponsored-messages-fetch-without-display ()
      "Asynchronously fetch sponsored messages for the chatbuf without displaying them."
      :override #'telega-chatbuf--sponsored-messages-fetch
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

  (defun fr/telega-video-play-incementally-mode ()
    "Toggle telega video play incrementally mode."
    (interactive)
    (setopt telega-video-play-incrementally (not telega-video-play-incrementally))
    (if telega-video-play-incrementally
        (message "Telega-Video-Play-Incrementally mode enabled")
      (message "Telega-Video-Play-Incrementally mode disabled")))

  (defun fr/telega-debug-mode ()
    "Toggle telega debug mode."
    (interactive)
    (setopt telega-debug (not telega-debug))
    (if telega-debug
        (message "Telega-Debug mode enabled")
      (message "Telega-Debug mode disabled")))

  (defun fr/telega-chatbuf-inline-bot-choose ()
    "Select an inline bot from telega-known-inline-bots and insert it."
    (interactive)
    (let ((bot (completing-read "Choose inline bot: " telega-known-inline-bots nil t)))
      (when bot
        (insert bot))))

  (defun fr/telega-format--apply (entity-type)
    "Apply ENTITY-TYPE to region or word at point."
    (let ((bounds (if (use-region-p)
                      (cons (region-beginning) (region-end))
                    (bounds-of-thing-at-point 'symbol))))
      (unless bounds
        (user-error "No active region and no word at point"))
      (telega-chatbuf-input-formatting-set (car bounds) (cdr bounds) entity-type)))

  (defmacro fr/telega-format-define-command (name type &optional url-prompt)
    "Define interactive command NAME that applies TYPE formatting.
If URL-PROMPT is non-nil, TYPE is treated as base type for link and prompts for URL."
    `(defun ,(intern (concat "fr/telega-format-" name)) ()
       ,(format "Apply %s formatting to region or word." name)
       (interactive)
       (let ((entity-type ,(if url-prompt
                               `(list :@type ,type :url (read-string ,url-prompt))
                             type)))
         (fr/telega-format--apply entity-type))))

  (fr/telega-format-define-command "bold" '(:@type "textEntityTypeBold"))
  (fr/telega-format-define-command "italic" '(:@type "textEntityTypeItalic"))
  (fr/telega-format-define-command "underline" '(:@type "textEntityTypeUnderline"))
  (fr/telega-format-define-command "strikethrough" '(:@type "textEntityTypeStrikethrough"))
  (fr/telega-format-define-command "spoiler" '(:@type "textEntityTypeSpoiler"))
  (fr/telega-format-define-command "monospace" '(:@type "textEntityTypePre"))
  (fr/telega-format-define-command "quote" '(:@type "textEntityTypeBlockQuote"))
  (fr/telega-format-define-command "link" "textEntityTypeTextUrl" "URL: ")

  (defun fr/telega-format-clear ()
    "Clear formatting from region or word."
    (interactive)
    (fr/telega-format--apply nil))

  (defun fr/telega-chatbuf-cancel-dwim ()
    "Cancel both the active filter and thread in the Telega chat buffer."
    (interactive)
    (telega-chatbuf-filter-cancel)
    (telega-chatbuf-thread-cancel))

  ;; Initialize custom keybindings
  (if (modulep! :editor evil)
      (after! evil-collection
        (fr/telega--override-evil-collection-keys))
    (fr/telega--init-map-h))

  ;; Recognize Telegram links for browse-url
  (setq browse-url-handlers
        (append '(("\\`tg:" . telega-browse-url)
                  ("\\`tonsite:" . telega-browse-url))
                browse-url-handlers))

  (set-popup-rule! (lambda (buf-name _action)
                     (and (or (string-match-p "^\\*Telega" buf-name)
                              (string-match-p "^\\*Telegram" buf-name))
                          (not (string= buf-name "*Telega Root*"))
                          (not (string= buf-name "*Telegram Messages Preview*"))))
    :actions '(fr/+popup-display-dynamic-side) :height .5 :width .5 :ttl 0 :select t :modeline t)
  (set-popup-rule! (regexp-quote "*Telegram Messages Preview*")
    :actions '(fr/+popup-display-dynamic-side) :height .5 :width .5 :ttl 0 :modeline t)

  (define-abbrev! telega-chat-mode-abbrev-table
    "r34"            "Rule 34"
    "r63"            "Rule 63"
    "yt"             "YouTube"
    "linkedin"       "LinkedIn"
    "github"         "GitHub"
    "gitlab"         "GitLab"
    "sourcehut"      "SourceHut"
    "latex"          "LaTeX"
    "js"             "JavaScript"
    "ts"             "TypeScript"
    "elisp"          "Emacs Lisp"
    "clisp"          "Common Lisp"
    "yubikey"        "YubiKey"
    "cicd"           "CI/CD"
    "ebpf"           "eBPF"
    "ios"            "iOS"
    "macos"          "macOS"
    "cachyos"        "CachyOS"
    "nixos"          "NixOS")

  (abbrev-table-put telega-chat-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[:;_].*\\|.*\\)")

  (add-hook 'telega-chat-mode-hook #'abbrev-mode)

  (when (modulep! :editor aas)
    (aas-set-snippets 'telega-chat-mode
      "--" "—"
      "<<" "«"
      ">>" "»")

    (add-hook 'telega-chat-mode-hook #'aas-activate-for-major-mode)))

(when (modulep! +mnz)
  (use-package! telega-mnz
    :hook (telega-load  . global-telega-mnz-mode)
    :config
    (setopt telega-mnz-use-language-detection 32))

  (use-package! language-detection))

(use-package! telega-adblock
  :when (modulep! +adblock)
  :hook (telega-load  . telega-adblock-mode))

(use-package! telega-dired-dwim
  :when (modulep! :emacs dired)
  :after (dired telega))

(use-package! ol-telega
  :when (modulep! :lang org)
  :after (org telega)
  :config
  (add-to-list 'org-modules 'ol-telega))

(use-package! telega-url-shorten-nerd
  :when (modulep! +icons)
  :hook (telega-load  . global-telega-url-shorten-nerd-mode)
  :config
  (setopt telega-url-shorten-nerd-use-images nil))

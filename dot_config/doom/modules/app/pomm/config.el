;;; app/pomm/config.el -*- lexical-binding: t; -*-

(use-package pomm
  :hook (doom-after-init . pomm-mode-line-mode)
  :config
  (setq alert-default-style 'libnotify
        pomm-audio-player-executable (executable-find "mpv"))

  (define-minor-mode pomm-audio-mode
    "Global minor mode for toggling the pomodoro timer audio playback."
    :require 'pomm
    :group 'pomm
    :global t
    (setq pomm-audio-enabled (if pomm-audio-mode t nil)))

  ;; INFO: Correct notification title for third-time
  (defun pomm-third-time--dispatch-notification (kind)
    "Dispatch a notification about a start of a period.

KIND is the same as in `pomm-third-time--state'"
    (alert
     (pcase kind
       ('break (concat pomm-third-time-break-message
                       (format "\nTime available: %s"
                               (pomm-third-time--format-period
                                (pomm-third-time--break-time)))))
       ('work (concat pomm-work-message
                      (when (> (pomm-third-time--break-time) 0)
                        (format "\nBreak time remaining: %s"
                                (pomm-third-time--format-period
                                 (pomm-third-time--break-time)))))))
     :title "Third Time"))

  ;; INFO: correct mpv
  (defun pomm--maybe-play-sound (kind)
    (when pomm-audio-enabled
      (unless pomm-audio-player-executable
        (error "No audio player executable! Set 'pomm-audio-player-executable'")
        (setq pomm-audio-enabled nil))
      (when-let ((play-sound (or (not (eq 'tick kind)) pomm-audio-tick-enabled))
                 (sound (alist-get kind pomm-audio-files)))
        (let* ((cmd (split-string pomm-audio-player-executable))
               (prog (car cmd))
               (args (cdr cmd)))
          (when (string-match-p "mpv\\'" prog)
            (setq args (append '("--no-terminal" "--no-config" "--volume=35" "--speed=1.2") args)))
          (apply #'start-process
                 "pomm-audio-player" nil
                 prog
                 (append args (list sound))))))))

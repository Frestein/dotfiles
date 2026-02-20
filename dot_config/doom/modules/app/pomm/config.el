;;; app/pomm/config.el -*- lexical-binding: t; -*-

(use-package pomm
  :hook (doom-after-init . pomm-mode-line-mode)
  :config
  (after! alert
    (setq alert-default-style
          (if (executable-find "notify-send") 'libnotify 'notifications)))

  (setopt pomm-audio-player-executable (executable-find "mpv"))

  (define-minor-mode pomm-audio-mode
    "Global minor mode for toggling the pomodoro timer audio playback."
    :require 'pomm
    :group 'pomm
    :global t
    (setopt pomm-audio-enabled (if pomm-audio-mode t nil)))

  ;; INFO: MPV fix.
  (defadvice! fixed-pomm--maybe-play-sound (kind)
    "Play a sound of KIND.

KIND is a key of `pomm-audio-files'.  The variable
`pomm-audio-enabled' should be set to true, and the corresponding
value of the `pomm-audio-files' should be a path to the file
which can be played by `pomm-audio-player-executable'."
    :override #'pomm--maybe-play-sound
    (when pomm-audio-enabled
      (unless pomm-audio-player-executable
        (error "No audio player executable! Set 'pomm-audio-player-executable'")
        (setopt pomm-audio-enabled nil))
      (when-let* ((play-sound (or (not (eq 'tick kind)) pomm-audio-tick-enabled))
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

;;; app/telega/autoload/autostart.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/telega-server-running-p ()
  "Check if telega-server process is running."
  (not (string-empty-p (shell-command-to-string "pgrep -x telega-server"))))

;;;###autoload
(defun fr/start-telega-in-background ()
  "Start telega in background if its server process is not running.
Uses `doom-first-input' for daemon or `doom-after-init' otherwise."
  (unless (fr/telega-server-running-p)
    (if (daemonp)
        (add-hook! doom-first-input (telega 'no-popup))
      (add-hook! doom-after-init (telega 'no-popup)))))

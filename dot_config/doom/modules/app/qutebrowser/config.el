;;; app/qutebrowser/config.el -*- lexical-binding: t; -*-

(defun browse-url-qutebrowser-private (url &rest _)
  "Make qutebrowser open URL in private-browsing window."
  (interactive (browse-url-interactive-arg "Qutebrowser URL: "))
  (let ((process-environment (browse-url-process-environment)))
    (start-process "qutebrowser-private" nil
                   "qutebrowser" "--target" "private-window" url)))

(setq-default browse-url-generic-program (executable-find "qutebrowser"))

(use-package! qutebrowser
  :when (eq window-system 'x)
  :after exwm
  :custom
  (qutebrowser-launcher-backend #'qutebrowser-consult-launcher))

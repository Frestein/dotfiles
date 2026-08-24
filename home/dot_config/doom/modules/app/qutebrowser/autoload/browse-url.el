;;; app/qutebrowser/autoloads/browse-url.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +browse-url-qutebrowser-private (url &rest _)
  "Make `qutebrowser' open URL in private-browsing window."
  (interactive (browse-url-interactive-arg "Qutebrowser URL: "))
  (let ((process-environment (browse-url-process-environment)))
    (start-process "qutebrowser-private" nil
                   "qutebrowser" "--target" "private-window" url)))

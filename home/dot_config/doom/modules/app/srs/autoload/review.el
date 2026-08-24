;;; app/srs/autoload/review.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org-srs-review-start-org-directory ()
  "Start a review session for items located in the `org-directory'."
  (interactive)
  (org-srs-review-start org-directory))

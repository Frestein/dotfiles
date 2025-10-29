;;; app/srs/config.el -*- lexical-binding: t; -*-

(use-package org-srs
  :after org
  :config
  (defun org-srs-review-start-org-directory ()
    "Start a review session for items located in the org-directory."
    (interactive)
    (org-srs-review-start org-directory))

  (map! :map org-mode-map
        :localleader
        (:prefix ("S" . "srs")
                 (:prefix ("e" . "embed")
                          "d" #'org-srs-embed-dwim
                          "c" #'org-srs-embed-cloze-dwim
                          "C" #'org-srs-embed-uncloze-dwim)
                 (:prefix ("i" . "item")
                          "c" #'org-srs-item-cloze-dwim
                          "C" #'org-srs-item-uncloze-dwim
                          "n" #'org-srs-item-create)
                 (:prefix ("s" . "stats")
                          "r" #'org-srs-stats-history-reviews
                          "R" #'org-srs-stats-history-retentions
                          "i" #'org-srs-stats-history-review-items
                          "I" #'org-srs-stats-history-due-items)
                 (:prefix ("r" . "rate")
                          "a" #'org-srs-review-rate-again
                          "e" #'org-srs-review-rate-easy
                          "g" #'org-srs-review-rate-good
                          "h" #'org-srs-review-rate-hard)
                 (:prefix ("R" . "review")
                          "s" #'org-srs-review-start
                          "S" #'org-srs-review-suspend
                          "p" #'org-srs-review-postpone
                          "q" #'org-srs-review-quit))))

(use-package org-srs
  :after org
  :when (eq system-type 'android)
  :custom
  (org-srs-item-confirm #'org-srs-item-confirm-command)
  :config
  (org-srs-mouse-mode t))

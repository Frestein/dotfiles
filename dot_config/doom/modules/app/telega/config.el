;;; app/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :bind-keymap ("C-c t" . telega-prefix-map)
  :hook (telega-load . telega-appindicator-mode)
  :config
  (setq telega-server-libs-prefix "/usr")
  (setq telega-translate-to-language-by-default "ru"))

(map! (:leader
       (:prefix ("A" . "app")
        :desc "Telega" :n "t" telega-prefix-map)))

(use-package! telega-mnz
  :when (modulep! +mnz)
  :after-call telega
  :custom
  (global-telega-mnz-mode t)
  (telega-mnz-use-language-detection 32))

(use-package! language-detection
  :when (modulep! +mnz)
  ;; NOTE: The `language-detection-string' function is already autoloaded,
  ;; so we can safely defer it.
  :defer t)

;; TODO: WIP
;; (use-package telega-dashboard
;; :when (modulep! +dashboard)
;;   :after-call telega
;;   :config (add-to-list 'dashboard-items '(telega-chats . 5)))

(use-package! telega-stories
  :when (modulep! +stories)
  :after-call telega
  :bind (:map telega-root-mode-map
              ("v e" . telega-view-emacs-stories))
  :config (telega-stories-mode 1))

(use-package! telega-dired-dwim :after-call telega)

;;; app/telega/config.el -*- lexical-binding: t; -*-

(map! (:leader
       (:prefix ("A" . "app")
        (:when (modulep! :app telega)
         :desc "Telega" "t" telega-prefix-map))))

(use-package!
  telega
  :bind-keymap ("C-c t" . telega-prefix-map)
  :hook (telega-load . telega-appindicator-mode)
  :config
  (setq telega-server-libs-prefix "/usr")
  (setq telega-translate-to-language-by-default "ru"))

(use-package!
  telega-mnz
  :when (modulep! +mnz)
  :ensure nil
  :after telega
  :custom
  (global-telega-mnz-mode t)
  (telega-mnz-use-language-detection 32))

(use-package! language-detection
  :when (modulep! +mnz)
  ;; NOTE the `language-detection-string' function is already autoloaded,
  ;; so we can safely defer it.
  :defer t)

;; (use-package
;;   telega-dashboard
;;   :ensure nil
;;   :after telega
;;   :config (add-to-list 'dashboard-items '(telega-chats . 5)))

(use-package!
  telega-stories
  :when (modulep! +stories)
  :ensure nil
  :after telega
  :bind (:map telega-root-mode-map ("v e" . telega-view-emacs-stories))
  :config (telega-stories-mode 1))

(use-package! telega-dired-dwim :ensure nil :after telega)

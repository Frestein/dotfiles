;;; lang/typst/config.el -*- lexical-binding: t; -*-

(defun +typst-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("tinymist"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! typst-ts-mode
  :when (and (modulep! +tree-sitter) (treesit-available-p))
  :custom
  (typst-ts-enable-raw-blocks-highlight t)
  :config
  (setopt typst-ts-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (setopt typst-ts-watch-options '("--open"))
  (setopt typst-ts-indent-offset 2)

  (after! dtrt-indent
    (add-to-list 'dtrt-indent-hook-mapping-list '(typst-ts-mode default typst-ts-indent-offset)))

  (after! editorconfig
    (add-to-list 'editorconfig-indentation-alist '(typst-ts-mode typst-ts-indent-offset)))

  (after! smartparens
    ;; https://typst.app/docs/reference/syntax/
    (sp-with-modes 'typst-ts-mode
      (sp-local-pair "+" "+" :actions '() :when nil)
      (sp-local-pair "|" "|" :actions '() :when nil)
      (sp-local-pair "<" ">" :actions '(:add wrap autoskip) :when nil)
      (sp-local-pair "=" "=" :actions '() :when nil)
      (sp-local-pair "/" "/" :actions '() :when nil)
      (sp-local-pair "~" "~" :actions '() :when nil)
      (sp-local-pair "*" "*" :actions '(:add insert wrap autoskip navigate) :when nil
                     :unless (list #'+typst-sp--in-math-p
                                   #'sp-point-after-word-p
                                   #'sp-point-before-word-p))
      (sp-local-pair "_" "_" :actions '(:add insert wrap autoskip navigate) :when nil
                     :unless (list #'+typst-sp--in-math-p
                                   #'sp-point-after-word-p
                                   #'sp-point-before-word-p))
      (sp-local-pair "`" "`" :actions '(:add insert wrap autoskip navigate) :when nil
                     :unless (list #'+typst-sp--in-math-p))
      (sp-local-pair "$" "$" :actions '(:add insert wrap autoskip navigate) :when nil))

    (defun +typst-sp--in-math-p (_id _action _context)
      (cl-block nil
        (when (derived-mode-p 'typst-ts-mode)
          (let ((node (treesit-node-at (point))))
            (while node
              (when (member (treesit-node-type node) '("math" "formula"))
                (cl-return t))
              (setq node (treesit-node-parent node)))
            nil)))))

  (+typst-common-config 'typst-ts-mode)

  (map! :map typst-ts-mode-map
        :localleader
        "w" #'typst-ts-watch-mode
        (:prefix ("p" . "preview")
                 "P" #'typst-ts-compile-and-preview)))

(use-package! typst-preview
  :when (and (modulep! +preview)
             (executable-find "tinymist"))
  :init
  (setopt typst-preview-autostart t)
  (setopt typst-preview-open-browser-automatically t)
  :config
  (setopt typst-preview-browser "default")
  (setopt typst-preview-invert-colors "never")
  (setopt typst-preview-partial-rendering t)

  (map! :map typst-ts-mode-map
        :localleader
        (:prefix ("p" . "preview")
                 "p" #'typst-preview-mode
                 "s" #'typst-preview-send-position
                 "l" #'typst-preview-list-active-files
                 "c" #'typst-preview-clear-active-files)))

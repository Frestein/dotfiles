;;; lang/pkgbuild/config.el -*- lexical-binding: t; -*-

(set-popup-rule! "^\\*PKGBUILD"
  :actions '(fr/+popup-display-dynamic-side)
  :slot 20 :height 0.5 :width 0.5 :select t :quit nil)

(defun +pkgbuild-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("termux-language-server"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! pkgbuild-mode
  :custom
  (pkgbuild-user-mail-address "fresteinart@gmail.com")
  (pkgbuild-makepkg-command "makepkg -si")
  :config
  (+pkgbuild-common-config 'pkgbuild-mode)

  ;; TODO: WIP AI slop PoC
  ;; INFO: Use comint-mode for makepkg process
  (defvar pkgbuild-process-name "pkgbuild-makepkg")

  (defun pkgbuild--buffer-name (command)
    (format "*%s %s*" command (or buffer-file-name "PKGBUILD")))

  (defun pkgbuild-makepkg (command)
    "Use makepkg COMMAND to build package."
    (interactive
     (if pkgbuild-read-makepkg-command
         (list (read-from-minibuffer "makepkg command: "
                                     (eval pkgbuild-makepkg-command)
                                     nil nil
                                     'pkgbuild-makepkg-history))
       (list (eval pkgbuild-makepkg-command))))
    (save-some-buffers (not pkgbuild-ask-about-save) nil)
    (unless (file-readable-p "PKGBUILD")
      (error "No PKGBUILD in current directory"))
    (let* ((bufname (pkgbuild--buffer-name command))
           (buf (get-buffer-create bufname)))
      (pkgbuild-process-check bufname)
      (when (buffer-live-p buf)
        (kill-buffer buf))
      (setq buf (get-buffer-create bufname))
      (with-current-buffer buf
        (let ((inhibit-read-only t))
          (erase-buffer)
          (comint-mode)
          (setq-local comint-prompt-regexp "^[^$#\n]*[#$%>] *")
          (setq-local comint-use-prompt-regexp t)
          (add-hook 'comint-output-filter-functions
                    #'comint-watch-for-password-prompt nil t))
        (display-buffer buf))
      (let ((proc (start-process-shell-command "makepkg" bufname command)))
        (set-process-filter proc #'comint-output-filter)
        (set-process-sentinel proc #'pkgbuild-process-sentinel)
        (with-current-buffer buf
          (setq-local comint-ptyp proc))
        proc)))

  (defun pkgbuild-process-sentinel (process event)
    (let ((buf (process-buffer process)))
      (when (buffer-live-p buf)
        (with-current-buffer buf
          (let ((inhibit-read-only t))
            (goto-char (point-max))
            (insert event))))))

  (defun pkgbuild-abort ()
    (interactive)
    (let ((proc (get-buffer-process (current-buffer))))
      (when (and proc (process-live-p proc))
        (interrupt-process proc))))

  (map! :map pkgbuild-mode-map
        :localleader
        "s" #'pkgbuild-update-sums-line
        "S" #'pkgbuild-update-srcinfo
        "m" #'pkgbuild-makepkg
        "t" #'pkgbuild-tar
        "e" #'pkgbuild-etags
        "i" #'pkgbuild-initialize
        "r" #'pkgbuild-increase-release-tag
        "o" #'pkgbuild-browse-url))

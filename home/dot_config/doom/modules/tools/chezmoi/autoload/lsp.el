;;; tools/chezmoi/autoload/lsp.el -*- lexical-binding: t; -*-
;;;###if (modulep! :tools lsp +eglot)

;;;###autoload
(defun fr/chezmoi-luarc (&optional dir)
  "Return the nearest .luarc.json or dot_luarc.json above DIR."
  (fr/chezmoi-dominating-file '(".luarc.json" "dot_luarc.json") dir))

;;;###autoload
(defun fr/chezmoi-eglot-lua-contact (&optional _interactive _project)
  "`lua-language-server' contact aware of chezmoi source paths.

In `fr/chezmoi-dir' LuaLS' own .luarc.json discovery is useless: the
workspace root is the whole source repo and sourced configs keep
dot_* names, so pass the nearest luarc via --configpath."
  (let ((cmd (if (fboundp '+lua-generate-lsp-server-command)
                 (+lua-generate-lsp-server-command)
               '("lua-language-server")))
        (dir (and buffer-file-name
                  (file-name-directory buffer-file-name))))
    (if-let* ((dir dir)
              (config (fr/chezmoi-luarc dir)))
        (append cmd (list (concat "--configpath=" config)))
      cmd)))

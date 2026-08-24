;;; app/telega/autoload/tg-ws-proxy.el -*- lexical-binding: t; -*-
;;;###if (or (executable-find "TgWsProxy") (executable-find "tg-ws-proxy"))

;;;###autoload
(defcustom fr/telega-proxy-tgwsproxy-config
  (expand-file-name "TgWsProxy/config.json"
                    (or (getenv "XDG_CONFIG_HOME")
                        (expand-file-name "~/.config")))
  "Path to TgWsProxy JSON config file with host, port, secret."
  :type 'file
  :group 'telega)

;;;###autoload
(defun fr/telega-add-proxy-tgwsproxy (&optional enable)
  "Load TgWsProxy proxy config from `fr/telega-proxy-tgwsproxy-config'.
If ENABLE is non-nil, enable the proxy immediately."
  (let ((config-file fr/telega-proxy-tgwsproxy-config))
    (when (file-exists-p config-file)
      (require 'json)
      (with-temp-buffer
        (insert-file-contents config-file)
        (let* ((json-object-type 'alist)
               (data (json-read))
               (host (alist-get "host" data))
               (port (alist-get "port" data))
               (secret (alist-get "secret" data)))
          (when (and host port secret)
            (add-hook 'telega-before-auth-hook
                      (lambda ()
                        (telega--addProxy
                            `(:server ,host
                              :port ,port
                              :type (:@type "proxyTypeMtproto" :secret ,secret))
                            (when enable 'enable))))))))))

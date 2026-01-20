;; Keybindings
(define-configuration (input-buffer)
    ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

(define-configuration (prompt-buffer)
    ((default-modes (pushnew 'nyxt/mode/vi:vi-insert-mode %slot-value%))))

;; Adblocking
;; FIX: Broken on electron backend
;; (define-configuration web-buffer
;;   ((default-modes
;;     (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

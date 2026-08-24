;; -*- no-byte-compile: t; -*-
;;; tools/chezmoi/packages.el

;; TODO: Adjust when PR will be merged.
;; https://github.com/tuh8888/chezmoi.el/pull/38
(package! chezmoi
  :recipe (:host github
           :repo "Lillenne/chezmoi.el"))

(when (executable-find "age")
  (package! chezmoi-age
    :recipe (:host github
             :repo "Lillenne/chezmoi.el"
             :files ("extensions/chezmoi-age.el"))))

(when (modulep! :completion corfu)
  (package! chezmoi-cape
    :recipe (:host github
             :repo "Lillenne/chezmoi.el"
             :files ("extensions/chezmoi-cape.el"))))

(when (modulep! :completion company)
  (package! chezmoi-company
    :recipe (:host github
             :repo "Lillenne/chezmoi.el"
             :files ("extensions/chezmoi-company.el"))))

(package! chezmoi-dired
  :recipe (:host github
           :repo "Lillenne/chezmoi.el"
           :files ("extensions/chezmoi-dired.el")))

(package! chezmoi-ediff
  :recipe (:host github
           :repo "Lillenne/chezmoi.el"
           :files ("extensions/chezmoi-ediff.el")))

(when (modulep! :tools magit)
  (package! chezmoi-magit
    :recipe (:host github
             :repo "Lillenne/chezmoi.el"
             :files ("extensions/chezmoi-magit.el"))))

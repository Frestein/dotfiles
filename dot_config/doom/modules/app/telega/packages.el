;; -*- no-byte-compile: t; -*-
;;; app/telega/packages.el

(package! telega
  :recipe (:host github
           :repo "zevlg/telega.el"
           :files (:defaults "etc" "server" "Makefile")))

(when (modulep! +mnz)
  (package! telega-mnz
    :recipe (:host github
             :repo "zevlg/telega.el"
             :files ("contrib/telega-mnz.el")))

  (package! language-detection))

(when (modulep! +adblock)
  (package! telega-adblock
    :recipe (:host github
             :repo "zevlg/telega.el"
             :files ("contrib/telega-adblock.el"))))

(when (modulep! :emacs dired)
  (package! telega-dired-dwim
    :recipe (:host github
             :repo "zevlg/telega.el"
             :files ("contrib/telega-dired-dwim.el"))))

(when (modulep! :lang org)
  (package! ol-telega
    :recipe (:host github
             :repo "zevlg/telega.el"
             :files ("contrib/ol-telega.el"))))

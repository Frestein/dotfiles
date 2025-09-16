;;; tools/disk-usage/config.el -*- lexical-binding: t; -*-

(use-package! disk-usage
  :hook (disk-usage-mode . display-line-numbers-mode)
  :custom
  (disk-usage-du-args
   "-sb --exclude=.git --exclude=GDrive")
  (disk-usage--du-args
   "-sb --exclude=.git --exclude=GDrive")
  :config
  (defvar disk-usage-exclude-dirs
    '(".git" "GDrive")
    "List of directory names to exclude from disk-usage calculations.")

  (defun disk-usage-filter-exclude (path _attributes)
    "Exclude PATH if its final directory name is in `disk-usage-exclude-dirs`."
    (not (member (file-name-nondirectory (directory-file-name path))
                 disk-usage-exclude-dirs)))

  (add-to-list 'disk-usage-available-filters 'disk-usage-filter-exclude)
  (add-to-list 'disk-usage-default-filters 'disk-usage-filter-exclude))

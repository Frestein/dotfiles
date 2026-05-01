((vimrc-mode .
             ((eval .
                    (progn
                      (setq-local imenu-generic-expression
                                  '(("Subsection" "^\"[ \t]*-+\n\"[ \t]*\\(.+\\)\n\"[ \t]*-+" 1)
                                    ("Section" "^\"[ \t]*=+\n\"[ \t]*\\(.+\\)\n\"[ \t]*=+" 1))))))))

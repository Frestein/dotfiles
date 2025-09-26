;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       ;; bidi              ; (tfel ot) thgir etirw uoy gnipleh
       reverse-im           ; support non-english keyboard layouts
       ;; chinese
       ;; japanese
       ;; layout            ; auie,ctsrnm is the superior home row

       :completion
       ;; company           ; the ultimate code completion backend
       (corfu +orderless +dabbrev +icons)  ; complete with cap(f), cape and a flying feather!
       ;; helm              ; the *other* search engine for love and life
       ;; ido               ; the other *other* search engine...
       ;; ivy               ; a search engine for love and life
       (vertico +icons)     ; the search engine of the future

       :ui
       ;; deft              ; notational velocity for Emacs
       doom                 ; what makes DOOM look the way it does
       doom-dashboard       ; a nifty splash screen for Emacs
       ;; doom-quit         ; DOOM quit-message prompts when you quit Emacs
       ;; (frames-only +remap) ; use native window splits
       ;; (emoji +unicode)  ; 🙂
       hl-todo              ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;; indent-guides     ; highlighted indent columns
       ligatures            ; ligatures and symbols to make your code pretty again
       ;; minimap           ; show a map of the code on the side
       modeline             ; snazzy, Atom-inspired modeline, plus API
       ;; nav-flash         ; blink cursor line after big motions
       ;; neotree           ; a project drawer, like NERDTree for vim
       ophints              ; highlight the region an operation acts on
       (popup +defaults)    ; tame sudden yet inevitable temporary windows
       (smooth-scroll +interpolate)  ; So smooth you won't believe it's not butter
       smart-cursor         ; change cursor-color dynamically
       ;; tabs              ; a tab bar for Emacs
       ;; treemacs          ; a project drawer, like neotree but cooler
       unicode              ; extended unicode support for various languages
       (vc-gutter +pretty)  ; vcs diff in the fringe
       ;; vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       volatile-highlights
       ;; window-select     ; visually switch windows
       workspaces           ; tab emulation, persistence & separate workspaces
       zen                  ; distraction-free coding or writing

       :editor
       (evil +everywhere)   ; come to the dark side, we have cookies
       file-templates       ; auto-snippets for empty files
       fold                 ; (nigh) universal code folding
       (format +lsp +onsave)  ; automated prettiness
       ;; god               ; run Emacs commands without modifier keys
       ;; lispy             ; vim for lisp, for people who don't like vim
       ;; multiple-cursors  ; editing in many places at once
       drag-stuff
       ialign
       ;; objed             ; text object editing for the innocent
       ;; parinfer          ; turn lisp into python, sort of
       ;; rotate-text       ; cycle region at point between text candidates
       snippets             ; my elves. They type so I don't have to
       (whitespace +guess +trim)  ; a butler for your whitespace
       ;; word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +icons +dirvish)  ; making dired pretty [functional]
       electric             ; smarter, keyword-based electric-indent
       eww                  ; the internet is gross
       epg                  ; user interface to gnupg
       (ibuffer +icons)     ; interactive buffer management
       tramp                ; remote files at your arthritic fingertips
       undo                 ; persistent, smarter undo for your inevitable mistakes
       vc                   ; version-control and Emacs, sitting in a tree

       :term
       eat                  ; the fastest terminal emulator for Emacs
       eshell               ; the elisp shell that works everywhere
       ;; shell             ; simple shell REPL for Emacs
       ;; term              ; basic terminal emulator for Emacs
       vterm                ; the best terminal emulation in Emacs

       :checkers
       syntax               ; tasing you for every semicolon you forget
       ;; (spell +flyspell) ; tasing you for misspelling mispelling
       jinx                 ; enchanted spell checker
       ;; grammar           ; tasing grammar mistake every you make

       :tools
       ;; ansible
       ;; biblio            ; Writes a PhD for you (citation needed)
       ;; collab            ; buffers with friends
       debugger             ; FIXME stepping through code, to help you add bugs
       ;; direnv
       disk-usage
       ;; docker
       chezmoi
       (consult-gh +nerd)   ; interactive interface for "Github CLI"
       fj                   ; client for forgejo instances
       trashed              ; freedesktop.org trashcan
       screenshot
       0x0
       ;; editorconfig      ; let someone else argue about tabs vs spaces
       ;; ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)      ; run code, run (also, repls)
       lookup               ; navigate your code and its documentation
       ;; llm               ; when I said you needed friends, I didn't mean...
       (lsp +eglot +booster)  ; M-x vscode
       (magit +forge)       ; a git porcelain for Emacs
       git-auto-commit
       ;; make              ; run make tasks from Emacs
       (pass +auth)         ; password manager for nerds
       ebuku                ; bookmark manager for nerds
       pdf                  ; pdf enhancements
       ;; reader            ; an all-in-one document reader
       ;; terraform         ; infrastructure as code
       ;; tmux              ; an API for interacting with tmux
       tree-sitter          ; syntax and parsing, sitting in a tree...
       ;; upload            ; map local to remote projects via ssh/ftp

       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       tty                  ; improve the terminal Emacs experience

       :lang
       ;; ada               ; In strong typing we (blindly) trust
       ;; agda              ; types of types of types of types...
       ;; beancount         ; mind the GAAP
       ;; (cc +lsp)         ; C > C++ == 1
       ;; clojure           ; java with a lisp
       common-lisp          ; if you've seen one lisp, you've seen them all
       ;; coq               ; proofs-as-programs
       ;; crystal           ; ruby at the speed of c
       ;; csharp            ; unity, .NET, and mono shenanigans
       data                 ; config/data formats
       ;; (dart +flutter)   ; paint ui and not much else
       ;; dhall
       ;; elixir            ; erlang done right
       ;; elm               ; care for a cup of TEA?
       emacs-lisp           ; drown in parentheses
       ;; erlang            ; an elegant language for a more civilized age
       ;; ess               ; emacs speaks statistics
       ;; factor
       ;; faust             ; dsp, but you get to keep your soul
       ;; fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;; fsharp            ; ML stands for Microsoft's Language
       ;; fstar             ; (dependent) types and (monadic) effects and Z3
       ;; gdscript          ; the language you waited for
       (go +lsp +tree-sitter)         ; the hipster dialect
       ;; (graphql +lsp)    ; Give queries a REST
       ;; (haskell +lsp)    ; a language that's lazier than I am
       ;; hy                ; readability of scheme w/ speed of python
       ;; idris             ; a language you can depend on
       (json +lsp +tree-sitter)  ; At least it ain't XML
       ;; janet             ; Fun fact: Janet is me!
       ;; (java +lsp)       ; the poster child for carpal tunnel syndrome
       ;; javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;; julia             ; a better, faster MATLAB
       ;; kotlin            ; a better, slicker Java(Script)
       ;; latex             ; writing papers in Emacs has never been so fun
       ;; lean              ; for folks with too much to prove
       ;; ledger            ; be audit you can be
       (lua +lsp +tree-sitter +fennel)  ; one-based indices? one-based indices
       (markdown +tree-sitter)  ; writing docs for people to ignore
       ;; nim               ; python + lisp at the speed of c
       (nix +tree-sitter)   ; I hereby declare "nix geht mehr!"
       ;; ocaml             ; an objective camel
       (org +dragndrop +roam)  ; organize your plain life in plain text
       ;; php               ; perl's insecure younger brother
       ;; plantuml          ; diagrams for confusing people more
       ;; graphviz          ; diagrams for confusing yourself even more
       ;; purescript        ; javascript, but functional
       (python +lsp +pyright +tree-sitter)  ; beautiful is better than ugly
       (qt +lsp +tree-sitter)  ; the 'cutest' gui framework ever
       ;; racket            ; a DSL for DSLs
       ;; raku              ; the artist formerly known as perl6
       ;; rest              ; Emacs as a REST client
       ;; rst               ; ReST in peace
       ;; (ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;; (rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;; scala             ; java, but good
       (scheme +guile)      ; a fully conniving family of lisps
       (sh +lsp +tree-sitter +fish)  ; she sells {ba,z,fi}sh shells on the C xor
       ;; sml
       ;; solidity          ; do you need a blockchain? No.
       ;; swift             ; who asked for emoji variables?
       ;; terra             ; Earth and Moon in alignment for performance.
       ;; web               ; the tubes
       (yaml +lsp +tree-sitter)  ; JSON, but readable
       ;; zig               ; C, but simpler

       :email
       ;; (mu4e +org +gmail)
       ;; notmuch
       ;; (wanderlust +gmail)

       :app
       calendar
       ement                ; Matrix client
       osm                  ; OpenStreetMap viewer
       (telega +mnz +stories +icons +sponsored2 +blocked)  ; the best telegram client ever
       ;; emms
       ;; everywhere        ; *leave* Emacs!? You must be joking
       ;; irc               ; how neckbeards socialize
       (rss +org)           ; emacs as an RSS reader

       :config
       literate
       compile-angel        ; auto byte/native-compile all elisp files
       (default +bindings +smartparens))

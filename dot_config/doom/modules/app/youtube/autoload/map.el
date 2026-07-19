;;; app/youtube/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/yeetube--init-map-h ()
  "Initialize yeetube's mappings."
  (map! :leader
        (:prefix "A"
         :desc "YouTube (search)" "y" #'yeetube-search
         :desc "YouTube (saved)" "Y" #'yeetube-play-saved-video))

  (map! :map yeetube-mode-map
        :n [return] #'yeetube-play
        :n [S-return] #'yeetube-play-saved-video
        :n "m" #'yeetube
        :n "r" #'yeetube-replay
        :n "n" #'yeetube-next-page
        :n "s" #'yeetube-search
        :n "a" #'yeetube-save-video
        :n "d" #'yeetube-download-video
        :n "y" #'yeetube-copy-url
        :n "Y" #'yeetube-copy-rss-feed-url
        :n "c" #'yeetube-channel-videos
        :n "C" #'yeetube-channel-streams
        :n "b" #'yeetube-browse-url
        :n "D" #'yeetube-remove-saved-video))

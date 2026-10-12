;;; app/pomm/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/pomm--init-map-h ()
  "Initialize pomm's mappings."
  (map! :leader
        (:prefix "o"
         :desc "Third Time" "," #'pomm-third-time
         :desc "Pomodoro" "." #'pomm)
        (:prefix ("P" . "pomm")
                 (:prefix ("t" . "Third Time")
                          "s" #'pomm-third-time-start
                          "S" #'pomm-third-time-stop
                          "t" #'pomm-third-time-switch
                          "o" #'pomm-third-time)
                 (:prefix ("p" . "Pomodoro")
                          "s" #'pomm-start
                          "S" #'pomm-stop
                          "o" #'pomm))))

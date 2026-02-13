;;; app/telega/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "tgs2png")
  (warn! "Couldn't find the tgs2png binary. Animated stickers will not work."))

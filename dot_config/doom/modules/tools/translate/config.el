;;; tools/translate/config.el -*- lexical-binding: t; -*-

(use-package! gt
  :hook (doom-after-modules-config . +gt--init-map-h)
  :hook (gt-buffer-render-init . visual-line-mode)
  :commands (gt-setup gt-switch-translator)
  :config
  (setopt gt-langs '(en ru))
  (setq gt-preset-translators
        `((google-word
           . ,(gt-translator
               :taker (gt-taker :text 'word)
               :engines (gt-google-engine)
               :render (gt-buffer-render)))
          (google-word-replace
           . ,(gt-translator
               :taker (gt-taker :text 'word)
               :engines (gt-google-engine)
               :render (gt-insert-render :type 'replace)))
          (google-sentence
           . ,(gt-translator
               :taker (gt-taker :text 'sentence)
               :engines (gt-google-engine)
               :render (gt-buffer-render)))
          (google-sentence-replace
           . ,(gt-translator
               :taker (gt-taker :text 'sentence)
               :engines (gt-google-engine)
               :render (gt-insert-render :type 'replace)))
          (google-paragraph
           . ,(gt-translator
               :taker (gt-taker :text 'paragraph)
               :engines (gt-google-engine)
               :render (gt-buffer-render)))
          (google-paragraph-replace
           . ,(gt-translator
               :taker (gt-taker :text 'paragraph)
               :engines (gt-google-engine)
               :render (gt-insert-render :type 'replace)))))

  (set-popup-rule! (regexp-quote "*gt-result*")
    :actions '(fr/+popup-display-dynamic-side) :height .5 :width .5 :slot 1 :ttl 0))

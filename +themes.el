;;; ~/.doom.d/+themes.el -*- lexical-binding: t; -*-
;; * Faces
;; ** Function override
(defun doom-themes-set-faces (theme &rest faces)
  "Customize THEME (a symbol) with FACES."
  (apply #'custom-theme-set-faces
         (or theme 'user)
         (mapcar 'eval (mapcar #'doom-themes--build-face faces))))



(defun doom-org-custom-fontification ()
  "Correct (and improve) org-mode's font-lock keywords.

  1. Re-set `org-todo' & `org-headline-done' faces, to make them respect
     (inherit) underlying faces.
  2. Make statistic cookies respect (inherit) underlying faces.
  3. Fontify item bullets (make them stand out)
  4. Fontify item checkboxes (and when they're marked done), like TODOs that are
     marked done.
  5. Fontify dividers/separators (5+ dashes)
  6. Fontify #hashtags and @at-tags, for personal convenience; see
     `doom-org-special-tags' to disable this."
  (let ((org-todo (format org-heading-keyword-regexp-format
                          org-todo-regexp))
        (org-done (format org-heading-keyword-regexp-format
                          (concat "\\(?:" (mapconcat #'regexp-quote org-done-keywords "\\|") "\\)"))))
    (setq
     org-font-lock-extra-keywords
     (append (org-delete-all
              (append `(("\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
                         (0 (org-get-checkbox-statistics-face) t))
                        (,org-todo (2 (org-get-todo-face 2) t))
                        (,org-done (2 'org-headline-done t)))
                      (when (memq 'date org-activate-links)
                        '((org-activate-dates (0 'org-date t)))))
              org-font-lock-extra-keywords)
             ;; respsect underlying faces!
             `((,org-todo (2 (org-get-todo-face 2) prepend))
               (,org-done (2 'org-headline-done prepend)))
             ;; (when (memq 'date org-activate-links)
             ;;   '((org-activate-dates (0 'org-date prepend))))
             ;; Make checkbox statistic cookies respect underlying faces
             '(("\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
                (0 (org-get-checkbox-statistics-face) prepend))
               ;; I like how org-mode fontifies checked TODOs and want this to extend to
               ;; checked checkbox items:
               ("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
                1 'org-headline-done prepend)
               ;; make plain list bullets stand out
               ("^ *\\([-+]\\|[0-9]+[).]\\) " 1 'org-list-dt append)
               ;; and separators/dividers
               ("^ *\\(-----+\\)$" 1 'org-meta-line))
             ;; custom #hashtags & @at-tags for another level of organization
             (when doom-org-special-tags
               '(("\\s-\\(\\([#@]\\)[^+ \n.,]+\\)" 1 (doom-org--tag-face 2) prepend)))))))
(doom-themes-set-faces 'user
;; ** font-lock
  '(font-lock-builtin-face              :foreground builtin :slant 'italic :weight 'light)
  '(font-lock-variable-name-face        :foreground variables :weight 'semi-bold)
  '(font-lock-function-name-face        :foreground functions :weight 'semi-bold)
  '(font-lock-keyword-face              :foreground keywords :weight 'semi-bold)
  '(font-lock-string-face               :foreground strings :weight 'semi-bold)
  '(font-lock-type-face                 :foreground type :slant 'italic)
;; ** hi
  '(hi-yellow :foreground yellow :background (doom-blend 'yellow 'bg 0.3))
  '(hi-blue :foreground blue :background (doom-blend 'blue 'bg 0.3))
  '(hi-pink :foreground red :background (doom-blend 'red 'bg 0.3))
  '(hi-green :foreground green :background (doom-blend 'green 'bg 0.3))
;; ** ivy
  '(ivy-minibuffer-match-face-1 :background nil :foreground (doom-lighten 'grey 0.4) :weight 'light)
  '(ivy-minibuffer-match-face-2 :inherit 'ivy-minibuffer-match-face-1 :foreground magenta :background (doom-blend 'magenta 'base3 0.1) :weight 'semi-bold)
  '(ivy-minibuffer-match-face-3 :inherit 'ivy-minibuffer-match-face-1 :foreground green :background (doom-blend 'green 'base3 0.1) :weight 'semi-bold)
  '(ivy-minibuffer-match-face-4 :inherit 'ivy-minibuffer-match-face-1 :foreground yellow :background (doom-blend 'yellow 'base3 0.1) :weight 'semi-bold)
  '(prodigy-green-face :foreground green)
  '(prodigy-red-face :foreground red)
  '(prodigy-yellow-face :foreground yellow)
;; ** ivy-posframe
  '(ivy-posframe :background (doom-darken 'bg-alt 0.1))
  '(ivy-posframe-cursor :background highlight)
;; ** swiper
  '(swiper-line-face    :background blue :foreground bg)
  '(swiper-match-face-1 :inherit 'unspecified :weight 'bold)
  '(swiper-match-face-2 :inherit 'unspecified :background magenta  :foreground base0 :weight 'bold)
  '(swiper-match-face-3 :inherit 'unspecified :background green :foreground base0 :weight 'bold)
  '(swiper-match-face-4 :inherit 'unspecified :background yellow   :foreground base0 :weight 'bold)
;; ** ace-window
  '(aw-leading-char-face :foreground base0 :background base7 :weight 'ultra-bold)
;; ** company
  '(company-tooltip-selection  :background selection :weight 'bold)
  '(company-preview                              :foreground comments :background bg :weight 'extralight)
  '(company-preview-common     :background base3 :foreground comments :background bg :weight 'extralight)
  '(company-box-scrollbar :foreground highlight :background base3)
  '(company-box-background :background (doom-darken 'bg-alt 0.1))
  '(company-box-selection :inherit 'company-tooltip-selection)
  '(company-box-annotation :inherit 'company-tooltip-annotation)
;; ** outline
  '(outline-1  :font "SF Compact Display" :foreground blue  :background bg :height 1.4)
  '(outline-2  :font "SF Compact Display" :foreground violet :height 1.2)
  '(outline-3  :font "SF Compact Display" :foreground yellow :height 1.2)
  '(outline-4  :font "SF Compact Display" :foreground red    :height 1.0)
  '(outline-5  :font "SF Compact Display" :foreground blue   :height 1.0)
  '(outline-6  :font "SF Compact Display" :foreground violet :height 1.0)
  '(outline-7  :font "SF Compact Display" :foreground yellow :height 1.0)
  '(outline-8  :font "SF Compact Display" :foreground red    :height 1.0)
;; ** org-mode
  '(org-level-1         :inherit 'outline-1)
  '(org-level-2         :inherit 'outline-2)
  '(org-level-3         :inherit 'outline-3)
  '(org-level-4         :inherit 'outline-4)
  '(org-level-5         :inherit 'outline-5)
  '(org-level-6         :inherit 'outline-6)
  '(org-level-7         :inherit 'outline-7)
  '(org-level-8         :inherit 'outline-8)
  '(org-agenda-column-dateline   :inherit 'org-column)
  '(org-agenda-date         :font "SF Compact Display" :foreground (doom-blend 'yellow 'bg 0.8) :weight 'bold  :height 1.6)
  '(org-agenda-date-today   :font "SF Compact Display" :foreground (doom-blend 'blue 'bg 0.8)   :weight 'bold  :height 1.6)
  '(org-agenda-date-weekend :font "SF Compact Display" :foreground (doom-blend 'green 'bg 0.8)  :weight 'bold  :height 1.6)
  '(org-agenda-structure    :font "SF Compact Display" :foreground (doom-blend 'violet 'bg 0.8) :weight 'bold  :height 1.4)
  ;; (org-block                    :background (doom-blend 'base4 'bg 0.15))
  ;; (org-block-background         :weight 'extralight :font "Iosevka" :background (doom-blend 'base4 'bg 0.1))
  ;; (org-block-begin-line         :weight 'extralight :font "Iosevka" :foreground (doom-blend 'blue 'bg 0.5) :background (doom-blend 'base4 'bg 0.1) :distant-foreground nil)
  '(org-ellipsis :background nil :foreground base5)
  '(org-column                   :inherit 'org-table)
  '(org-column-title             :inherit 'org-column :weight 'bold)
  '(org-date          :weight 'extralight :font "Iosevka" :foreground fg)
  '(org-meta-line :foreground base5)
  '(org-deadline-custom          :weight 'bold :font "Iosevka" :foreground bg :background red :distant-foreground bg)
  '(org-scheduled-custom         :weight 'bold :font "Iosevka" :foreground bg :background green :distant-foreground bg)
  '(org-closed-custom            :weight 'bold :font "Iosevka" :foreground bg :background base6 :distant-foreground bg)
  '(org-deadline-custom-braket   :foreground red   :background red :distant-foreground red)
  '(org-scheduled-custom-braket  :foreground green :background green :distant-foreground green)
  '(org-closed-custom-braket     :foreground base6 :background base6 :distant-foreground base6)

  '(org-special-keyword          :foreground (doom-blend 'blue 'bg 0.3) :font "Iosevka" :weight 'extralight)
  '(org-table                    :overline base5 :font "Iosevka")
  '(org-link  :inherit 'link :font "Iosevka" :foreground blue)
  '(org-tag                      :foreground green :weight 'light)
  '(org-todo                     :bold 'inherit :foreground highlight)
  '(org-priority :weight 'bold :font "SF Mono" :height 'unspecified :foreground red)
  '(org-priority-hide :weight 'extralight :font "SF Mono" :foreground bg :height 'unspecified)
  '(org-todo-keyword-done :foreground (doom-blend 'green 'bg 0.7)    :font "SF Mono" :weight 'bold)
  '(org-todo-keyword-want :foreground (doom-blend 'yellow 'bg 0.7)   :font "SF Mono" :weight 'bold :height 1.0)
  '(org-todo-keyword-kill :foreground (doom-blend 'magenta 'bg 0.7)  :font "SF Mono" :weight 'bold :height 1.0)
  '(org-todo-keyword-outd :foreground (doom-blend 'fg 'bg 0.7)       :font "SF Mono" :weight 'bold :height 1.0)
  '(org-todo-keyword-todo :foreground (doom-blend 'blue 'bg 0.7)     :font "SF Mono" :weight 'bold :height 1.0)
  '(org-todo-keyword-wait :foreground (doom-blend 'orange 'bg 0.7)      :font "SF Mono" :weight 'bold :height 1.0)
;; ** ovp
  ;; (ovp-face :height 1.0 :font "Iosevka")
;; ** auctex (latex-mode)
  '(font-latex-sectioning-0-face :inherit 'outline-1)
  '(font-latex-sectioning-1-face :inherit 'outline-2)
  '(font-latex-sectioning-2-face :inherit 'outline-3)
  '(font-latex-sectioning-3-face :inherit 'outline-4)
  '(font-latex-sectioning-4-face :inherit 'outline-5)
  '(font-latex-sectioning-5-face :inherit 'outline-6)
  '(font-latex-sectioning-6-face :inherit 'outline-7)
  '(font-latex-sectioning-7-face :inherit 'outline-8)
;; ** markdown-mode
  '(markdown-url-face              :foreground magenta :weight 'normal)
  '(markdown-header-face-1         :inherit 'org-level-1)
  '(markdown-header-face-2         :inherit 'org-level-2)
  '(markdown-header-face-3         :inherit 'org-level-3)
  '(markdown-header-face-4         :inherit 'org-level-4)
  '(markdown-header-face-5         :inherit 'org-level-5)
  '(markdown-header-face-6         :inherit 'org-level-6)
  '(markdown-header-face-7         :inherit 'org-level-7)
  '(markdown-header-face-8         :inherit 'org-level-8)
;; ** elfeed
  ;; (elfeed-log-debug-level-face :foreground comments)
  ;; (elfeed-log-error-level-face :inherit 'error)
  ;; (elfeed-log-info-level-face  :inherit 'success)
  ;; (elfeed-log-warn-level-face  :inherit 'warning)
  ;; (elfeed-search-date-face     :foreground violet)
  ;; (elfeed-search-feed-face     :foreground blue :weight 'extralight)
  ;; (elfeed-search-tag-face      :foreground yellow :weight 'extralight)
  '(elfeed-search-title-face    :foreground base6 :font "Charter" :height 1.2 :slant 'italic)
  ;; (elfeed-search-filter-face   :foreground violet)
  ;; (elfeed-search-unread-count-face :foreground yellow)
  '(elfeed-search-unread-title-face :foreground fg :font "Charter" :height 1.0 :weight 'bold :slant 'italic)
  '(elfeed-show-title-face :weight 'ultrabold :slant 'italic :font "charter" :height 1.5)
  '(elfeed-show-author-face :weight 'light :foreground base6)
  '(elfeed-show-feed-face :weight 'bold :foreground base6)
  '(elfeed-show-tag-face :weight 'extralight :background (doom-blend 'blue 'bg 0.2) :foreground (doom-color 'blue))
  '(elfeed-show-misc-face :weight 'extralight :foreground (doom-color 'yellow) )
;; ** message
  '(message-header-name       :foreground green)
  '(message-header-subject    :foreground highlight :weight 'bold)
  '(message-header-to         :foreground highlight :weight 'bold)
  '(message-header-cc         :inherit 'message-header-to :foreground (doom-darken 'highlight 0.15))
  '(message-header-other      :foreground violet)
  '(message-header-newsgroups :foreground yellow)
  '(message-header-xheader    :foreground doc-comments)
  '(message-separator         :foreground comments)
  '(message-mml               :foreground comments :slant 'italic)
  '(message-cited-text        :foreground magenta)
;; ** notmuch
  ;; (notmuch-crypto-decryption               :foreground blue-l)
  ;; (notmuch-crypto-part-header              :foreground yellow-l)
  ;; (notmuch-crypto-signature-bad            :foreground red-l)
  ;; (notmuch-crypto-signature-good           :foreground base1)
  ;; (notmuch-crypto-signature-good-key       :foreground aqua-l)
  ;; (notmuch-crypto-signature-unknown        :foreground yellow)
  ;; (notmuch-hello-logo-background           :foreground fg)
  ;; (notmuch-message-summary-face            :foreground grey :background nil :weight 'extralight :font "Iosevka")
  ;; (notmuch-search-count                    :foreground comments)
  ;; (notmuch-search-date                     :foreground numbers :weight 'bold)
  ;; (notmuch-search-flagged-face             :foreground (doom-blend 'red 'base4 0.5))
  ;; (notmuch-search-matching-authors         :foreground blue :weight 'bold)
  ;; (notmuch-search-non-matching-authors     :foreground blue)
  ;; (notmuch-search-subject                  :foreground fg)
  ;; (notmuch-search-unread-face              :foreground base8)
  ;; (notmuch-tag-added                       :foreground green :weight 'normal)
  ;; (notmuch-tag-deleted                     :foreground red :weight 'normal)
  ;; (notmuch-tag-face                        :foreground yellow :weight 'normal)
  ;; (notmuch-tag-flagged                     :foreground yellow :weight 'normal)
  ;; (notmuch-tag-unread                      :foreground yellow :weight 'normal)
  ;; (notmuch-tree-match-author-face          :foreground blue :weight 'bold)
  ;; (notmuch-tree-match-date-face            :foreground numbers :weight 'bold)
  ;; (notmuch-tree-match-face                 :foreground fg)
  ;; (notmuch-tree-match-subject-face         :foreground fg)
  ;; (notmuch-tree-match-tag-face             :foreground yellow)
  ;; (notmuch-tree-match-tree-face            :foreground comments)
  ;; (notmuch-tree-no-match-author-face       :foreground blue)
  ;; (notmuch-tree-no-match-date-face         :foreground numbers)
  ;; (notmuch-tree-no-match-face              :foreground base5)
  ;; (notmuch-tree-no-match-subject-face      :foreground base5)
  ;; (notmuch-tree-no-match-tag-face          :foreground yellow)
  ;; (notmuch-tree-no-match-tree-face         :foreground yellow)
  ;; (notmuch-wash-cited-text                 :foreground base4)
  '(notmuch-wash-toggle-button              :foreground blue :weight 'extralight)
;; ** border
  '(internal-border :foreground (doom-darken 'bg-alt 0.1) :background (doom-darken 'bg-alt 0.1))
  '(border :foreground fg :background fg)
;; ** dired
  '(diredfl-file-name              :foreground fg :background bg)
  '(diredfl-dir-name               :foreground blue :background bg)
  '(diredfl-autofile-name          :foreground base4 :background bg)
  '(diredfl-compressed-file-name   :foreground yellow :background bg)
  '(diredfl-compressed-file-suffix :foreground (doom-blend 'orange 'bg-alt 0.6) :background bg)
  '(diredfl-date-time              :foreground cyan :weight 'light :background bg)
  '(diredfl-deletion               :foreground red :background (doom-blend 'red 'bg 0.2) :weight 'bold)
  '(diredfl-deletion-file-name     :foreground red :background (doom-blend 'red 'bg 0.2))
  '(diredfl-dir-heading            :foreground blue :weight 'bold :background bg)
  '(diredfl-dir-priv               :foreground blue :background bg)
  '(diredfl-exec-priv              :foreground green :background bg)
  '(diredfl-executable-tag         :foreground green :background bg)
  '(diredfl-file-suffix            :foreground (doom-blend 'fg 'bg-alt 0.6) :background bg)
  '(diredfl-flag-mark              :foreground yellow :background (doom-blend 'yellow 'bg 0.2) :weight 'bold)
  '(diredfl-flag-mark-line         :background (doom-blend 'yellow 'bg 0.1))
  '(diredfl-ignored-file-name      :foreground comments :background bg)
  '(diredfl-link-priv              :foreground violet :background bg)
  '(diredfl-no-priv                :foreground fg :background bg)
  '(diredfl-number                 :foreground orange :background bg)
  '(diredfl-other-priv             :foreground magenta :background bg)
  '(diredfl-rare-priv              :foreground fg :background bg)
  '(diredfl-read-priv              :foreground yellow :background bg)
  '(diredfl-symlink                :foreground violet :background bg)
  '(diredfl-tagged-autofile-name   :foreground base5 :background bg)
  '(diredfl-write-priv             :foreground red :background bg)
;; ** flycheck
  '(flycheck-posframe-face :inherit nil :fg fg :bg bg-alt :font "SF Compact Display")
  '(flycheck-posframe-info-face :inherit 'flycheck-posframe-face)
  '(flycheck-posframe-warning-face :inherit 'flycheck-posframe-face :foreground warning)
  '(flycheck-posframe-error-face   :inherit 'flycheck-posframe-face :foreground error)
;; ** lsp
  ;; (lsp-ui-peek-footer :inherit 'lsp-ui-peek-header)
  ;; (lsp-ui-doc-url                 :inherit 'link)
  ;; (lsp-ui-doc-header              :background blue)
  ;; (lsp-ui-doc-background          :background bg-alt)
  ;; (lsp-ui-sideline-current-symbol :foreground bg :background highlight)
  ;; (lsp-ui-sideline-symbol         :background region)
;; ** langtools
  ;; (langtool-correction-face :foreground green :background (doom-blend 'green 'bg 0.3) :slant 'italic :weight 'bold)
  ;; (langtool-errline :foreground green :background (doom-blend 'green 'bg 0.3) :slant 'italic)
;; ** wordsmith
  ;;                 (wordsmith-noun-face :underline `(:color ,blue))
  ;;                 (wordsmith-verb-face :underline `(:color ,green))
  ;;                 (wordsmith-default-face :underline `(:color ,fg))
;; ** ein
  ;; (ein:notification-tab-normal   :background base2)
  ;; (ein:notification-tab-selected :background base2)
  ;; (ein:cell-output-stderr        :background (doom-blend 'bg 'red 0.7))
  ;; (ein:cell-heading-1            :inherit 'outline-1)
  ;; (ein:cell-heading-2            :inherit 'outline-2)
  ;; (ein:cell-heading-3            :inherit 'outline-3)
  ;; (ein:cell-heading-4            :inherit 'outline-4)
  ;; (ein:cell-heading-5            :inherit 'outline-5)
  ;; (ein:cell-heading-6            :inherit 'outline-6)
  ;; (ein:cell-input-area           :background (doom-blend 'base4 'bg 0.15))
  ;; (ein:cell-input-prompt         :background (doom-blend 'base6 'bg 0.25) :weight 'light)
  ;; (ein:cell-output-prompt        :inherit 'ein:cell-input-prompt)
;; ** twitter
  ;; (twitter-divider :underline `(:color ,(doom-blend 'vertical-bar 'bg 0.8)))
;; ** sx
  ;; (sx-inbox-item-type-unread         :foreground fg :background bg)
  ;; (sx-inbox-item-type                :foreground fg :background bg)
  ;; (sx-question-list-bounty           :foreground fg :background bg)
  ;; (sx-question-list-favorite         :foreground fg :background bg)
  ;; (sx-question-list-unread-question  :foreground fg :background bg)
  ;; (sx-question-list-read-question    :foreground fg :background bg)
  ;; (sx-question-list-date             :foreground fg :background bg)
  ;; (sx-question-list-score-upvoted    :foreground fg :background bg)
  ;; (sx-question-list-score            :foreground fg :background bg)
  ;; (sx-question-list-answers-accepted :foreground fg :background bg)
  ;; (sx-question-list-answers          :foreground fg :background bg)
  ;; (sx-question-list-parent           :foreground fg :background bg)
  '(sx-question-mode-kbd-tag             :foreground blue :box '(:line-width 1 :style none))
  ;; (sx-question-mode-sub-sup-tag      :foreground fg :background bg)
  '(sx-question-mode-closed-reason    :weight 'bold)
  ;; (sx-question-mode-closed           :foreground fg :background bg)
  ;; (sx-question-mode-accepted         :foreground fg :background bg)
  '(sx-question-mode-content-face                       :background bg)
  ;; (sx-question-mode-score-upvoted    :foreground fg :background bg)
  ;; (sx-question-mode-score-downvoted  :foreground fg :background bg-alt)
  ;; (sx-question-mode-score            :foreground fg :background bg-alt)
  '(sx-question-mode-date             :foreground orange :background bg-alt)
  ;; (sx-question-mode-title-comments   :foreground fg :background bg-alt)
  '(sx-question-mode-title            :foreground fg :background bg-alt :font "SF UI Display" :weight 'bold :height 1.4)
  '(sx-question-mode-header              :inherit 'message-header-name :background bg-alt)
  '(sx-user-accept-rate :foreground green :weight 'light)
  '(sx-user-reputation                :foreground grey :background bg-alt)
  '(sx-user-name                      :foreground blue :background bg-alt)
  '(sx-tag                            :foreground green :background bg-alt)
  '(sx-custom-button              :foreground blue   :background bg     :box '(:line-width 1 :style none)
                                  ))

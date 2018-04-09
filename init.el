;; * Modules
(doom! :feature
       (popup
        +all
        +defaults)
       eval
       (evil +everywhere)
       lookup
        ;; +devdocs
       snippets
       spellcheck
       file-templates
       version-control
       workspaces
       syntax-checker
       :completion
       (company +auto)
       ivy
       :ui
       doom
       doom-dashboard
       doom-modeline
       hl-todo
       posframe
       window-select
       :tools
       dired
       electric-indent
       eshell
       gist
       imenu
       macos
       make
       magit
       neotree
       rgb
       term
       reference
       upload
       (password-store +auth)
       :lang
       lsp
       python
       cc-private
       ess
       (latex
        +latexmk
        +skim)
       (org
        +attach
        +babel
        +capture
        +present)
       (org-private
        +todo
        +babel
        +capture
        +latex
        +export +style)
       ;; data
       emacs-lisp
       ;; javascript
       markdown
       sh
       ;; (web +html)
       :app
       ;; sx
       rss
       twitter
       email
       (write
        +wordnut
        +osxdict
        +synosaurus
        +langtool)
       ;; calendar
       :config
       (default +snippets +evil-commands +bindings))

;; * UI
(setq
 frame-title-format
 '("emacs%@"
   (:eval (system-name)) ": "
   (:eval (if (buffer-file-name)
              (abbreviate-file-name (buffer-file-name))
            "%b")))
 doom-font (font-spec :family "SF Mono" :size 12)
 doom-variable-pitch-font
 (font-spec
  :family "SF Compact Display"
  :size 14
  :width 'extra-condensed
  :weight 'normal
  :slant 'normal
  :registry "iso10646-1")
 doom-unicode-font (font-spec :family "Sarasa Mono SC" :size 12)
 doom-big-font (font-spec :family "SF Mono" :size 16)
 ovp-font "SF Mono"
 doom-theme 'doom-nord-light
 doom-line-numbers-style nil
 +doom-modeline-buffer-file-name-style 'truncate-upto-project
 doom-neotree-enable-variable-pitch t
 doom-neotree-project-size 1.2
 doom-neotree-line-spacing 0
 doom-neotree-folder-size 1.0
 doom-neotree-chevron-size 0.6
 scroll-conservatively 0
 indicate-buffer-boundaries nil
 frame-alpha-lower-limit 0
 indicate-empty-lines nil
 which-key-idle-delay 0.3)

(or standard-display-table
    (setq standard-display-table (make-display-table)))
(set-display-table-slot standard-display-table 0 ?\ )
(setq-default fringe-indicator-alist (delq
                              (assq 'truncation fringe-indicator-alist)
                              (delq (assq 'continuation fringe-indicator-alist)
                                    fringe-indicator-alist)))

;; * Mac-specific
(if (string-match-p "NS" (emacs-version))
    (progn
      (setq ns-alternate-modifier 'meta
            ns-command-modifier 'super)
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (add-to-list 'default-frame-alist '(ns-appearance . light)))
  (setq mac-command-modifier 'super
        mac-option-modifier 'meta
        mac-pass-command-to-system nil))

;; * Config
(setq
 user-mail-address "fuxialexander@gmail.com"
 user-full-name "Alexander Fu Xi"
 max-specpdl-size 10000
 +file-templates-dir "~/.doom.d/templates")

;; * Keys
(setq
 doom-localleader-key ","
 +default-repeat-forward-key ";"
 +default-repeat-backward-key "'"
 evil-want-C-u-scroll t
 evil-want-integration nil
 evil-shift-width 2
 evil-snipe-override-evil-repeat-keys nil
 evil-collection-company-use-tng nil
 evil-respect-visual-line-mode t)


(def-package-hook! evil-collection :pre-config
  (delq 'simple evil-collection-mode-list))

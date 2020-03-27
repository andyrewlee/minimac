;; Configure use-package
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)


;; Defaults
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(set-window-scroll-bars (minibuffer-window) nil nil)
(blink-cursor-mode -1)
(show-paren-mode t)

(global-linum-mode 1)
(global-prettify-symbols-mode t)
(global-hl-line-mode)
(global-auto-revert-mode t)
(global-font-lock-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(setq frame-title-format '((:eval (projectile-project-name))))
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)
(setq dired-use-ls-dired  nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq default-directory "~/")
(setq require-final-newline t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(fset 'yes-or-no-p 'y-or-n-p)


;; Packages
;; Vim
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-shift-width 2)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; Better evil integration with packages
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Quote/paren surround
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;; Theme
(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t))

;; Keybindings popup
(use-package which-key
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; File navigator
(use-package ranger
  :init
  (setq ranger-override-dired-mode t)
  (setq ranger-show-hidden t))

;; Commenting
(use-package evil-nerd-commenter)

;; Completion framework
(use-package counsel
  :config
  (ivy-mode 1))

;; Project navigation
(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-require-project-root nil))

;; Suggestions
(use-package company
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

;; Documentation popup
(use-package company-quickhelp
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip))

;; React
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
        ("\\.tsx\\'" . web-mode)
        ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil)
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (jhl/setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode))

;; CSS
(use-package css-mode
  :config
  (setq css-indent-offset 2))

;; TypeScript
(use-package typescript-mode
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

;; TypeScript IDE
(use-package tide
  :init
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
        (typescript-mode . tide-hl-identifier-mode)))

;; Syntax check
(use-package flycheck
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

;; Mode line
(use-package moody
  :config
  (setq x-underline-at-descent-line t))

;; Git
(use-package magit
  :config
  (use-package evil-magit)
  (use-package with-editor)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  (add-hook 'with-editor-mode-hook 'evil-insert-state))

;; Diff highlight
(use-package diff-hl
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

;; Haskell
(use-package haskell-mode
  :config
  (add-hook 'haskell-mode-hook
          (lambda ()
            (haskell-doc-mode)
            (turn-on-haskell-indent))))

;; Terminal
(use-package multi-term)

;; Focus mode
(use-package olivetti)

;; Jump
(use-package avy
  :config
  (setq avy-background t))

;; Move buffer
(use-package buffer-move)
(use-package whitespace)

;; Window resize
(use-package golden-ratio
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  (add-to-list 'golden-ratio-extra-commands 'buffer-move)
  :config
  (setq golden-ratio-exclude-modes '("ranger-mode")))

;; Org
(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org-pomodoro
  :config
  (setq org-pomodoro-play-sounds nil))

(use-package org-present)
(use-package org-download)

;; Elixir
(use-package elixir-mode
  :config
  (use-package alchemist))

;; Hack
(use-package hack-mode
  :config
  (add-hook 'hack-mode-hook #'hack-enable-format-on-save)
  (add-hook 'hack-mode-hook #'lsp)
  (add-hook 'hack-mode-hook #'flycheck-mode)
  (add-hook 'hack-mode-hook #'company-mode))

;; Shortcuts
(use-package general
  :config (general-define-key
  :states '(normal visual insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  "TAB" '(mode-line-other-buffer :which-key "previous buffer")
  "SPC" '(counsel-M-x :which-key "M-x")

  ;; Apps
  "ad"  '(deer :which-key "deer")
  "ar"  '(ranger :which-key "ranger")
  "at"  '(multi-term :which-key "terminal")

  ;; Buffer
  "be"  '(eval-buffer :which-key "eval buffer")
  "bn"  '(next-buffer :which-key "next buffer")
  "bp"  '(previous-buffer :which-key "previous buffer")
  "bm"  '(buffer-menu :which-key "list buffers")

  ;; Comment
  "c"   '(evilnc-comment-or-uncomment-lines
          :which-key
          "comment selection")

  ;; Emacs
  "ec"  '(jhl/emacs-config :which-key "emacs config")

  ;; Git
  "gd"  '(magit-diff :which-key "git diff")
  "gs"  '(jhl/magit-status :which-key "git status")

  ;; Jump
  "jj"  '(jhl/avy-goto-char :which-key "jump char")
  "jw"  '(jhl/avy-goto-word-or-subword-1 :which-key "jump word")
  "jd"  '(dumb-jump-go :which-key "dumb jump")

  ;; Org
  "on"  '(jhl/notes :which-key "notes")
  "op"  '(jhl/pomodoros :which-key "pomodoros")
  "ot"  '(jhl/todos :which-key "todos")

  ;; Project
  "pf"  '(projectile-find-file :which-key "find file")
  "pg"  '(counsel-git-grep :which-key "git grep")

  ;; Window
  "wC"  '(olivetti-mode :which-key "center buffer")
  "wS"  '(jhl/split-window-below-and-switch :which-key "horizontal split")
  "wV"  '(jhl/split-window-right-and-switch :which-key "vertical split")

  ; Window movement
  "wk"  '(windmove-up :which-key "move to top window")
  "wl"  '(windmove-right :which-key "move to right rindow")
  "wh"  '(windmove-left :which-key "move to left window")
  "wj"  '(windmove-down :which-key "move to bottom window")

  ;; Buffer movement
  "wK"  '(jhl/buf-move-up :which-key "move buffer up")
  "wL"  '(jhl/buf-move-right :which-key "move buffer right")
  "wH"  '(jhl/buf-move-left :which-key "move buffer left")
  "wJ"  '(jhl/buf-move-down :which-key "move buffer bottom")

  ;; TypeScript
  "tj"  '(tide-jump-to-definition :which-key "jump to definition")

  ;; Zsh
  "zc"  '(jhl/zsh-config :which-key "zsh config")
))


;; Scripts
;; Horizontal split and focus on it
(defun jhl/split-window-below-and-switch ()
  (interactive)
  (split-window-below)
  (other-window 1))

;; Vertical split and focus on it
(defun jhl/split-window-right-and-switch ()
  (interactive)
  (split-window-right)
  (other-window 1))

;; Open emacs config
(defun jhl/emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/config.el"))

;; Open zsh config
(defun jhl/zsh-config ()
  (interactive)
  (find-file "~/.zshrc"))

;; Open pomodoros
(defun jhl/pomodoros ()
  (interactive)
  (find-file "~/Code/orgs/pomodoros.org"))

;; Open notes
(defun jhl/notes ()
  (interactive)
  (find-file "~/Code/orgs/notes.org"))

;; Open todos
(defun jhl/todos ()
  (interactive)
  (find-file "~/Code/orgs/todos.org"))

;; Golden ratio
(defun jhl/buf-move-right ()
  (interactive)
  (buf-move-right)
  (golden-ratio))

(defun jhl/buf-move-left ()
  (interactive)
  (buf-move-left)
  (golden-ratio))

(defun jhl/buf-move-up ()
  (interactive)
  (buf-move-up)
  (golden-ratio))

(defun jhl/buf-move-down ()
  (interactive)
  (buf-move-down)
  (golden-ratio))

(defun jhl/magit-status ()
  (interactive)
  (magit-status)
  (golden-ratio))

(defun jhl/avy-goto-word-or-subword-1 ()
  (interactive)
  (avy-goto-word-or-subword-1)
  (golden-ratio))

(defun jhl/avy-goto-char ()
  (interactive)
  (call-interactively #'avy-goto-char)
  (golden-ratio))

;; Tide mode
(defun jhl/setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; Rerun flycheck
(defun jhl/rerun-flycheck ()
  (interactive)
  (flycheck-clear)
  (flycheck-buffer))

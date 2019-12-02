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
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-shift-width 2)
  :config
  (evil-mode 1))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t))


(use-package which-key
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package ranger
  :init
  (setq ranger-override-dired-mode t)
  (setq ranger-show-hidden t))

(use-package evil-nerd-commenter)

(use-package counsel
  :bind
  ("M-x" . 'counsel-M-x)
  ("C-s" . 'swiper)

  :config
  (use-package flx)
  (use-package smex)

  (ivy-mode 1)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy))))

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-require-project-root nil))

(use-package flycheck
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package company
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-quickhelp
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip))

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
                (setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(use-package typescript-mode
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

(use-package tide
  :init
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
        (typescript-mode . tide-hl-identifier-mode)))

(use-package css-mode
  :config
  (setq css-indent-offset 2))

(use-package moody
  :config
  (setq x-underline-at-descent-line t))

(use-package diff-hl
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

(use-package magit
  :config
  (use-package evil-magit)
  (use-package with-editor)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  (add-hook 'with-editor-mode-hook 'evil-insert-state))

(use-package haskell-mode
	:config
	(add-hook 'haskell-mode-hook
          (lambda ()
            (haskell-doc-mode)
            (turn-on-haskell-indent))))

(use-package multi-term)

(use-package general
  :config (general-define-key
  :states '(normal visual insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
  "SPC" '(counsel-M-x :which-key "M-x")
  "c"  '(evilnc-comment-or-uncomment-lines :which-key "comment selection")
  "u"  '(evil-scroll-up :which-key "scroll up")
  "d"  '(evil-scroll-down :which-key "scroll down")
  "be"  '(eval-buffer :which-key "eval buffer")
  "bl"  '(list-buffers :which-key "list buffers")
  "pf"  '(projectile-find-file :which-key "find file")
  "pg"  '(projectile-grep :which-key "grep")
  "gs"  '(magit-status :which-key "git status")
  "gd"  '(magit-diff :which-key "git diff")
  "wl"  '(windmove-right :which-key "move right")
  "wh"  '(windmove-left :which-key "move left")
  "wk"  '(windmove-up :which-key "move up")
  "wj"  '(windmove-down :which-key "move bottom")
  "wV"  '(jhl/split-window-right-and-switch :which-key "split right")
  "wS"  '(jhl/split-window-below-and-switch :which-key "split bottom")
  "ad"  '(deer :which-key "deer")
  "ar"  '(ranger :which-key "ranger")
  "at"  '(multi-term :which-key "terminal")
  "as"  '(swiper :which-key "swiper")
))


;; Scripts
(defun jhl/split-window-below-and-switch ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun jhl/split-window-right-and-switch ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun jhl/emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/config.el"))

;; Package manager
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; Defaults
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq ranger-override-dired-mode t)
(setq inhibit-startup-screen t)


;; Packages
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-gruvbox t))

(use-package helm
  :ensure t
  :init
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 50))

(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package ranger 
  :ensure t
  :init
  (setq ranger-show-hidden t))

(use-package evil-nerd-commenter
  :ensure t)

(use-package general
  :ensure t
  :config (general-define-key
  :states '(normal visual insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
  "SPC" '(helm-M-x :which-key "M-x")
  "c"  '(evilnc-comment-or-uncomment-lines :which-key "comment selection")
  "u"  '(evil-scroll-up :which-key "scroll up")
  "d"  '(evil-scroll-down :which-key "scroll down")
  "be"  '(eval-buffer :which-key "eval buffer")
  "pf"  '(helm-find-files :which-key "find files")
  "wl"  '(windmove-right :which-key "move right")
  "wh"  '(windmove-left :which-key "move left")
  "wk"  '(windmove-up :which-key "move up")
  "wj"  '(windmove-down :which-key "move bottom")
  "wV"  '(split-window-right :which-key "split right")
  "wS"  '(split-window-below :which-key "split bottom")
  "wx"  '(delete-window :which-key "delete window")
  "ad"  '(deer :which-key "deer")
  "ar"  '(ranger :which-key "ranger")
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (which-key use-package ranger helm general evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

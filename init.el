;;; -*- lexical-binding: t -*-

;; Default config
(setq inhibit-startup-message t
      visible-bell t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(display-time-mode t)
(menu-bar-mode -1)

;; Editor
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 2)
(setq js-indent-level 2)

(set-face-attribute 'default nil :font "Iosevka NFP" :height 180)

(setq display-line-numbers-type 'relative)
(column-number-mode)
(global-display-line-numbers-mode t)
(global-hl-line-mode 1)

;; Basic keybindings unneccesary use emacs keybinding
(global-set-key (kbd "<escape>")
                'keyboard-escape-quit) ;; only one escape key
(global-set-key (kbd "M-k")
                (kbd "C-a C-k C-k"))   ;; Cut current line

;; Default split behavior
(setq split-height-threshold nil
      split-width-threshold 0)

;; Packages
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			                 ("org" . "https://orgmode.org/elpa/")
			                 ("elpa" . "https://elpa.gnu.org/packages/" )))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-black-metal-gorgoroth t))

;; Company mode
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

;; Ivy 
(use-package ivy
  :ensure t
  :diminish ivy-mode
  :custom
  (ivy-use-virtual-buffers t)           ; recentf + bookmarks 
  (ivy-count-format "(%d/%d) ")         ; 5/120
  (ivy-height 10)                       ; minibuffer height
  :config
  (ivy-mode 1))

(use-package amx
  :ensure t
  :config
  (amx-mode 1))

(setq counsel-m-x-fzf-arguments "--tiebreak=begin,length")

;; M-x enchanment
(use-package counsel
  :ensure t
  :after ivy
  :bind
  (("M-x"          . counsel-M-x)
   ("C-x C-f"      . counsel-find-file)
   ("C-x b"        . counsel-switch-buffer)
   ("C-x C-r"      . counsel-recentf)
   ("C-h f"        . counsel-describe-function)
   ("C-h v"        . counsel-describe-variable)
   ("C-c g"        . counsel-git)
   ("C-c j"        . counsel-git-grep))
  :config
  (counsel-mode 1))

;; Search
(use-package swiper
  :ensure t
  :after ivy
  :bind ("C-s" . counsel-grep-or-swiper))

(use-package which-key
    :config
    (which-key-mode))

(use-package expand-region
  :ensure t
  :bind ("C-;" . er/expand-region))

;; Languages

;; Typescript
(use-package typescript-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package tide
  :after(typescript-mode flycheck))



;; ;; Treesitter
;; (setq treesit-language-source-alist
;;    '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
;;      (c "https://github.com/tree-sitter/tree-sitter-c")
;;      (go "https://github.com/tree-sitter/tree-sitter-go")
;;      (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
;;      (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))

;; (use-package treesit-auto
;;   :ensure t
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))



;; other stuff
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)





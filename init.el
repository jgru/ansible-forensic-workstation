;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq visible-bell t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enables basic packaging support
(require 'package)
;; (toggle-debug-on-error)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; Adds org archive
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))


;; Installs packages
;; define list of packages to install
(defvar myPackages
  '(
    elpy                            ;; Emacs Lisp Python Environment
 				    ;; https://github.com/millejoh/emacs-ipython-notebook
    org                             ;; org-mode
    flyspell                        ;; spell checking
    auto-complete                   ;; auto-completion feature
    yasnippet                       ;; template system
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GENERAL TWEAKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; speed up movement apparently : https://emacs.stackexchange.com/a/28746/8964
(setq auto-window-vscroll nil)
;; no startup msg
(setq inhibit-startup-message t)
;; inhibit start screen
(setq inhibit-startup-screen t)
;; No bell noise, just blinking
(setq visible-bell t)
;; Make emacs fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; UTF-8 All Things!
(prefer-coding-system 'utf-8)
;; Uppercase is same as lowercase
(define-coding-system-alias 'UTF-8 'utf-8)
;; Hide tool bar, never use it
(tool-bar-mode -1)
;; Hide menu bar, never use it either
(menu-bar-mode -1)
;; Change yes or no to y or n, cause im lazy
(fset 'yes-or-no-p 'y-or-n-p)
;; auto refresh files when changed from disk
(global-auto-revert-mode t)
;; Show column number
(column-number-mode t)
;; Don't have backups, cause YOLO
(setq backup-inhibited t)
;; one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
;; don't accelerate scrolling
(setq mouse-wheel-progressive-speed nil)
;; keyboard scroll one line at a time
(setq scroll-step 1)
;; this saves typing
(define-key global-map (kbd "RET") 'newline-and-indent)
;; echo to screen faster, cause why not
(setq echo-keystrokes 0.1)
;; Clean whitespace on save, pretty freken awesome
(add-hook 'before-save-hook 'whitespace-cleanup)
;;show-paren-mode allows one to see matching pairs of parentheses and other characters
(show-paren-mode t)

;; Default tab display is 4 spaces
(setq tab-width 4)
;; Don't save anything.
(setq auto-save-default nil)
;; show the function I'm in
(which-function-mode)
;; Enable line numbers globally
(global-linum-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org)

;; Make sure we see syntax highlighting
(setq org-src-fontify-natively t
      org-startup-folded t
      ;; See down arrow instead of "..." when we have subtrees
      org-ellipsis "⤵"
      ;; Make source code indent to list or whatever.
      org-src-preserve-indentation nil
      ;; Count all children TODO's not just direct ones
      org-hierarchical-todo-statistics nil
      ;; The right side of | indicates the DONE states
      org-todo-keywords '(
			  (sequence "TODO" "IN-PROGRESS" "PR-PHASE" "BLOCKED" "|" "DONE" "DELEGATED")
			  (sequence "|" "CANCELED")
			  )
      ;; Don't allow TODO's to close without their dependencies done
      org-enforce-todo-dependencies t
      ;; put timestamp when finished a todo
      org-log-done t
      ;; catch invisible edit
      org-catch-invisible-edits 'error
      )


(define-key global-map (kbd "C-c c") '(lambda () (interactive) (org-capture nil "t")))

(add-hook 'org-mode-hook
	  (lambda ()
	    (flyspell-mode t)
	    (toggle-truncate-lines -1)
	    (toggle-word-wrap 1)))


(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (java . t)
   (shell . t)
   (emacs-lisp . t)
   (dot . t)
   )
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flyspell
(require 'flyspell)
;; ;; unbind flyspell key-binding
(define-key flyspell-mode-map (kbd "C-;") nil)
(setq flyspell-mode-line-string "")

;; enable spell checking for text mode and disable for logs
(dolist (hook '(text-mode-hook prog-mode))
      (add-hook hook (lambda () (flyspell-mode 1))))
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs lisp
(add-hook 'emacs-lisp-mode 'enabled-paredit-mode)

;; Load yasnippet for template completion
(require 'yasnippet)
;; Enable yasnippet for all buffers
(yas-global-mode 1)


;; ====================================
;; Elpy python IDE development setup
;; ====================================
;; Enable elpy for python development
(elpy-enable)
(setq python-shell-interpreter "/usr/bin/python3"
      python-shell-interpreter-args "-i"
      elpy-rpc-python-command "/usr/bin/python3"
      elpy-rpc-virtualenv-path 'global)
;; Set jedi as backend
(setq elpy-rpc-backend "jedi")
(add-hook 'elpy-mode-hook
    (lambda ()
    (local-unset-key (kbd "M-TAB"))
    (define-key elpy-mode-map (kbd "C-M-i") 'elpy-company-backend)))
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

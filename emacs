;
;
;
;
;
; Configuration Empire on GNU/Emacs
;
;
;
;
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

; Activate installed packages
(package-initialize)

;;
; Style
(load-theme 'wombat)

(setq initial-scratch-message "")
(setq inhibit-startup-message t)

; no scroll
(scroll-bar-mode 0)

(tool-bar-mode 0)
(menu-bar-mode 1)

;;
; emacs vi layer
(ensure-package-installed 'evil)
(require 'evil)
(evil-mode 1);
(setq evil-default-state 'emacs)


; when I say kill - KILL.
(global-set-key [(control x) (k)] 'kill-this-buffer)

; ignore dotfiles ect
(add-hook 'dired-load-hook '(lambda () (require 'dired-x))) ; Load Dired X when Dired is loaded.
(setq dired-omit-mode t) ; Turn on Omit mode.

(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files
    (concat dired-omit-files "\\|^\\..+$"))

(ensure-package-installed 'magit)
(require 'magit)

; History
(savehist-mode 1)

;font
(set-face-attribute 'default nil :height 180)

;;
; swap buffers
(defun switch-to-previous-buffer ()
    (interactive)
    (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-c c") (lambda () (interactive) (switch-to-previous-buffer)))

;;
; drop shell for emacs rookies like me.
(global-set-key [f1] 'shell)

;;
; make
(setq compile-command "make")
(global-set-key (quote [f5]) (quote compile))

;;
; tramp mode rememeber my passwords in plaintext... shit.
(setq password-cache-expiry 28800) 

;;
; VC colors
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-hunk-header ((t (:forground "black")) (quote now)))
 '(diff-removed ((t (:foreground "Red")))))

;;
; kill other buffer
(fset 'kill-other
(lambda (&optional arg)
  "Keyboard macro."
  (interactive "p")
  (kmacro-exec-ring-item (quote ("ok0" 0 "%d"))
 arg)))
(global-set-key (kbd "C-c k") (quote kill-other))

;;
; tab in c
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux" c-basic-offset 4)
(setq-default tab-width 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(standard-indent 4))


;;
; Switch back to mini buffer
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)


(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/backups/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq tramp-backup-directory-alist backup-directory-alist)
(put 'dired-find-alternate-file 'disabled nil)

;;
; Force dired to not fork the buffer when you ^
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))


;;; COULD NOT GET THIS CONFIGURED TO MY TASTES    
;; auxtex
(ensure-package-installed 'auctex)
(load "auctex.el" nil t t)
(setq-default TeX-master nil)
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
(setq exec-path (append exec-path '("/Library/TeX/texbin")))
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))

;;
; Markdown    
(ensure-package-installed 'markdown-mode)    
(require 'markdown-mode)


;;
; Brew path for ispell
(setq exec-path (append "~/w/brew/bin/" exec-path))       

(setq ispell-program-name "~/w/brew//Cellar/aspell/0.60.6.1/bin/aspell")

(setq ediff-window-setup-function 'ediff-setup-windows-plain)    
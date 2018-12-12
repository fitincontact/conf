;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-save-default nil)
 '(auto-save-mode nil)
 '(column-number-mode t)
 '(compilation-read-command nil)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (djvu ztree yasnippet gotest go-scratch go-rename go-guru go-eldoc go-direx flycheck company-go)))
 '(scroll-bar-mode nil)
 '(setq show-paren-style t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; oracle sql mode
;;
;; code bellow much better ;; (add-hook 'sql-mode-hook 'sql-highlight-oracle-keywords)
(defun highlight-plsql ()
(when (and (stringp buffer-file-name)
            (string-match "\\.\\(psql\\|sql\\|spc\\|bdy\\|prc\\|pck\\|plsql\\|tpl\\)\\'" buffer-file-name))
       (sql-set-product 'oracle)
))
(defun highlight-mssql ()
(when (and (stringp buffer-file-name)
            (string-match "\\.tsql\\'" buffer-file-name))
       (sql-set-product 'ms)
))
(add-hook 'find-file-hook 'highlight-plsql)
(add-hook 'find-file-hook 'highlight-mssql)
(setq auto-mode-alist (append '(("\\.\\(psql\\|sql\\|spc\\|bdy\\|prc\\|pck\\|plsql\\|tpl\\|tsql\\)\\'" . sql-mode))
  auto-mode-alist))
;;--------------------------------------;;
;; System-type definition
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))
(defun system-is-windows()
  (string-equal system-type "windows-nt"))
(defun system-is-macosx()
  (string-equal system-type "darwin"))
;;systems
(if (system-is-linux) ;;
    (progn
        (setq default-buffer-file-coding-system 'utf-8)
        (setq-default coding-system-for-read    'utf-8)
        (setq file-name-coding-system           'utf-8)
        (set-selection-coding-system            'utf-8)
        (set-keyboard-coding-system        'utf-8-unix)
        (set-terminal-coding-system             'utf-8)
        (prefer-coding-system                   'utf-8)
	(set-language-environment 'UTF-8)
	)
  )
(if (system-is-windows)
(progn
        (prefer-coding-system                   'windows-1251)
        (set-terminal-coding-system             'windows-1251)
        (set-keyboard-coding-system        'windows-1251-unix)
        ;(set-selection-coding-system            'windows-1251)
        (setq file-name-coding-system           'windows-1251)
        (setq-default coding-system-for-read    'windows-1251)
        (setq default-buffer-file-coding-system 'windows-1251)

    	;; Force cp1251 be the first cyrillic enviroment
	(set-language-info-alist "Cyrillic-CP1251" `(
 		 (charset cyrillic-iso8859-5)
 		 (coding-system cp1251)
 		 (coding-priority cp1251)
 		 (input-method . "cyrillic-jcuken")
 		 (features cyril-util)
 		 (unibyte-display . cp1251)
 		 (sample-text . "Russian (Р СѓСЃСЃРєРёР№!)")
 		 (documentation . "Support for Cyrillic CP1251"))
   		 '("Cyrillic"))
	(set-language-environment 'Cyrillic-CP1251)

	(modify-coding-system-alist 'file "\\.*\\'" 'windows-1251)
	
	)
)
(if (system-is-macosx)
    (progn
      ;; OSX - Update the PATH to match that from the shell
(defun set-exec-path-from-shell-PATH ()
(let ((path-from-shell
(replace-regexp-in-string "[[:space:]\n]*$" ""
(shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
(setenv "PATH" path-from-shell)
(setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))
     )

 )
;; My name and e-mail adress
(setq user-full-name   "Vsevolod Fitin")
(setq user-mail-adress "fitincontact@gmail.com")
;;etc

;; Linum plugin
(require 'linum) ;;call Linum
(line-number-mode   t) ;;show line number in mode-line
(global-linum-mode  t) ;;show line numbers in all buffers
(column-number-mode t) ;;show column number in mode-line
(setq linum-format " %d") ;;set line number format
;; Fringe setting
;;(fringe-mode '(8 . 0)) ;;limit text on left only
(setq-default indicate-empty-lines t) ;;indicate empty line by glyph next to line number 
(setq-default indicate-buffer-boundaries 'left) ;;indicating on left side only
;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;;24-hour format in mode-line
(display-time-mode             t) ;;show time in mode line
(size-indication-mode          t) ;;file size per %
;; Line wrapping
(setq word-wrap          t)
;;(global-visual-line-mode t)
;; Undo/Redo
(global-set-key [(ctrl z)] 'undo)
(setq undo-limit         500000)
(setq undo-strong-limit  500000)
(setq undo-outer-limit 50000000)
;;
(fset 'yes-or-no-p 'y-or-n-p)
;; Color the code
(require 'font-lock)
(global-font-lock-mode t)
;; Tab, see http://superuser.com/questions/268029
(defvar just-tab-keymap (make-sparse-keymap) "Keymap for just-tab-mode")
(define-minor-mode just-tab-mode
   "Just want the TAB key to be a TAB"
   :global t :lighter " TAB" :init-value 0 :keymap just-tab-keymap
   (define-key just-tab-keymap (kbd "TAB") 'indent-for-tab-command))
(global-set-key (kbd "TAB") 'self-insert-command);
;; C-tab switchs to a next window
(global-set-key [(control tab)] 'other-window)
;; C-up
(global-set-key "\M-n" '(lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" '(lambda () (interactive) (scroll-down 1)))
(global-set-key [(control down)] '(lambda () (interactive) (scroll-up 1)))
(global-set-key [(control up)] '(lambda () (interactive) (scroll-down 1)))
(global-set-key [(meta down)] '(lambda () (interactive) (scroll-up 1)))
(global-set-key [(meta up)] '(lambda () (interactive) (scroll-down 1)))
;; copy current dir
;;    from dired mode
;;    to   external file ~/.emacs.d/cwd
;; dired
(require 'dired)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-dwim-target t)
(setq dired-listing-switches "-Aalhp")
(setq grep-find-command "find . -type f -name \"*.sql\" -exec grep -nHi -e \"Y\" \"{}\" \";\"")
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-ignore-case t)
;;(setq ls-lisp-verbosity '(links uid gid))
;!(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
;!(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map "c" 'dired-export-cwd)
(defun dired-export-cwd ()
  (interactive)
  (with-temp-file "~/\.emacs\.d/cwd"
    (insert default-directory)))
;; http://stackoverflow.com/questions/19907939/how-can-one-quickly-browse-through-lots-of-files-in-emacs
;; little modification to dired-mode that let's you browse through lots of files
(add-hook 'dired-mode-hook
  (lambda()
    ;(define-key dired-mode-map (kbd "C-o") 'dired-view-current)     ; was dired-display-file
    (define-key dired-mode-map (kbd "C-n")   'dired-view-next)           ; was dired-next-line
    (define-key dired-mode-map (kbd "C-p")   'dired-view-previous))) ; was dired-previous-line
(defun dired-view-next ()
  "Move down one line and view the current file in another window."
  (interactive)
  (dired-next-line 1)
  (dired-view-current))
(defun dired-view-previous ()
  "Move up one line and view the current file in another window."
  (interactive)
  (dired-previous-line 1)
  (dired-view-current))
(defun dired-view-current ()
  "View the current file in another window (possibly newly created)."
  (interactive)
  (if (not (window-parent))
      (split-window))                                   ; create a new window if necessary
  (let ((file (dired-get-file-for-visit))
        (dbuffer (current-buffer)))
    (other-window 1)                                          ; switch to the other window
    (unless (equal dbuffer (current-buffer))                 ; don't kill the dired buffer
      (if (or view-mode (equal major-mode 'dired-mode))   ; only if in view- or dired-mode
          (kill-buffer)))                                                    ; ... kill it
    (let ((filebuffer (get-file-buffer file)))
      (if filebuffer                              ; does a buffer already look at the file
          (switch-to-buffer filebuffer)                                    ; simply switch 
        (view-file file))                                                    ; ... view it
      (other-window -1))))                   ; give the attention back to the dired buffer
;; frame size
(add-to-list 'default-frame-alist '(left . 0)) ; 250
(add-to-list 'default-frame-alist '(top . 0))
;(add-to-list 'default-frame-alist '(height . 55))
;(add-to-list 'default-frame-alist '(width . 155)) ;; 1280x1024
;(add-to-list 'default-frame-alist '(height . 62))
;(add-to-list 'default-frame-alist '(width . 157)) ;; 1024x768
(add-to-list 'default-frame-alist '(height . 53))
(add-to-list 'default-frame-alist '(width . 177)) ;; 1440x900, 177 for left=0, 146

;;-diff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;(setq ediff-split-window-function 'split-window-vertically)
(setq ediff-split-window-function 'split-window-horizontally)
(defun my-diff (switch)
  (cond ((getenv "EMACS-TEST")
    (message "=== called from emacs"))
    )
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
  (ediff-files file1 file2)))
(add-to-list 'command-switch-alist '("-diff" . my-diff))
;;startup screen disable

;; Scrolling settings
(setq scroll-step               1) ;;up-down per 1 line
(setq scroll-margin            10) ;;move buffer up/down per 10 lines when cursor next to up/down bound
(setq scroll-conservatively 10000)
;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)
;;osx path

; ~/.emacs
;; === compile-command
;; http://www.emacswiki.org/emacs/CompileCommand
;; golang
(modify-coding-system-alist 'file "\\.go\\'" 'utf-8)
;; [F8] Run build
(defvar orig-compile-command "")
(defvar my-compile-command "")
(defun user-save-and-build ()
  "save and call compile as make all"
  (interactive)
  (save-buffer)
  (if (string= "" my-compile-command)
    (compile "build.bat" )
    (progn
     (setq orig-compile-command compile-command)
     (setq compile-command my-compile-command)
     (call-interactively 'compile)
     (setq compile-command orig-compile-command)))
  (message "build executed!"))
(global-set-key [f8] 'user-save-and-build)
;;gofmt
(global-set-key (kbd "<f9>") 'gofmt) 
;(defvar my-compile-command "")
(put 'my-compile-command 'safe-local-variable (lambda (x) t))
;;code structure
(global-set-key (kbd "<f10>") 'go-direx-switch-to-buffer)
;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t)
(setq imenu-use-popup-menu nil) ;;Imenu dialogs only in minibuffer
(global-set-key (kbd "<f6>") 'imenu)
;; Speedbar
(require 'speedbar)
(global-set-key (kbd "<f7>") 'speedbar)
;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")
;; Bookmark settings
(require 'bookmark)
(setq bookmark-save-flag t) ;;auto save bookmarks in file
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t)) ;;try look yp and open bookmarks file
(global-set-key (kbd "<f3>") 'bookmark-set) ;;create bookmarks
(global-set-key (kbd "<f4>") 'bookmark-jump) ;;jump to bookmark
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;;bookmarks menu
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;;save in .emacs.d
;;select & copy all
(defun select-all ()
  "select and save all"
  (interactive)
  (save-excursion
   (push-mark (point))
   (push-mark (point-max) nil t)
   (goto-char (point-min))
   (kill-ring-save (region-beginning) (region-end)))
  (message "all buffer content has been selected!"))
(global-set-key [f1] 'select-all)
;;scratch buffer
(setq initial-scratch-message "; M-x lisp-interaction-mode\n; C-j, C-M-x to evaluate\n\n")
;;changed on disk really edit the buffer 
;;https://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
(defun ask-user-about-supersession-threat (fn)
  "blatantly ignore files that changed on disk"
  )
(defun ask-user-about-lock (file opponent)
  "always grab lock"
   t)
 ;; Automatically reload files was modified by external program
(global-auto-revert-mode 1)

;;golang
(require 'company)
(require 'flycheck)
(require 'yasnippet)
(require 'go-eldoc)
(require 'company-go)
;;
(add-hook 'before-save-hook 'gofmt-before-save)
(setq-default gofmt-command "goimports")
;;
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
;;
(require 'company)
(require 'company-go)
(add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
;;
(require 'yasnippet)
(yas-reload-all)
(add-hook 'go-mode-hook 'yas-minor-mode)
;;
(require 'flycheck)
(add-hook 'go-mode-hook 'flycheck-mode)

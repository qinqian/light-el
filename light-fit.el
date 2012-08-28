(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))
(dolist (mode '(mouse-wheel-mode blink-cursor-mode
                menu-bar-mode    tool-bar-mode))
    (when (fboundp mode) (funcall mode -1)))

(display-time-mode 1)
(show-paren-mode 1)
(transient-mark-mode 1)
(winner-mode 1)

(global-whitespace-mode 1)
(global-whitespace-newline-mode 1)

(standard-display-ascii ?\t ">>")  ;; tabs show
(server-start)
;; setq-default, setq

(setq visible-bell t
      inhibit-startup-message t
      color-theme-is-global t
;      browse-url-browser-function 'browse-url-firefox ;;from starter
      sentence-end-double-space nil
      shift-select-mode nil
      mouse-yank-at-point t
      uniquify-buffer-name-style 'forward
      whitespace-style '(face trailing lines-tail tabs)
      show-trailing-whitespace t
      tooltip-delay 1.5
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      make-backup-files nil
      bookmark-default-file "~/.emacs.d/.bookmarks.el"
      buffers-menu-max-size 30
      case-fold-search t
      compilation-scroll-output t
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain
      grep-highlight-matches t
      grep-scroll-output t
      indent-tabs-mode nil
      line-spacing 0.2
      mouse-yank-at-point t
      set-mark-command-repeat-pop t
      truncate-lines nil
      truncate-partial-width-windows nil
      column-number-mode t
      kill-ring-max 200
      fill-column 79 ; up to pep8
      user-full-name "Qin Qian"
      user-mail-address "qinqianhappy@gmail.com"
      x-select-enable-clipboard t
      mouse-avoidance-mode 'animate
      password-cache-expiry nil)

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)
;; etags, emerge
(setq emerge-diff-options "--ignore-all-space") ; ignore white-space

;; Use C-f during file selection to switch to regular find-file
(ido-mode t)
(ido-everywhere t)
(setq ido-ubiquitous t)
(ido-ubiquitous-mode t)

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

(add-hook 'write-file-hooks 'time-stamp)
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(setq time-stamp-format                           
" modified by %:u :%04y-%02m-%02d %02H:%02M:%02S"
      time-stamp-active t
      time-stamp-warn-inactive t)

;; fset
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'auto-tail-revert-mode 'tail-mode)

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

(require 'autopair)
(setq autopair-autowrap t)
(autopair-global-mode t)

(require 'smart-tab)
(global-smart-tab-mode t)

(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

(require 'switch-window)

(smex-initialize)

;; anything
(mapc 'require '(anything-config
                   anything
                   anything-complete
                   anything-gtags
                   anything-obsolete
                   ))

(provide 'light-fit)

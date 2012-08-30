(defun maybe-byte-compile ()
  (when (and (eq major-mode 'emacs-lisp-mode)
             buffer-file-name
             (string-match "\\.el$" buffer-file-name)
             (not (string-match "\\.dir-locals.el$" buffer-file-name)))
    (save-excursion (byte-compile-file buffer-file-name))))

(add-hook 'after-save-hook 'maybe-byte-compile)

(defun light-lisp-minor ()
  (turn-on-pretty-mode)
  (enable-paredit-mode))

(defun set-up-hippie-expand-for-elisp ()
  "Locally set `hippie-expand' completion functions for use with Emacs Lisp."
  (make-local-variable 'hippie-expand-try-functions-list)
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-lisp-symbol t)
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-lisp-symbol-partially t))

(let* ((elispy-hooks '(emacs-lisp-mode-hook
                       ielm-mode-hook))
       (lispy-hooks (append elispy-hooks '(lisp-mode-hook
                                           inferior-lisp-mode-hook
                                           lisp-interaction-mode-hook))))
  (dolist (hook lispy-hooks)
    (add-hook hook 'light-lisp-minor))
  (dolist (hook elispy-hooks)
    (add-hook hook 'set-up-hippie-expand-for-elisp)))

;; slime-mode
(add-auto-mode 'lisp-mode "\\.cl$")
(require 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(slime-setup)

(provide 'light-lisp)

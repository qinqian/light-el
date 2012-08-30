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

;; use slime-autoloads instead of slime to start server
;; slime-fuzzy has loaded problems
(require 'slime-autoloads)
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(eval-after-load 'slime
  '(progn
     (add-to-list 'load-path (concat (dir-of-lib2 "slime") "/contrib"))
     (setq slime-protocol-version 'ignore)
     (add-hook 'slime-mode-hook 'pretty-mode)
     (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
     (slime-setup '(slime-repl))
;     (setq slime-complete-symbol*-fancy t)
;     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;
     ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
     (defun override-slime-repl-bindings-with-paredit ()
       (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil))
     (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit t)))

(provide 'light-lisp)

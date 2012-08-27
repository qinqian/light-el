;; key bindings

(progn
  ;; It's all about the project.
  (global-set-key (kbd "C-c f") 'find-file-in-project)

  ;; You know, like Readline.
  (global-set-key (kbd "C-M-h") 'backward-kill-word)
  (global-set-key [remap backward-up-list] 'backward-up-sexp) ; C-M-u, C-M-up

  ;; Completion that uses many different methods to find options.
  (global-set-key (kbd "M-/") 'hippie-expand)

  ;; Turn on the menu bar for exploring new modes
  (global-set-key (kbd "C-<f10>") 'menu-bar-mode)
  (global-set-key (kbd "C-<f9>")  'tool-bar-mode)

  ;; Font size
  (define-key global-map (kbd "C-+") 'text-scale-increase)
  (define-key global-map (kbd "C--") 'text-scale-decrease)

  ;; Use regex searches by default.
  (global-set-key (kbd "C-s") 'isearch-forward-regexp)
  (global-set-key (kbd "\C-r") 'isearch-backward-regexp)
  (global-set-key (kbd "M-%") 'query-replace-regexp)
  (global-set-key (kbd "C-M-s") 'isearch-forward)
  (global-set-key (kbd "C-M-r") 'isearch-backward)
  (global-set-key (kbd "C-M-%") 'query-replace)

  ;; Jump to a definition in the current file. (Protip: this is awesome.)
  (global-set-key (kbd "C-x C-i") 'imenu)

  ;; File finding
  (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
  (global-set-key (kbd "C-c y") 'bury-buffer)
  (global-set-key (kbd "C-c r") 'revert-buffer)

  ;; Window switching. (C-x o goes to the next window)
  (windmove-default-keybindings) ;; Shift+direction

  ;; Start eshell or switch to it if it's active.
  (global-set-key (kbd "C-x m") 'eshell)

  ;; Start a new eshell even if one is active.
  (global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

  ;; Start a regular shell if you prefer that.
  (global-set-key (kbd "C-x C-m") 'shell)

  ;; If you want to be able to M-x without meta (phones, etc)
  (global-set-key (kbd "C-c x") 'execute-extended-command)

  ;; M-S-6 is awkward
  (global-set-key (kbd "C-c j") 'join-line)

  ;; So good!
  (global-set-key (kbd "C-c g") 'magit-status)
  
  (global-set-key "\C-co" 'occur)

  ;; auto-complete-mode
  (global-set-key (kbd "C-<f7>") 'auto-complete-mode)

  ;; insert time
  (global-set-key (kbd "C-c t") 'insert-time)

  ;; ibuffer
  (global-set-key (kbd "C-c b") 'ibuffer)

  (global-unset-key "\C-xf")
  )

;; C-w and M-w for cut and copy current line
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

(defun suspend-mode-during-cua-rect-selection (mode-name)
  "Add an advice to suspend `MODE-NAME' while selecting a CUA rectangle."
  (let ((flagvar (intern (format "%s-was-active-before-cua-rectangle" mode-name)))
        (advice-name (intern (format "suspend-%s" mode-name))))
    (eval-after-load 'cua-rect
      `(progn
         (defvar ,flagvar nil)
         (make-variable-buffer-local ',flagvar)
         (defadvice cua--activate-rectangle (after ,advice-name activate)
           (setq ,flagvar (and (boundp ',mode-name) ,mode-name))
           (when ,flagvar
             (,mode-name 0)))
         (defadvice cua--deactivate-rectangle (after ,advice-name activate)
           (when ,flagvar
             (,mode-name 1)))))))

(suspend-mode-during-cua-rect-selection 'whole-line-or-region-mode)

(provide 'light-key)

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
;  (global-set-key (kbd "C-c y") 'bury-buffer)
;  (global-set-key (kbd "C-c r") 'revert-buffer)

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
  (global-set-key (kbd "C-x C-b") 'ibuffer)

  (global-unset-key "\C-xf")
  
  ;; smex
  ;; M-x for ido 
  (global-set-key "\M-x" 'smex)

  ;; recent file
  (global-set-key [(meta f11)] 'steve-ido-choose-from-recentf)
  ;; anything
  (global-set-key [(meta f9)] 'anything)

  ;; show other-buffer in new window
  (global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
  (global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))

  ;; bookmark
  (global-set-key (kbd "C-<f11>") 'bookmark-set)
  (global-set-key (kbd "C-<f12>") 'bookmark-jump)

  ;; whitespace tabs visual
  (global-set-key (kbd "C-x W") 'whites-color)
  (global-set-key [(C-f5)] 'speedbar)

  ;; lisp map keys
  (define-key lisp-mode-map (kbd "C-c l") 'lispdoc)
  ;; other maps keys
  ;; learn from emacs lisp programming

  ;; appearance
  (global-set-key (kbd "M-C-8") '(lambda () (interactive) (adjust-opacity nil -5)))
  (global-set-key (kbd "M-C-9") '(lambda () (interactive) (adjust-opacity nil 5)))
  (global-set-key (kbd "M-C-0") '(lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))

  ;; comment easy key
  (global-set-key (kbd "M-;") 'comment-line) ;;problem
  )

(provide 'light-key)

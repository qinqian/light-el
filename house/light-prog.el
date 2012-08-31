(require 'yasnippet)
(yas-global-mode t)


(require 'cedet)
(require 'srecode)

(semantic-mode 1)
;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(setq semanticdb-project-roots
    (list
        (expand-file-name "/")))

;; Turn on CEDET's fun parts
(setq semantic-load-turn-useful-things-on t)

; Enable template insertion menu
(global-srecode-minor-mode 1)

;;; Enable EDE (Project Management) features
(global-ede-mode 1)

;(require 'cogre)
;(require 'cedet-contrib)

;; change ecb.el futition to function
;; http://stackoverflow.com/questions/8833235/install-ecb-with-emacs-starter-kit-in-emacs-24
(add-to-list 'load-path (concat user-emacs-directory "el-get/ecb"))
(require 'ecb)
(setq stack-trace-on-error nil)
(setq ecb-auto-activate nil
      ecb-tip-of-the-day nil)

;; hide and show
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;; collect programming config

(require 'light-r)
(require 'light-py)
(require 'light-lisp)
(require 'light-net)
(require 'light-eclim)
(require 'light-flys)

(provide 'light-prog)

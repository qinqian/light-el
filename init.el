;; init.el
(setq debug-on-error t)

(defvar light-dir (file-name-directory load-file-name)
  "root dir of emacs config")
(setq light-vendor (concat light-dir "vendor/")
      light-house (concat light-dir "house/"))

(message "Hello, %s" (getenv "USER"))
(message "emacs setting in %s" light-dir)

(add-to-list 'load-path light-dir)

;; basic setting
(mapc 'require '(light-def
		 light-el
		 light-fit
		 light-r
		 light-py
     light-lisp
		 light-pub
		 light-key
     light-save
     light-eclim
     ))

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'light-osx))
;; Linux specific
(when (eq system-type 'gnu/linux)
  (require 'cl))

;; customize
(setq custom-file (concat light-dir "custom.el"))
(when (not (file-exists-p custom-file))
  (shell-command (concat "touch " custom-file)))
(load custom-file)

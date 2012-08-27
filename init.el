;; init.el
(defvar light-dir (file-name-directory load-file-name)
  "root dir of emacs config")

(defvar light-vendor (concat light-dir "vendor/")
  "house latest tools")

(defvar light-house (concat light-dir "house/")
  "self update lisp")

(message "Hello, %s" (getenv "USER"))
(message "emacs setting in %s" light-dir)

(add-to-list 'load-path light-dir)

(require 'light-def)
(require 'light-el)
(require 'light-fit)

(require 'light-r)
(require 'light-py)

(require 'light-key)

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

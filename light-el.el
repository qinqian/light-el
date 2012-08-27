;; get packages from elpa and el-get
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar elpa-packages '(ess ibuffer ido whole-line-or-region autopair diminish magit find-file-in-project popup smart-tab flymake-python-pyflakes save-visited-files color-theme-solarized auctex muse maxframe)
  "A list of packages to ensure are installed at launch.")

(dolist (p elpa-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq
 el-get-sources
 '(el-get				; el-get is self-hosting
   switch-window			; takes over C-x o
   ac-R
   (:name smex				; a better (ido like) M-x
	  :after (lambda ()
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name goto-last-change		; move pointer back to last change
	  :after (lambda ()
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))
  ; (:name lisppaste        :type elpa)
   (:name emacs-goodies-el :type apt-get)
   ))

(unless (string-match "apple-darwin" system-configuration)
  (loop for p in '(color-theme		; nice looking emacs
                color-theme-tango
		   anything
		   )
	do (add-to-list 'el-get-sources p)))

(when (el-get-executable-find "cvs")
  (add-to-list 'el-get-sources 'emacs-goodies-el)) ; the debian addons for emacs

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   )
	do (add-to-list 'el-get-sources p)))

(when (el-get-executable-find "git")
  (loop for p in '(auto-complete    		; M-x svn-status
		   )
	do (add-to-list 'el-get-sources p)))
(setq my-packages
      (append
       '(el-get switch-window nxhtml)
        (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

;; vendor
(light-load light-vendor)
(light-load light-house)


(provide 'light-el)

;; net config
;; javascript
(require 'light-js)  
;; nxml-mode from http://www.thaiopensource.com/download/
;; NxhtmlMode is a mode derived from nxml-mode, specialized for editing XHTML and template languages like php
(load-library "rng-auto")
(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                   'nxml-mode))

;;1. This works if you never edit html in emacs with anything other than nxml-mode. – DougRansom
;(fset 'html-mode 'nxml-mode)
;(defalias 'xml-mode 'nxml-mode)
;(setq magic-mode-alist
;      (cons '("<＼＼?xml " . nxml-mode)
;            magic-mode-alist))
;;2. Use nxml-mode instead of sgml, xml or html mode.
;; default magic-mode-alist is nil, use auto-mode-alist for below
(mapc
 (lambda (pair)
   (if (or (eq (cdr pair) 'xml-mode)
           (eq (cdr pair) 'sgml-mode)
           (eq (cdr pair) 'html-mode))
       (setcdr pair 'nxml-mode)))
; magic-mode-alist)
 auto-mode-alist)

;; xml flyspell
;; need some package
;(add-to-list 'flyspell-prog-text-faces 'nxml-text-face)
;;---------------------------------------------------------------
;;; Colourise CSS colour literals using rainbow or css-color-mode
(autoload 'rainbow-turn-on "rainbow-mode" "Enable rainbow mode colour literal overlays")
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
  (add-hook hook 'rainbow-turn-on)
  (add-hook hook 'css-color-mode))

(defun maybe-flymake-css-load ()
  "Activate flymake-css as necessary, but not in derived modes."
  (when (eq major-mode 'css-mode)
    (flymake-css-load)))

(add-hook 'css-mode-hook 'maybe-flymake-css-load)

(eval-after-load 'auto-complete
  '(progn
     (dolist (hook '(css-mode-hook sass-mode-hook))
       (add-hook hook 'ac-css-mode-setup))))

;;; html5 support from https://github.com/hober/html5-el
(eval-after-load 'rng-loc
  '(progn
    (require 'whattf-dt)
    (push (expand-file-name "schemas.xml" (dir-of-lib2 "whattf-dt"))
          rng-schema-locating-files)))

(setq nxml-slash-auto-complete-flag t)  ;; not predefined
(setq nxml-bind-meta-tab-to-complete-flag t)

;;----------------------------------------------------------------------------
;; Integration with tidy for html + xml
;;----------------------------------------------------------------------------
(add-hook 'nxml-mode-hook (lambda () (tidy-build-menu nxml-mode-map)))
(add-hook 'html-mode-hook (lambda () (tidy-build-menu html-mode-map)))

(add-auto-mode 'html-mode "\\.(jsp|tmpl)$")

(provide 'light-net)

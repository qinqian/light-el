;; net config
;; nxml-mode for xml and html 
;; NxhtmlMode is a mode derived from nxml-mode, specialized for editing XHTML and template languages like php
 (add-to-list 'auto-mode-alist
              (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                    'nxml-mode))
;;This works if you never edit html in emacs with anything other than nxml-mode. – DougRansom
(fset 'html-mode 'nxml-mode)
(defalias 'xml-mode 'nxml-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
            magic-mode-alist))
;;; Use nxml-mode instead of sgml, xml or html mode.
;; default magic-mode-alist is nil, use auto-mode-alist for below
(mapc
 (lambda (pair)
   (if (or (eq (cdr pair) 'xml-mode)
           (eq (cdr pair) 'sgml-mode)
           (eq (cdr pair) 'html-mode))
       (setcdr pair 'nxml-mode)))
 magic-mode-alist)

;; xml flyspell
;; need some package
;(add-to-list 'flyspell-prog-text-faces 'nxml-text-face)
;;---------------------------------------------------------------
;;---------------------------------------------------------------

(require 'light-js)  

;;; Colourise CSS colour literals
(autoload 'rainbow-turn-on "rainbow-mode" "Enable rainbow mode colour literal overlays")
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
  (add-hook hook 'rainbow-turn-on))

(defun maybe-flymake-css-load ()
  "Activate flymake-css as necessary, but not in derived modes."
  (when (eq major-mode 'css-mode)
    (flymake-css-load)))

(add-hook 'css-mode-hook 'maybe-flymake-css-load)

(eval-after-load 'auto-complete
  '(progn
     (dolist (hook '(css-mode-hook sass-mode-hook))
       (add-hook hook 'ac-css-mode-setup))))

(provide 'light-net)

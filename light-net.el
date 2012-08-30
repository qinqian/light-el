(add-auto-mode (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                'nxml-mode))
(fset 'html-mode 'nxml-mode)
(fset 'xml-mode 'nxml-mode)

(add-hook 'nxml-mode-hook (lambda ()
                            (set (make-local-variable 'ido-use-filename-at-point) nil)))
(setq nxml-slash-auto-complete-flag t)

(provide 'light-net )

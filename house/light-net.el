;; net config
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

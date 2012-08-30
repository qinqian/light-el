(require 'anything-R)
(require 'ac-R)
(require 'ess-site)
(require 'ess-eldoc)

;; ESS for R customization begins here:
(setq inferior-ess-own-frame nil)
(setq inferior-ess-same-window nil)
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")

(defun my-ess-eval ()
  (interactive)
  (if (and transient-mark-mode mark-active)
        (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))

(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(return)] 'my-ess-eval)))

(setq ess-use-auto-complete t)
(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; ac faces
(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")
(setq 
      ;; ac-auto-show-menu 1
      ;; ac-candidate-limit nil
      ;; ac-delay 0.1
      ;; ac-disable-faces (quote (font-lock-comment-face font-lock-doc-face))
      ;; ac-ignore-case 'smart
      ;; ac-menu-height 10
      ;; ac-quick-help-delay 1.5
      ;; ac-quick-help-prefer-pos-tip t
      ;; ac-use-quick-help nil
)

(provide 'light-r)

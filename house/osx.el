(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)
(setq default-input-method "MacOSX")
;; Make mouse wheel / trackpad scrolling less jerky
(setq mouse-wheel-scroll-amount '(0.001))
;; Woohoo!!
(global-set-key (kbd "M-`") 'ns-next-frame)
(global-set-key (kbd "M-h") 'ns-do-hide-emacs)
(eval-after-load 'nxml-mode
    '(define-key nxml-mode-map (kbd "M-h") nil))
(global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports
(global-set-key (kbd "M-c") 'ns-copy-including-secondary)
(global-set-key (kbd "M-v") 'ns-paste-secondary)

;; Show iCal calendars in the org agenda
(when *is-a-mac*
  (eval-after-load "org"
    '(if *is-a-mac* (require 'org-mac-iCal)))
  (setq org-agenda-include-diary t)

  (setq org-agenda-custom-commands
        '(("I" "Import diary from iCal" agenda ""
           ((org-agenda-mode-hook
             (lambda ()
               (org-mac-iCal)))))))

  (add-hook 'org-agenda-cleanup-fancy-diary-hook
            (lambda ()
              (goto-char (point-min))
              (save-excursion
                (while (re-search-forward "^[a-z]" nil t)
                  (goto-char (match-beginning 0))
                  (insert "0:00-24:00 ")))
              (while (re-search-forward "^ [a-z]" nil t)
                (goto-char (match-beginning 0))
                (save-excursion
                  (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
                (insert (match-string 0)))))
  )


(provide 'light-osx)

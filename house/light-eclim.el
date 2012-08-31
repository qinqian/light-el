(require 'eclim)
(require 'eclimd)
(setq eclim-auto-save t)
(global-eclim-mode)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; eclim autocomplete
(require 'ac-emacs-eclim-source)
(add-hook 'eclim-mode-hook (lambda ()
                             (add-to-list 'ac-sources 'ac-source-emacs-eclim)
                             (add-to-list 'ac-sources 'ac-source-emacs-eclim-c-dot)))

(require 'eclimd)
(custom-set-variables
 '(eclim-eclipse-dirs '("~/Codes/eclipse"))
 '(eclimd-default-workspace "~/eclipse/")
 '(eclimd-wait-for-process nil)
 '(eclimd-executable "~/Codes/eclipse/eclimd")
 '(eclim-executable "~/Codes/eclipse/eclim"))

(provide 'light-eclim)

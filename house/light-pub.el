(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))


;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

(eval-after-load 'org
  '(progn
     (require 'org-exp)
     (require 'org-clock)
  ;  (require 'org-checklist)
     (require 'org-fstree)))

(add-hook 'org-mode-hook 'inhibit-autopair)

(setq org-publish-project-alist
     '(("org"
        :base-directory "~/Documents/DailyNotes"
        :publishing-directory "~/public_html"
        :section-numbers nil
        :table-of-contents nil
        )))
        ;:style "<link rel=\"stylesheet\"
        ;       href=\"../other/mystyle.css\"
        ;       type=\"text/css\"/>")))

;; -- Display images in org mode
(iimage-mode)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))

;; muse, auctex

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))
(add-to-list 'auto-mode-alist '("\\.tex$" . tex-mode))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))
(add-hook 'LaTeX-mode-hook (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")))

(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'linum-mode))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))

(require 'muse-mode)
(require 'muse-html)     ; load publishing styles I use
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)  ; publish files in projects
(setq muse-project-alist
        '(("website" ("~/Pages" :default "index")
                (:base "html" :path "~/public_html")
                 (:base "pdf" :path "~/public_html/pdf"))))

;;markdown
(autoload 'markdown-mode "markdown-mode" "Mode for editing Markdown documents" t)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)$" . markdown-mode) auto-mode-alist))

(provide 'light-pub)

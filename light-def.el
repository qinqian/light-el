;; defuns


;; edit
;; evil
(defun eviler ()
    (interactive)
    (evil-mode 1))
(defun bye-eviler ()
    (interactive)
    (funcall evil-mode -1))

;; whitespace
(defun whites-color ()
    (require 'whitespace)
    (interactive)
    (setq-default whitespace-line-column 80)        ;; 80 rule for programming
    (setq-default whitespace-style
                  '(face lines
                         trailing newline-mark
                         ))
    (custom-set-faces
     '(light-tab-face
       ((((class color)) (:background "gainsboro"))) t)   ;; tab color
     '(light-trailing-space-face
       ((((class color)) (:background "LightGreen"))) t)  ;; line ends color
     '(light-long-line-face
       ((((class color)) (:background "RosyBrown"))) t))
       ;; lines longer than 80 color
    (add-hook 'font-lock-mode-hook
              (function
               (lambda ()
                 (setq font-lock-keywords
                       (append font-lock-keywords
                               '(("\t+" (0 'light-tab-face t))
                                 ("^.\\{80,\\}$" (0 'light-long-line-face t))
                                 ("[ \t]+$"
                                  (0 'light-trailing-space-face t))))))))
    (global-whitespace-newline-mode t))        

(defun whites-simple ()
  (interactive)
  ;; handy
  (setq-default show-trailing-whitespace t)      ;; highlight show line ends
  (standard-display-ascii ?\t "\|/")  ;; tabs show as \|/, easy to count 
  )

(defmacro whites-off ()
  `(whitespace-mode -100))

(defun split-window-func-with-other-buffer (split-function)
  (lexical-let ((s-f split-function))
    (lambda ()
      (interactive)
      (funcall s-f)
      (set-window-buffer (next-window) (other-buffer)))))

(defun steve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (if (and ido-use-virtual-buffers (fboundp 'ido-toggle-virtual-buffers))
      (ido-switch-buffer)
    (find-file (ido-completing-read "Open file: " recentf-list nil t))))

(defun inhibit-autopair ()
  "Prevent autopair from enabling in the current buffer."
  (setq autopair-dont-activate t)
  (autopair-mode -1))

(defun my-insert-image (image-file)
  (interactive "fImage File: ")
  (insert-image (create-image image-file)))

(defun org-turn-on-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (iimage-mode)
  (set-face-underline-p 'org-link nil))

(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (call-interactively 'iimage-mode))

(defun insert-time ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

;; net 
(defun get-git (url)
  "TO DO READ el-get"
  (interactive)
  (message "Get latest vendor %s" url)
  (shell-command
   (concat "git")))
  
(defun refresh-vendor ()
  "TO DO, add submodule"
  (interactive)
  (message "Updating git modules")
  (shell-command "cd ~/.emacs.d/vendor && git pull"))

(defun google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
       (read-string "Google: "))))))

;; sudo
(defun sudo (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; exercise
(defun fill-test(&optional arg)
     (if (> arg fill-column)
      (message "larger")
      (message "less")))

(defun cuscounter (var)
     (setq var (+ 1 var)))

(defmacro inc (var) 
     (list 'setq var (list '1+ var)))
(defun a(number)
    (interactive "p")
    (message "%d" (* 3 number)))

(eval-when-compile (require 'cl))
(defun light-load (dir)
  "load all directories under the dir"
  (if (fboundp 'normal-top-level-add-to-load-path)
      (let* ((lisp-dir dir) 
             (default-directory lisp-dir))
        (progn
          (setq load-path
                (append
                 (loop for d in (directory-files lisp-dir)
                       unless (string-match "^\\." d)
                       collecting (expand-file-name d))
                 load-path))))))

(defun bubu(n)
  "buffer item, b, B"
   (interactive "B")
   (message-box "%s" n))

(defun filee(n)
  "file item, f, F"
  (interactive "F")
  (setq a_list '(1 2 3))
  (setq back `(1 2 ,(+ 1 2) ,@a_list))
  (setq uu `(use the words ,@(cdr a_list) as elements))
  (message "%s %s" n back uu))

;; program
(defun javaeval ()
  "compile and run java in common ways, since jdee
is hard to install especially with newest cedet"
  (interactive)
  (message "compiling %s" (current-buffer)))

(defun easy_py(n)
  (interactive "b")
  (message "%s" n))

(provide 'light-def)

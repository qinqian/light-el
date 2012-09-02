; defuns
;; appearance
;; opacity
(defun adjust-opacity (frame incr)
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))

;; lor and opaque
(defun light ()
  "Activate a light color theme."
  (interactive)
  (if (boundp 'custom-enabled-themes)
      (custom-set-variables '(custom-enabled-themes '(solarized-light)))))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (if (boundp 'custom-enabled-themes)
      (custom-set-variables '(custom-enabled-themes '(solarized-dark)))
))

;; edit
;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(defun suspend-mode-during-cua-rect-selection (mode-name)
  "Add an advice to suspend `MODE-NAME' while selecting a CUA rectangle."
  (let ((flagvar (intern (format "%s-was-active-before-cua-rectangle" mode-name)))
        (advice-name (intern (format "suspend-%s" mode-name))))
    (eval-after-load 'cua-rect
      `(progn
         (defvar ,flagvar nil)
         (make-variable-buffer-local ',flagvar)
         (defadvice cua--activate-rectangle (after ,advice-name activate)
           (setq ,flagvar (and (boundp ',mode-name) ,mode-name))
           (when ,flagvar
             (,mode-name 0)))
         (defadvice cua--deactivate-rectangle (after ,advice-name activate)
           (when ,flagvar
             (,mode-name 1)))))))

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
  (shell-command "cd ~/.emacs.d && git submodule foreach 'git pull'"))

(defun google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
       (read-string "Google: "))))))

(defun lispdoc ()
  ;; From http://bc.tech.coop/blog/070515.html
  "Searches lispdoc.com for SYMBOL, which is by default the symbol currently under the curser"
  (interactive)
  (let* ((word-at-point (word-at-point))
         (symbol-at-point (symbol-at-point))
         (default (symbol-name symbol-at-point))
         (inp (read-from-minibuffer
               (if (or word-at-point symbol-at-point)
                   (concat "Symbol (default " default "): ")
                 "Symbol (no default): "))))
    (if (and (string= inp "") (not word-at-point) (not
                                                   symbol-at-point))
        (message "you didn't enter a symbol!")
      (let ((search-type (read-from-minibuffer
                          "full-text (f) or basic (b) search (default b)? ")))
        (browse-url (concat "http://lispdoc.com?q="
                            (if (string= inp "")
                                default
                              inp)
                            "&search="
                            (if (string-equal search-type "f")
                                "full+text+search"
                              "basic+search")))))))

;; manage
(defun sudo (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun dir-of-lib1 (lib-name)
  """first version use default function,
  find-library will open the *.el files"""
  (expand-file-name (directory-file-name (buffer-name (find-library lib-name)))))

(defun dir-of-lib2 (lib-name)
  """second, use find-func library, only name"""
  ;; (require 'find-func)
  (autoload 'find-library-name "find-func")
  (file-name-as-directory (file-name-directory (find-library-name lib-name))))


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
  (interactive "b"))

(fset 'comment-line
      [?\C-a ?\C-  ?\C-e ?\M-\;])

(provide 'light-def)

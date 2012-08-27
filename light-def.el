;; defuns

;; insert image
(defun my-insert-image (image-file)
  (interactive "fImage File: ")
  (insert-image (create-image image-file)))

(defun insert-time ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

(defun get-git (url)
  (interactive)
  (message "Get latest vendor %s" url)
  (shell-command
   (concat "git")))
  
(defun refresh-vendor ()
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

(defun sudo (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun fill-test(&optional arg)
     (if (> arg fill-column)
      (message "larger")
      (message "less")))

(defun inhibit-autopair ()
  "Prevent autopair from enabling in the current buffer."
  (setq autopair-dont-activate t)
  (autopair-mode -1))

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

(provide 'light-def)

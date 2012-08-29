(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

(eval-after-load 'python
  '(require 'flymake-python-pyflakes))

(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook (lambda () (if (buffer-file-name)
                                           (flymake-mode))))
(provide 'light-py)

;;; packages.el --- my-spacemacs-layer layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: jackkamm <jackkamm@Amalthea>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `my-spacemacs-layer-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-spacemacs-layer/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-spacemacs-layer/pre-init-PACKAGE' and/or
;;   `my-spacemacs-layer/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-spacemacs-layer-packages
  '(
    (org :location built-in)
    (ob :location built-in)
    (tramp-sh :location built-in)
    multi-term
    ess
    )
  "The list of Lisp packages required by the my-spacemacs-layer layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun my-spacemacs-layer/pre-init-org ()
  ;(setq org-startup-indented t)
  ;(setq org-directory "~/Dropbox/orgfiles")
  ;(setq org-agenda-files (list org-directory))
  (setq org-export-backends '(ascii html icalendar latex beamer))
  )

(defun my-spacemacs-layer/pre-init-ob ()
  ;; for tangling makefiles, tabs must be preserved
  ;; (set this with a file-local-variable instead)
  ;(setq org-src-preserve-indentation t)

  ;; don't ask to evaluate babel src code
  (setq org-confirm-babel-evaluate nil)

  (setq org-babel-load-languages
        '((R . t)
          (python . t)
          (emacs-lisp . t)
          (shell . t)
          ))
  )

(defun my-spacemacs-layer/pre-init-tramp-sh ()
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (with-eval-after-load 'tramp-sh
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
  )

(defun my-spacemacs-layer/init-tramp-sh () ())

(defun my-spacemacs-layer/post-init-multi-term ()
  (with-eval-after-load 'multi-term
    ;; allow Alt+Backspace in terminal
    (add-to-list 'term-bind-key-alist '("M-DEL" . (lambda () (interactive) (term-send-raw-string "\e\d"))))
    )
  )

(defun my-spacemacs-layer/pre-init-ess ()
  (add-hook 'ess-mode-hook
            (lambda ()
              (ess-toggle-underscore nil)))
  )
;;; packages.el ends here

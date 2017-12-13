(defconst my-spacemacs-layer-packages
  '(
    helm
    (tramp-sh :location built-in)
    multi-term
    avy
    evil
    ess
    auctex
    evil-matchit
    persp-mode
    org
    dired-mode
    ;;ob-ipython
    mu4e
    ))

(defun my-spacemacs-layer/post-init-mu4e ()
  ;; override the mu4e "j" binding
  ;; TODO complain/PR/add mu4e-layer-variable?
  (with-eval-after-load 'mu4e
    (evilified-state-evilify-map mu4e-main-mode-map
      :mode mu4e-main-mode)))

(defun my-spacemacs-layer/post-init-dired ()
  ;; TODO submit PR?
  ;; enables a bunch of nice keys in dired-mode (/,v,G)
  (evilified-state-evilify-map dired-mode-map
    :mode dired-mode)
  )

(defun my-spacemacs-layer/pre-init-helm ()
  ;; make helm work better with tramp
  (setq helm-buffer-skip-remote-checking t)
  )

(defun my-spacemacs-layer/post-init-persp-mode ()
  ;; Fix weird behavior of make-frame caused by persp-mode
  ;; https://github.com/Bad-ptr/persp-mode.el/issues/36
  ;; https://github.com/syl20bnr/spacemacs/issues/6117
  (setq persp-init-frame-behaviour (lambda (frame &optional new-frame-p) nil))
  ;;(setq persp-init-frame-behaviour nil)
  )

(defun my-spacemacs-layer/post-init-evil-matchit ()
  ;; fix evil-matchit behavior in python
  (setq evilmi-always-simple-jump t)
  )

(defun my-spacemacs-layer/post-init-auctex ()
  ;; helm \includegraphics looks in local directory,
  ;; instead of TeX search path
  (setq LaTeX-includegraphics-read-file
        'LaTeX-includegraphics-read-file-relative)

  ;; set okular as default pdf viewer in linux
  (with-eval-after-load 'tex
    (when (eq system-type 'gnu/linux)
            (add-to-list 'TeX-view-program-selection
                         '(output-pdf "Okular"))
            ))
  )

;(defun my-spacemacs-layer/pre-init-evil ()
;  ;; alternative to dotspacemacs-distinguish-gui-tab
;  ;; allows C-i jump in terminal as well as in gui
;  ;; TODO submit PR? reference: https://github.com/syl20bnr/spacemacs/issues/5050
;  (setq evil-want-C-i-jump t)
;  )

(defun my-spacemacs-layer/post-init-evil ()
  ;; replacement for "," vim-action
  (define-key evil-motion-state-map (kbd "C-;")
    'evil-repeat-find-char-reverse)
  ;; remove RET binding
  ;(define-key evil-motion-state-map (kbd "RET") nil)

  ;; ESC exits emacs state
  ;; unfortunately this seems to breaks Alt as Meta-key in emacs-mode
  ;(define-key evil-emacs-state-map (kbd "ESC") 'evil-exit-emacs-state)
  ;; i switches from motion-state to emacs-state
  ;(define-key evil-motion-state-map "i" 'evil-emacs-state)

  ;; start dired in motion state
  ;(evil-set-initial-state 'dired-mode 'motion)
  ;(evil-set-initial-state 'dired-mode 'normal)
  )

(defun my-spacemacs-layer/post-init-avy ()
  (spacemacs/set-leader-keys
    "of" 'evil-avy-goto-char-in-line))

(defun my-spacemacs-layer/pre-init-org ()
  ;(setq org-startup-indented t)
  ;(setq org-directory "~/Dropbox/orgfiles")
  ;(setq org-agenda-files (list org-directory))
  ;(setq org-export-backends '(ascii html icalendar latex beamer))

  ;; don't ask to evaluate babel src code
  (setq org-confirm-babel-evaluate nil)

  ;(spacemacs|use-package-add-hook org
  ;  :post-config
  ;  (require 'ob-ipython)
  ;  (add-to-list 'org-babel-load-languages '(ipython . t)))
  )

;(defun my-spacemacs-layer/init-ob-ipython () ())

(defun my-spacemacs-layer/post-init-org ()
  (add-hook 'org-mode-hook
            'spacemacs/toggle-line-numbers-off
            'append)

  ;; macro to send ob src block to REPL asynchronously
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "os" ",',sb,c")
  )

(defun my-spacemacs-layer/post-init-ess ()
  ;; macro to send current line and goto next line
  (spacemacs/set-leader-keys-for-major-mode 'ess-mode
    "ol" ",slj")
  )

(defun my-spacemacs-layer/pre-init-tramp-sh ()
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (with-eval-after-load 'tramp-sh
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)))

(defun my-spacemacs-layer/init-tramp-sh () ())

(defun my-spacemacs-layer/post-init-multi-term ()
  ;(evil-set-initial-state 'term-mode 'motion)
  (with-eval-after-load 'multi-term
    ;; allow Alt+Backspace in terminal
    (add-to-list 'term-bind-key-alist
                 '("M-DEL" . (lambda () (interactive)
                               (term-send-raw-string "\e\d"))
                   ))))

;;; packages.el ends here

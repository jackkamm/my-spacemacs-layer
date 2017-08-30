(defconst my-spacemacs-layer-packages
  '((org :location built-in)
    (ob :location built-in)
    ob-ipython
    (tramp-sh :location built-in)
    multi-term
    avy
    evil
    ))

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
  (define-key evil-motion-state-map (kbd "RET")
    nil)
  ;; i switches from motion-state to emacs-state
  (define-key evil-motion-state-map "i"
    'evil-emacs-state)
  ;; ESC exits emacs state
  (define-key evil-emacs-state-map (kbd "ESC")
    'evil-exit-emacs-state)
  ;; start dired in motion state
  (evil-set-initial-state 'dired-mode 'motion))

(defun my-spacemacs-layer/post-init-avy ()
  (spacemacs/set-leader-keys
    "of" 'evil-avy-goto-char-in-line))

;(defun my-spacemacs-layer/pre-init-org ()
;  ;(setq org-startup-indented t)
;  ;(setq org-directory "~/Dropbox/orgfiles")
;  ;(setq org-agenda-files (list org-directory))
;  (setq org-export-backends '(ascii html icalendar latex beamer))
;  )

(defun my-spacemacs-layer/post-init-org ()
  (add-hook 'org-mode-hook
            'spacemacs/toggle-line-numbers-off
            'append))

(defun my-spacemacs-layer/pre-init-ob ()
  ;; don't ask to evaluate babel src code
  (setq org-confirm-babel-evaluate nil)

  (setq org-babel-load-languages
        '((R . t)
          (python . t)
          (ipython . t)
          (emacs-lisp . t)
          (shell . t)
          )))

(defun my-spacemacs-layer/post-init-ob ()
  ;; macro to send ob src block to REPL asynchronously
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "os" ",',sb,c"))

(defun my-spacemacs-layer/init-ob-ipython ()
  (use-package ob-ipython
    :defer t))

(defun my-spacemacs-layer/pre-init-tramp-sh ()
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (with-eval-after-load 'tramp-sh
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)))

(defun my-spacemacs-layer/init-tramp-sh () ())

(defun my-spacemacs-layer/post-init-multi-term ()
  (with-eval-after-load 'multi-term
    ;; allow Alt+Backspace in terminal
    (add-to-list 'term-bind-key-alist
                 '("M-DEL" . (lambda () (interactive)
                               (term-send-raw-string "\e\d"))
                   ))))

;;; packages.el ends here

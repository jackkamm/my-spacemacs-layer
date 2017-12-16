(spacemacs/set-leader-keys "o!" 'my-spacemacs-layer/launch-program)

;; open urxvt+tmux in default-directory
(spacemacs/set-leader-keys "ot"
  ;; TODO move to funcs.el
  (lambda (dir) (interactive (list (read-directory-name
                                    "Root directory: ")))
    (let ((default-directory dir))
      (call-process "urxvt" nil 0 nil "-e" "tmux"))))

;; copy filename (without directory)
(spacemacs/set-leader-keys "oy"
  ;; TODO move to funcs.el
  (lambda () (interactive)
    (message (kill-new (file-name-nondirectory
                        (buffer-file-name))))))

;; https://lists.gnu.org/archive/html/emacs-devel/2014-11/msg00328.html
(setq browse-url-browser-function 'browse-url-xdg-open)

;; use msmtp, it can easily handle sending from multiple accounts
(setq message-send-mail-function 'message-send-mail-with-sendmail)
;; shouldn't be needed anymore? using .mailrc to select msmtp...
(setq sendmail-program "/bin/msmtp")

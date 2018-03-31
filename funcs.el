(defun my-spacemacs-layer/set-face-height (height)
  "Change fontsize, for switching between HiDPI and regular screen"
  (interactive "nHeight: ")
  (set-face-attribute 'default nil :height height))

;; launch program from current directory with bash aliases
(defun my-spacemacs-layer/launch-program (cmd)
  (interactive
   (list (read-shell-command "cmd: ")))
  (call-process-region cmd nil "/usr/bin/bash" nil 0 nil "-i"))

(defun my-spacemacs-layer/fetch-email ()
  (interactive)
  (async-shell-command "notmuch new"))

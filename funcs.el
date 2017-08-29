(defun my-spacemacs-layer/set-face-height (height)
  "Change fontsize, for switching between HiDPI and regular screen"
  (interactive "nHeight: ")
  (set-face-attribute 'default nil :height height))

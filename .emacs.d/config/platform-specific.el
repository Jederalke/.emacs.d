;; graphic display specific settings
;; fixes emacs-nox and termux (but will break if run as a daemon on them)
(when (or (display-graphic-p) (daemonp))
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

;; daemon specific code
(when (daemonp)
  ;; load my erc autoconnect function (commented out)
  ;;(load-file "~/.emacs.d/config/myerc.el")
  ;; start erc automatically
  ;;(my-erc)
  
  ;; change the name of the frame
  (setq frame-title-format "Emacs (server)")

  ;; fix broken web-mode variables (won't work in emacsclient -t when pasting from clipboard)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-auto-indentation t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t))
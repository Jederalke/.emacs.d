;; load autoload files
(mapc #'load
      (directory-files-recursively "~/.emacs.d/lisp" "^autoloads\\.el$"))

;; load config files (order is important)
(mapc #'load
      '("~/.emacs.d/config/my-defuns.el"
        "~/.emacs.d/config/my-defuns-lexical.el"
        "~/.emacs.d/config/my-customization.el"
        "~/.emacs.d/config/my-extensions.el"
        "~/.emacs.d/config/my-safe-local-variables.el"))

;; load additional config files if they exist
(load "~/.emacs.d/config/my-local.el" t)

;; some random stuff
(set-face-attribute 'default t :font "DejaVu Sans Mono-9" )
(add-to-list 'erc-modules 'notifications)

(desktop-save-mode 1)
(custom-set-variables)
(custom-set-faces
 '(erc-input-face ((t (:foreground "sky blue")))))

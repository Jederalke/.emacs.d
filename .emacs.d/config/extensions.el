;;; this file contains configuration for extensions that don't come with GNU
;;; Emacs

;;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;; web-mode
(require 'web-mode)
;; select mode on filetype
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;; customize variables
(setq web-mode-enable-auto-pairing t               ; auto-pairing
      web-mode-enable-css-colorization t           ; CSS colorization
      web-mode-enable-auto-expanding t             ; auto expanding
      web-mode-enable-current-element-highlight t) ; highlight matching HTML elements
(add-hook 'web-mode-hook  (lambda ()
                            (setq web-mode-markup-indent-offset 2 ; custom indentation
                                  web-mode-css-indent-offset 2
                                  web-mode-code-indent-offset 2)))

;;; impatient-mode
;; dependencies
(require 'simple-httpd)
(require 'htmlize)
;; impatient-mode and its separate path (because it has a lot of files in it)
(add-to-list 'load-path "~/.emacs.d/lisp/impatient-mode/")
(require 'impatient-mode)

;; ox-sfhp
(require 'ox-sfhp)

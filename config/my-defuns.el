;; this file should load after extensions

(require 'cl)

(defun my-impatient-mode()
  "A function that automatically enables impatient-mode along
with httpd server if it isn't running."
  (interactive)
  (unless (process-status "httpd")
    (httpd-start))
  (impatient-mode))

(defun my-lhttpd (&optional port)
  "Start a local http server in the current directory on port
8000 or the prefix argument."
  (interactive "P")
  (setq httpd-root default-directory
        httpd-port (or port 8000))
  (httpd-start)
  (message "Started a local http server at port %d in %s"
           httpd-port httpd-root))

(defun my-indent-buffer ()
  "Indent the whole buffer like in `web-mode'."
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(defun my-js2-comment-block (&optional beg end)
  "Inserts a block comment at point or wraps region in a block
comment."
  ;; this code is bad, but it's a quick hack for now
  (interactive
   (when (use-region-p)
     (list (region-beginning) (region-end))))
  (if beg                               ; if region is active
      (let ((current-point (point)))
        (goto-char beg)
        (insert "/* ")
        (goto-char (+ end 3))
        (insert " */")
        (goto-char
         (+ current-point
            (if (> beg end)
                3
              6))))
    (insert "/*  */")
    (backward-char 3)))

(defun my-js2-unicode-escape-region (beg end)
  "Escapes non-ASCII characters as JavaScript unicode escapes.
Doesn't handle all characters as of now."
  (interactive "r")
  (let ((string (buffer-substring-no-properties beg end)))
    (delete-region beg end)
    (insert
     (mapconcat
      (lambda (char)
        (if (> char 127)                ; non-ASCII
            (format "\\u%04X" char)
          (char-to-string char)))
      string ""))))

(defun my-js2-change-context (context)
  "Switches current `js2-mode' buffer to specified context.

A list of contexts should be defined in `my-js2-contexts-list'."
  (interactive
   (list (completing-read "New context: " my-js2-contexts-list)))
  (cl-flet ((context-symbol
             (context)
             (intern (concat "js2-include-" context "-externs"))))
    (let ((desired-context (context-symbol context))
          (contexts-list (mapcar #'context-symbol my-js2-contexts-list)))
      (mapc (lambda (context)
              ;; this is pretty much `setq-local', but that macro doesn't have
              ;; an equivalent that doesn't quote the symbol
              (set (make-local-variable context)
                   (eq context desired-context)))
            contexts-list)
      ;; make sure that `js2-mode' parses the file again according to selected
      ;; context
      (js2-reparse))))

(defun my-dired-do-org-export (backend)
  "Exports marked files or file at point with a backend read from
a minibuffer. Files without .org extension are ignored. Alist of
backends is defined in `my-dired-org-export-backends-alist'."
  (interactive
   (list (cdr (assoc (completing-read
                      "Org export format: "
                      my-dired-org-export-backends-alist)
                     my-dired-org-export-backends-alist))))
  (mapc (lambda (file)
          (with-current-buffer (find-file-noselect file)
            (funcall backend file)
            (kill-buffer)))
        (dired-get-marked-files
         t nil
         (lambda (file)              ; filter out files without .org extension
           (let ((extension (file-name-extension file)))
             (when extension
               (string-equal "org" (downcase extension))))))))

(defun my-update-autoloads ()
  "Generate autoload files for all directories inside
\"~/.emacs.d/lisp\"."
  (interactive)
  (let ((dir (file-truename "~/.emacs.d/lisp")))
    (mapc
     (lambda (dir)
       (let ((generated-autoload-file (concat dir "/autoloads.el")))
         (update-directory-autoloads dir)))
     (cons dir
           (cl-remove-if-not
            #'file-directory-p
            (directory-files-recursively dir "" t))))))

;;; set variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq basimacs/home-dir (file-name-directory (or load-file-name buffer-file-name)))
;; (setq basimacs/home-dir "/Users/basimple/basimacs/")
(setq basimacs/plugins-dir (concat basimacs/home-dir "plugins/"))

;;; set load path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path basimacs/plugins-dir)

(defun switch-os ()
  (if (eq system-type 'darwin)
      (progn
	(change-command-to-meta))))

(defun conf-paren ()
  (if display-graphic-p
      (if (eq window-system 'ns)))
  (show-paren-mode t))

(defun conf/package ()
  "confiure for Emacs Lisp Pacage Archive"
  (if (< emacs-major-version 24)
  ;; (if (not (package-built-in-p 'package))
      (progn
	(require 'url)
	(let ((package-el-url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el"))
	  (util/download-file package-el-url))))
  ;; set ELPA variable
  (setq package-user-dir (concat basimacs/home-dir "/elpa/"))
  (setq package-archives
	'(("ELPA" . "http://tromey.com/elpa/")
	  ("gnu" . "http://elpa.gnu.org/packages/")
	  ("SC" . "http://joseito.republika.pl/sunrise-commander/")
	  ("marmalade" . "http://marmalade-repo.org/packages/"))))

(defun util/download-file (&optional url download-dir download-name)
  "download file from url"
  (require 'url)
  (interactive)
  (let ((url (or url
                 (read-string "Enter download URL: "))))
    (let ((download-buffer (url-retrieve-synchronously url)))
      (save-excursion
        (set-buffer download-buffer)
        ;; we may have to trim the http response
        (goto-char (point-min))
        (re-search-forward "^$" nil 'move)
        (forward-char)
        (delete-region (point-min) (point))
        (write-file (concat (or download-dir
                                "~/downloads/")
                            (or download-name
                                (car (last (split-string url "/" t))))))))))

(defun change-command-to-meta ()
  (if (and (display-graphic-p)
	   (eq window-system 'ns))
      (progn
	(setq mac-option-key-is-meta nil)
	(setq mac-command-key-is-meta t)
	(setq mac-command-modifier 'meta)
	(setq mac-option-modifier nil))))

;; main
(defun basimacs/init ()
  ""
  (conf/package)
  (change-command-to-meta))
(basimacs/init)

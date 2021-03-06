;;; Paul Pham's Splufty Emacs Dotfile

;;-- load path
(defun set-load-path ()
  (set 'load-path (cons (expand-file-name "~/.elisp") load-path))
  ;; add others here
  (message "Load path set."))
(set-load-path)

;;-- emacs visual appearance
(defun set-visual-preferences ()
  "Setup visual preferences."
  (set 'frame-title-format '("Emacs "	 " -- " " %b"))
  (set 'default-frame-alist '((width . 80) (height . 40)
			      (background-color . "Black")
			      (foreground-color . "White")
			      (cursor-color . "White")
			      (menu-bar-lines . 1)))
;;  (set-default-font 
;;   "-*-Lucida Console-normal-r-*-*-12-97-96-96-c-*-iso8859-1")
  (message "Visual preferences are set."))
(set-visual-preferences)

;;-- personalization variables
(defun set-personal-variables ()
  "Set personal variables."
  ;; do stuff here
  (set 'user-full-name "Paul Pham")
  (set 'user-mail-address "ppham@mit.edu")
  (message "Personal variables set."))
(set-personal-variables)

;;-- hacks for libraries shipped with emacs

;; font-lock hacks
(defun set-font-lock-hacks ()
  "Set font-lock hacks."
  (global-font-lock-mode)
  ;; other stuff
  (message "Font-lock hacks set."))
(set-font-lock-hacks)

(setq-default indent-tabs-mode nil)
(setq-default case-fold-search nil)

; C style commands
(c-set-offset 'arglist-intro 4)
;(c-set-offset 'defun-block-intro 4)
;(c-set-offset 'statement-block-intro 4)
;(c-set-offset 'substatement-open 0)

;(global-font-lock-mode 1)
;(setq font-lock-maximum-decoration t)

;add-hook 'c-mode-common-hook '(lambda ()
;                                (font-lock-mode)
;                                (setq indent-tabs-mode nil)
;                                (setq c-basic-offset 4)
;                                (setcdr (assoc 'substatement-open
;                                               c-offsets-alist) 0)))

;; Java stuff
(defun my-jde-mode-hook ()
  (setq indent-tabs-mode nil)
  (c-add-style "myjava"
               '((c-basic-offset . 4)))
  (c-set-style "myjava"))
(add-hook 'java-mode-hook 'my-jde-mode-hook)

;;-- key mappings
(global-set-key [(f11)] 'copy-region-as-kill) ; copy
(global-set-key [(f10)] 'ps-print-buffer) ; print
(global-set-key [(home)] 'beginning-of-buffer) ; copy
(global-set-key [(end)] 'end-of-buffer) ; print 
(global-set-key "\C-q" 'goto-line) ; jump to a line
(global-set-key "\C-x\C-r" 'replace-regexp) ; regexp substitution

;;-- save state of work while limiting a bit
(desktop-load-default)
(add-hook 'kill-emacs-hook 
	  '(lambda ()
	     (desktop-truncate search-ring 3)
	     (desktop-truncate regexp-search-ring 3)))
(desktop-read)

; Matlab/Octave mode
(autoload 'matlab-mode "~/.elisp/matlab-mode.el" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "~/.elisp/matlab-mode.el" "Interactive Matlab mode." t)

;; SGML/XML/HTML Modes

; Use OpenJade for validation
(setq sgml-validate-command "/usr/bin/onsgmls -s %s %s")
(setq xml-validate-command "/usr/bin/onsgmls -s %s %s")

;(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)

;; Load xml-mode 
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
(setq auto-mode-alist (cons '("\\.xml\\'" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.dtd\\'" . xml-mode) auto-mode-alist))
(setq sgml-xml-declaration "/usr/share/sgml/xml.dcl")

;; in sgml documents, parse dtd immediately to allow immediate syntax coloring
(setq sgml-auto-activate-dtd t)

;; set the default SGML declaration. docbook.dcl should work for most DTDs
(setq sgml-declaration "/usr/share/sgml/docbook/sgml-dtd-4.2-1.0-14/docbook.dcl")
      
;; here we set the syntax color information for psgml
(setq-default sgml-set-face t)
;; Faces.
;;
(make-face 'sgml-comment-face)
(make-face 'sgml-doctype-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-ignored-face)
(make-face 'sgml-ms-end-face)
(make-face 'sgml-ms-start-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-short-ref-face)
(make-face 'sgml-start-tag-face)

(set-face-foreground 'sgml-comment-face "dark turquoise")
(set-face-foreground 'sgml-doctype-face "red")
(set-face-foreground 'sgml-end-tag-face "blue")
(set-face-foreground 'sgml-entity-face "magenta")
(set-face-foreground 'sgml-ignored-face "gray40")
(set-face-background 'sgml-ignored-face "gray60")
(set-face-foreground 'sgml-ms-end-face "green")
(set-face-foreground 'sgml-ms-start-face "yellow")
(set-face-foreground 'sgml-pi-face "lime green")
(set-face-foreground 'sgml-sgml-face "brown")
(set-face-foreground 'sgml-short-ref-face "sky blue")
(set-face-foreground 'sgml-start-tag-face "magenta")

(setq-default sgml-markup-faces
	      '((comment . sgml-comment-face)
		(doctype . sgml-doctype-face)
		(end-tag . sgml-end-tag-face)
		(entity . sgml-entity-face)
		(ignored . sgml-ignored-face)
		(ms-end . sgml-ms-end-face)
		(ms-start . sgml-ms-start-face)
		(pi . sgml-pi-face)
		(sgml . sgml-sgml-face)
		(short-ref . sgml-short-ref-face)
		(start-tag . sgml-start-tag-face)))

;; define html mode
(or (assoc "\\.html$" auto-mode-alist)
    (setq auto-mode-alist (cons '("\\.html$" . sgml-html-mode)
				auto-mode-alist)))
(or (assoc "\\.htm$" auto-mode-alist)
    (setq auto-mode-alist (cons '("\\.htm$" . sgml-html-mode)
				auto-mode-alist)))

(defun sgml-html-mode ()
  "This version of html mode is just a wrapper around sgml mode."
  (interactive)
  (sgml-mode)
  (make-local-variable 'sgml-declaration)
  (make-local-variable 'sgml-default-doctype-name)
  (setq
   sgml-default-doctype-name    "html"
   sgml-declaration             "/usr/share/sgml/dtd/html/html.dcl"
   
   sgml-always-quote-attributes t
   sgml-indent-step             2
   sgml-indent-data             t
   sgml-minimize-attributes     nil
   sgml-omittag                 t
   sgml-shorttag                t
   )
  )

(setq-default sgml-indent-data t)
(setq
 sgml-always-quote-attributes   t
 sgml-auto-insert-required-elements t
 sgml-auto-activate-dtd         t
 sgml-indent-data               t
 sgml-indent-step               2
 sgml-minimize-attributes       nil
 sgml-omittag                   nil
 sgml-shorttag                  nil
 )

(setq auto-mode-alist
      (cons '("\\.mgp?\\'" . mgp-mode) 
            auto-mode-alist))
(autoload 'mgp-mode "mgp-mode")
(setq mgp-options "-g 800x600")
(setq mgp-window-height 6)
(cond 
 ((= emacs-major-version 19)     ;; Emacs 19, Mule 2.3
  (setq mgp-mode-hook
    	(function (lambda () 
    		    (set-file-coding-system '*iso-2022-jp*unix)))))
 ((= emacs-major-version 20)     ;; Emacs 20
  (setq mgp-mode-hook
    	(function (lambda ()
    		    (set-file-coding-system-for-read 'iso-2022-jp-unix))))))

;(load "~/.elisp/6170.el")

(setq-default ispell-program-name "aspell")


(setq auto-mode-alist (cons '("\\.cs\\'" . csharp-mode) auto-mode-alist))
(tool-bar-mode -1)

(setq auto-mode-alist (cons '("\\.bin$" . hexl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(autoload 'css-mode "css-mode")
(setq auto-mode-alist       
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

(require 'php-mode)

(add-hook 'php-mode-user-hook 'turn-on-font-lock)

(add-hook 'php-mode-user-hook
          '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

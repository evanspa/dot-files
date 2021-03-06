; Python!
(setq py-python-command "python3")
(setq python-shell-interpreter "python3")
(add-hook 'python-mode-hook
          (lambda ()
            (setq py-python-command "python3")
            (setq py-default-interpreter "python3")))

; enable auto complete mode at startup
(require 'auto-complete)
(global-auto-complete-mode t)

; https://truongtx.me/2014/04/20/emacs-javascript-completion-and-refactoring/
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; https://truongtx.me/2014/02/21/emacs-setup-jshint-for-on-the-fly-petential-error-checking/
(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))

;; https://raw.githubusercontent.com/magit/magit/next/Documentation/RelNotes/1.4.0.txt
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

(require 'icomplete)
(require 'rainbow-delimiters)
;; Have emacs start in full screen mode / maximized.
;; (http://www.emacswiki.org/emacs/FullScreen#toc2)
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;;; Enable Objective-C Mode
(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and (string= (file-name-extension buffer-file-name) "h")
                       (re-search-forward "@\\<interface\\>" magic-mode-regexp-match-limit t)))
               . objc-mode))

;; (Paul edit) make the font-size 10 pt
(set-face-attribute 'default nil :height 90)

;; (Paul edit)
;(require 'workgroups)
;(workgroups-mode 1)
;(wg-load "~/.emacs.d/personal/workgroups")

;; (Paul edit)
;; The following code is from: http://dse.livejournal.com/67732.html
;; --- START frame / window sizing functions ---
(defun fix-frame-horizontal-size (width)
  "Set the frame's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (if window-system
      (set-frame-width (selected-frame) (or width 80))
    (error "Cannot resize frame horizontally: is a text terminal")))

(defun fix-window-horizontal-size (width)
  "Set the window's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (enlarge-window (- (or width 80) (window-width)) 'horizontal))

(defun fix-horizontal-size (width)
  "Set the window's or frame's width to 80 (or prefix arg WIDTH)."
  (interactive "P")
  (condition-case nil
      (fix-window-horizontal-size width)
    (error
     (condition-case nil
         (fix-frame-horizontal-size width)
       (error
        (error "Cannot resize window or frame horizontally"))))))
;; --- END frame / window sizing functions ---

;; (Paul edit)
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . xml-mode))

;; (Paul edit - org related config)
;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;(global-set-key "\C-cl" 'org-store-link)
;(global-set-key "\C-cc" 'org-capture)
;(global-set-key "\C-ca" 'org-agenda)
;(global-set-key "\C-cb" 'org-iswitchb)

;; (Paul edit --- swank-js integration)
;(add-to-list 'load-path "~/.emacs.d/vendor/slime/")
;(add-to-list 'load-path "~/.emacs.d/vendor/slime/contrib/")
;(require 'slime)
;(require 'slime-js)
;(slime-setup '(slime-js slime-repl))
;(setq slime-js-swank-command "/usr/local/bin/swank-js")
;(setq slime-js-swank-args '())

;; Helm config
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x);
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; whitespace cleanup
(global-set-key (kbd "C-x w h") 'whitespace-cleanup)
(defalias 'w 'whitespace-cleanup)

;; Whitespace cleanup before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq-default indent-tabs-mode nil)

;; cycle windows in reverse order
(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-x p") 'prev-window)

;; Dependencies for dirtree
(require 'tree-mode)
(require 'windata)
(require 'dirtree)

;; Clojure
(setq cider-repl-use-clojure-font-lock t)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)
(setq nrepl-log-messages t)
(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'company-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
;(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;;; Mac cmd key for meta
(setq mac-command-key-is-meta t
      mac-command-modifier 'meta)

;;; Whitespace and fci mode
(global-whitespace-mode t)
(require 'fill-column-indicator)
(setq fci-rule-width 3)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; (Paul edit)
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))

;;;(disable-theme 'zenburn)
;;;(load-theme 'manoj-dark t)

(tool-bar-mode 0)

;; Found on http://www.qcode.co.uk/formatting-xml-in-an-emacs-buffer/
(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)))

;; Configure auto-fill mode.
(setq-default fill-column 80)
(setq comment-auto-fill-only-comments t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'objc-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'clojure-mode-hook 'turn-on-auto-fill)
(add-hook 'xml-mode-hook 'turn-on-auto-fill)

;; wgrep
(require 'wgrep)

;; Configure the_silver_search (ag)
(setq ag-highlight-search t)

;; as per https://github.com/r0man/sqlingvo
(add-hook
 'clojure-mode-hook
 (lambda ()
   (define-clojure-indent
     (copy 2)
     (create-table 1)
     (delete 1)
     (drop-materialized-view 2)
     (drop-table 1)
     (insert 2)
     (refresh-materialized-view 2)
     (select 1)
     (truncate 1)
     (update 2))))

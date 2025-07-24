;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/brain/")
(setq org-roam-directory (file-truename "~/brain"))
(setq org-roam-database-connector 'sqlite3)
(setq org-roam-additional-files
      (directory-files-recursively (file-truename "~/brain/") "\\.org$"))
;; Set a custom capture template to create zettels *in roam/*
(setq org-roam-capture-templates
      '(("d" "default" plain
         "%?"
         :target (file+head "./roam/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :note:\n")
         :unnarrowed t)))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ------------------
;; --- Navigation ---
;; ------------------
;; Enable windmove with Meta + arrow keys
(windmove-default-keybindings 'meta)

;; Revert buffer without confirmation
(defun revert-buffer-no-confirm ()
  "Revert buffer without asking for confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))
(global-set-key (kbd "C-x C-x") #'revert-buffer-no-confirm)

(after! go-mode
  ;; Disable gocode-based eldoc to avoid errors
  (setq go-eldoc-gocode nil)
  ;; Append 'go-build to the list of disabled checkers in Go buffers.
  (setq-local flycheck-disabled-checkers
              (append flycheck-disabled-checkers '(go-build))))

(add-hook 'go-mode-hook (lambda () (flycheck-mode -1)))
(add-hook 'go-mode-hook (lambda () (eldoc-mode -1)))

(add-to-list 'auto-mode-alist '("BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '(".build_defs\\'" . python-mode))

;; ----------------
;; --- Protobuf ---
;; ----------------
(use-package! protobuf-mode
  :mode "\\.proto\\'"
  :config
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil))

;; ----------------
;; --- ORG MODE ---
;; ----------------
(after! org
  ;; Recursively include all .org files under ~/brain in the agenda.
  (setq org-agenda-files (directory-files-recursively "~/brain" "\\.org$"))
  ;; Enable Shift+Arrow selection in Org mode.
  (setq org-support-shift-select t))

(add-hook! 'org-mode-hook
  (flyspell-mode 1)
  (ispell-change-dictionary "british"))

;; -------------------
;; --- ORG CAPTURE ---
;; -------------------
(defun my/slugify-name (name)
  "Convert NAME to a file-friendly slug."
  (let ((slug (downcase name)))
    (setq slug (replace-regexp-in-string "[^a-z0-9]" "_" slug))
    (setq slug (replace-regexp-in-string "_+" "_" slug))
    (setq slug (replace-regexp-in-string "^_\\|_$" "" slug))
    slug))

(defun my/generate-contact-filename ()
  "Generate a contact filename with timestamp."
  (let* ((name (read-string "Contact Name: "))
         (timestamp (format-time-string "%Y%m%d%H%M%S")))
    (setq my-contact--name name)
    (expand-file-name
     (concat (my/slugify-name name) "_" timestamp ".org")
     "~/brain/contacts/")))

(after! org
  (setq org-capture-templates
        '(("c" "Contact")
          ("cp" "Personal Contact" plain
           (file my/generate-contact-filename)
           ":PROPERTIES:\n:ID: %(org-id-new)\n:TYPE: personal\n:EMAIL: %^{Email}\n:PHONE: %^{Phone|N/A}\n:END:\n#+title: %(format \"%s\" my-contact--name)\n\n* Notes\n%?")
          ("cw" "Work Contact" plain
           (file my/generate-contact-filename)
           ":PROPERTIES:\n:ID: %(org-id-new)\n:TYPE: work\n:EMAIL: %^{Email}\n:PHONE: %^{Phone|N/A}\n:COMPANY: %^{Company}\n:ROLE: %^{Role}\n:END:\n#+title: %(format \"%s\" my-contact--name)\n\n* Notes\n%?")
          ("cf" "Friends Contact" plain
           (file my/generate-contact-filename)
           ":PROPERTIES:\n:ID: %(org-id-new)\n:TYPE: friend\n:EMAIL: %^{Email}\n:PHONE: %^{Phone|N/A}\n:MET_AT: %^{Where we met}\n:END:\n#+title: %(format \"%s\" my-contact--name)\n\n* Notes\n%?")
          ("cm" "Family Contact" plain
           (file my/generate-contact-filename)
           ":PROPERTIES:\n:ID: %(org-id-new)\n:TYPE: family\n:EMAIL: %^{Email}\n:PHONE: %^{Phone|N/A}\n:RELATION: %^{Relation}\n:END:\n#+title: %(format \"%s\" my-contact--name)\n\n* Notes\n%?"))))

;; -----------------
;;
(after! ox-hugo
  (setq org-hugo-export-with-section nil)) ;; Ensures subtree exporting

;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; Configure web-mode for TSX
(setq web-mode-content-types-alist
      '(("jsx" . "\\.[jt]sx?\\'")))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-element-highlight t))

(add-hook 'web-mode-hook 'my-web-mode-hook)

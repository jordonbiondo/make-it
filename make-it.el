;;; make-it.el --- Make compilation support in emacs
;;
;; Filename: make-it.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Wed Apr 10 11:39:03 2013 (-0400)
;; Version:
;; Last-Updated: Wed Apr 10 11:39:19 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 1
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;  interactive make support, allows users to choose make targets
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defun makeit/get-targets()
  (interactive)
  (let ((makefile (concat (file-name-directory buffer-file-name) "/makefile"))
	(targets '()))
    (if (file-exists-p makefile)
	(with-temp-buffer
	  (insert-file-contents makefile)
	  (beginning-of-buffer)
	  (while (search-forward-regexp "^\\([a-zA-Z_-]+\\):" nil t)
	    (forward-word -1)
	    (setq targets (append targets (list (word-at-point))))
	    (forward-word 1)))
      (print "no file"))
    targets))

(defun makeit/interactive(arg)
  (interactive
   (list (completing-read "make: " (makeit/get-targets) nil t nil nil "asd")))
  (if (listp arg) (setq arg (car arg))) ;; older emacs support
  (compile (concat "make " arg)))


		    



(provide 'make-it)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; make-it.el ends here

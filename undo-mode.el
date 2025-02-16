;;; undo-mode --- Summary ;; -*- lexical-binding: t; -*-

;; undo-mode is a minor mode for quickly typing the lyrics to the hit
;; Swedish application to the Eurovision Song contest in 2014; Undo by Sanna Nielsen.
;; https://youtu.be/55ZJKyLj28w?si=-bw7yUYGUzDTqziA

;;; Commentary:

;; I have often read/heard stories of new Emacs users having trouble with Emacs' default
;; undo system, and so I decided to improve it by allowing the users to input undo
;; regardless of what they type.  If you have not heard Nielsen's 2014 hit /Undo/ you can
;; find it here: https://youtu.be/55ZJKyLj28w?si=-bw7yUYGUzDTqziA

;;; Code:

(defconst undo--chars (listify-key-sequence "Silent, I can't wait here silent
Working up a storm inside my head
Nothing, I just stood for nothing
So I fell for everything you said

Hear the rumble
Hear my voice

Silent, I can't wait here silent
Gotta make a change and make some noise

Undo my sad
Undo what hurts so bad
Undo my pain
Gonna get out, through the rain
I know that I am over you
At last I know what I should do
Undo my sad

Trouble, baby I'm in trouble
Everytime I look into your eyes
Save me, oh I'm gonna save me
Far away from all the crazy lies

Hear the rumble
Hear my voice

Undo my sad
Undo what hurts so bad
Undo my pain
Gonna get out, through the rain
I know that I am over you
At last I know what I should do
Undo my sad

Undo my sad
Undo what hurts so bad
Undo my pain
Gonna get out, through the rain
I know that I am over you
At last I know what I should do
Undo my sad


"))

(defvar undo--char-index -1)

(defun undo-self-insert (&rest _)
  "Insert the next character in the word undo."
  (list 1 (nth (mod (cl-incf undo--char-index) (length undo--chars)) undo--chars)))

(define-minor-mode undo-mode
  "Only allows you to write the lyrics to Sanna Nielsen's /Undo/."
  :lighter "Undo; Sanna Nielsen "
  :global t
  :group 'convenience
  
  (if undo-mode
      (progn
        (setq undo--char-index -1)
        (advice-add 'self-insert-command :filter-args #'undo-self-insert))
    (advice-remove 'self-insert-command #'undo-self-insert)))

(provide 'undo)

;;; undo-mode.el ends here

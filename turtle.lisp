; (ql:quickload "lispbuilder-sdl")

(defparameter *x* 100)
(defparameter *y* 100)
(defparameter *angle* 0)

; just to make the colors easier to access
(defparameter black sdl:*black*)
(defparameter white sdl:*white*)
(defparameter red sdl:*red*)
(defparameter green sdl:*green*)
(defparameter blue sdl:*blue*)
(defparameter yellow sdl:*yellow*)
(defparameter cyan sdl:*cyan*)
(defparameter magenta sdl:*magenta*)

(defun goto (x y &optional (angle 0))
	; place the turtle at a given position
	(setf *angle* angle)
	(setf *x* x)
	(setf *y* y))

(defun show (&key (color sdl:*default-color*))
	; draw a triangle representing the turtle
	(let ((size 10))
		(left 90)
		(forward (+ 2 (/ size 2)) :color color)
		(right 135)
		(forward size :color color)
		(right 90)
		(forward size :color color)
		(right 135)
		(forward size) :color color))

(defun forward (steps &key (color sdl:*default-color*))
	(let (	(x *x*)
			(y *y*))
		(setf *x* (+ x (* steps (cos (sdl:to-radian *angle*)))))
		(setf *y* (- y (* steps (sin (sdl:to-radian *angle*)))))
		(sdl:draw-line-* (round x) (round y) (round *x*) (round *y*) :color color)))

(defun color (color)
	(setf sdl:*default-color* color))

(defun left (degrees)
	(setf *angle* (+ *angle* degrees))
	(if (< *angle* 0) (setf *angle* (+ *angle* 360)))
	(if (> *angle* 360) (setf *angle* (- *angle* 360))))

(defun right(steps) (left (- steps)))

(defmacro with-turtle (&rest body)
	`(sdl:with-init ()
	    (sdl:window 400 400 :title-caption "Turtle Graphics")
		(goto 200 200 90)
		,@body
		(show)
	    (sdl:update-display)
		(sdl:with-events ()
			(:quit-event () t)
			(:video-expose-event (sdl:update-display)))))

(with-turtle
	(dotimes (a 35)
		(dotimes (i 4)
			(forward 50)
			(left 90))
		(left 10)))
		

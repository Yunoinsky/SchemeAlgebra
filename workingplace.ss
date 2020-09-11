(define inter-lgrg
  (case-lambda
    [(x y t)
     (let ([n (vector-length x)]
	   [n_y (vector-length y)])
       (if (= n n_y)
	   (cond
	    [(< n 1) 0.0]
	    [(= n 1) (vector-ref y 0)]
	    [(= n 2) (/ (- (* (vector-ref y 0) (- t (vector-ref x 1)))
			   (* (vector-ref y 1) (- t (vector-ref x 0))))
			(- (vector-ref x 0) (vector-ref x 1)))]
	    [else (let* ([i_1 (do ([i 0 (+ i 1)])
				 ((or (>= i n) (>= (vector-ref x i) t)) i))]
			 [k (max 0 (- i_1 4))]
			 [m (min (- n 1) (+ i_1 3))])
		    (let loop-out ([i_ind 0]
				   [z 0.0])
		      (if (> i_ind m)
			  z
			  (let loop-in ([j_ind 0]
					[s 1.0])
			    (if (> j_ind m)
				(if (= i j)
				    (loop-in (+ j_ind 1) s)
				    (loop-in (+ j_ind 1) (* s (/ (- t (vector-ref x j_ind))
								 (- (vector-ref x i_ind)
								    (vector-ref x j_ind))))))
				(loop-out (+ i_ind 1) (+ (* s (vector-ref y i_ind)))))))))])
	   (raise
	    (condition
	     (make-error)
	     (make-message-condition "Inconsistent length")))))]))

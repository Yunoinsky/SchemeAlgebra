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
		    (let loop-out ([i_ind k] [z 0.0])
		      (if (> i_ind m)
			  z
			  (let loop-in ([j_ind k] [s_u 1.0] [s_d 1.0])
			    (if (> j_ind m)
				(loop-out (+ i_ind 1) (+ (* (/ s_u s_d) (vector-ref y i_ind)) z))
				(if (= i_ind j_ind)
				    (loop-in (+ j_ind 1) s_u s_d)
				    (loop-in (+ j_ind 1)
					     (* (- t (vector-ref x j_ind)) s_u)
					     (* (- (vector-ref x i_ind) (vector-ref x j_ind)) s_d))))))))])
	   (raise
	    (condition
	     (make-error)
	     (make-message-condition "Inconsistent length")))))]
    [(x_0 y step t)
     (let ([n (vector-length y)])
       (cond
	[(< n 1) 0.0]
	[(= n 1) vector-ref y 0]
	[(= n 2) (/ (- (* (vector-ref y 0) (- t (vector-ref x 1)))
		       (* (vector-ref y 1) (- t (vector-ref x 0))))
		    (- (vector-ref x 0) (vector-ref x 1)))]
	[else (let* ([i_1 (max (min (flonum->fixnum (/ (- t x_0) step))
				    (- n 1)) 0)]
		     [k (max 0 (- i_1 3))]
		     [m (min (- n 1) (+ i_1 4))])

		(let loop-out ([i_ind k] [z 0.0])
		  (if (> i_ind m)
		      z
		      (let loop-in ([j_ind k]
				    [t-x_j (- t (+ x_0 (* k step)))]
				    [x_i-x_j (* (- i_ind k) step)]
				    [s_u 1.0]
				    [s_d 1.0])
			(if (> j_ind m)
			    (loop-out (+ i_ind 1) (+ (* (/ s_u s_d) (vector-ref y i_ind)) z))
			    (if (= i_ind j_ind)
				(loop-in (+ j_ind 1) (- t-x_j step) (- x_i-x_j step) s_u s_d)
				(loop-in (+ j_ind 1) (- t-x_j step) (- x_i-x_j step) (* s_u t-x_j) (* s_d x_i-x_j))))))))]))]))


		    

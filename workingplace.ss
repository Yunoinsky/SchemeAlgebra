(define inter-lgrg
  (case-lambda
    [(x y t)
     (let ([n fxvector-length x]
	   [n_y fxvector-length y])
       (if (= n n_y)
	   (cond
	    [(< n 1) 0.0]
	    [(= n 1) (fxvector-ref y 0)]
	    [(= n 2) (/ (- (* (fxvector-ref y 0) (- t (fxvector-ref x 1)))
			   (* (fxvector-ref y 1) (- t (fxvector-ref x 0))))
			(- (fxvector-ref x 0) (fxvector-ref x 1)))]
	    [else (let* ([i_1 (do ([i 0 (+ i 1)])
				 ((or (>= i n) (>= (fxvector-ref x i) t)) i))]
			 [k (max 0 (- i_1 4))]
			 [m (min (- n 1) (+ i 3))])
		    (let 
			      
		    
	     
			

	       
	   (raise
	    (condition
	     (make-error)
	     (make-message-condition "Inconsistent length"))))
	 
    

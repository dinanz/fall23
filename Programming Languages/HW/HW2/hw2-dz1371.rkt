#|
Question 1
|#
(define (chain funcs v)
  (if
    (null? funcs) v ; if null return v
    (chain (cdr funcs) ((car funcs) v)) ; else apply top function
))


#|
Question 2
|#
(define (chain_odd funcs v)
  (if (or
       (not (and (integer? v) (odd? v)))
       (null? funcs)) v ; if v is odd integer, return v
      (chain_odd (cdr funcs) ( (car funcs) v)))) ; else apply current func to the rest of chain


(define (inc n) (+ n 1))
(define (dec n) (- n 1))
(define (plus2 n) (+ n 2))
(define (minus2 n) (- n 2))
(define (ident s) s)


#|
Question 3
|#
(define (zip_helper l1 l2 output)
  (cond
    ((null? l1) output) ; if input lists null return null
    ((equal? output '())
           (zip_helper (cdr l1) (cdr l2) (list (car l1) (car l2))))
    (else  (zip_helper (cdr l1)
                  (cdr l2)
                  (list output (list (car l1) (car l2)))))
      ))

(define (zip l1 l2) (zip_helper l1 l2 '()))

#|
zip (1 2 3) (4 5 6) ()
zip (2 3) (4 5) (1, 2)
zip (3) (5) ((1,2) (
|#


#|
Question 4

(define (unzip_helper l1 l2 out1 out2)
  (if (null? l1) (list out1 out2) ; if input lists null return null
      (cons ))) ; else concat top 2 elements to remaining zip

(define (unzip l1 l2) (unzip_helper l1 l3 '() '()))
|#
(define (unzip_help zipped unzipped)
  (if (null? zipped) unzipped      ; if null return unzipped list
      (unzip_help (cdr zipped) (list unzipped (cons (car (car zipped)) (cdr (car zipped))))
             )))
(define (unzip zipped) (unzip_help zipped '()))             





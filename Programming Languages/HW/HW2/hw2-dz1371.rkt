#|
Question 1 DONE
|#
(define (chain funcs v)
  (if
    (null? funcs) v ; if null return v
    (chain (cdr funcs) ((car funcs) v)) ; else apply top function
))


#|
Question 2 DONE
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
(zip '(1 2 3) '(4 5 6))

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
      (unzip_help (cdr zipped)
                  (list
                     (list (car unzipped)  (car (car zipped)))
                     (list (car (cdr unzipped))  (car (cdr (car zipped)))))
             )))
(define (unzip zipped) (unzip_help zipped '(() ()) ) )             

(unzip '((1 4) (2 5) (3 6)))







#|
Question 6 DONE
|#
(define (reverse_help x rX)
  (if (null? x) rX ; return full reversed list
      (reverse_help (cdr x) (cons (car x) rX)
               )))

(define (reverseX x) (reverse_help x '()))
      


#|
Question 7
|#
(define (interleave_help l1 l2 res)
  (if (or (null? l1) (null? l2)) res
      (interleave_help (cdr l1) (cdr l2)
                       (cons res (cons (car l1) (cons (car l2) '())))
)))
; USE LET

   
(define (interleave_outer l1 l2) (interleave_help l1 (reverse l2) '()))

(interleave_outer '(1 2 3) '(a b c))



#|
Question 8 DONE
|#
(define (count_help lst x count)
  (cond
    ((null? lst) count) ; return full reversed list
    ((equal? (car lst) x)  (count_help (cdr lst) x (+ 1 count)))
    (else  (count_help (cdr lst) x count))
               ))

(define (count-occurrences lst x) (count_help lst x 0))



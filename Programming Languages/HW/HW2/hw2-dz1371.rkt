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




#|
Question 3

(define (zip_helper l1 l2 output)
  (cond
    ((null? l1) output) ; if input lists null return null
    ((equal? output '())
           (zip_helper (cdr l1) (cdr l2)
                  (cons (car l1)
                        (cons (car l2) '()))))
    (else  (zip_helper (cdr l1)
                  (cdr l2)
                  (cons output
                        (list
                              (cons (car l1)
                                    (cons (car l2) '()))))))
      ))

|#

(define (zip_helper l1 l2 output)
  (if
    (null? l1) output ; if input lists null return null
     (zip_helper (cdr l1) (cdr l2) (append output (list(list (car l1) (car l2))))))
)


(define (zip l1 l2) (zip_helper l1 l2 '()))
(zip '(1 2 3) '(4 5 6))

#|
zip (1 2 3) (4 5 6) ()
zip (2 3) (4 5) (1, 2)
zip (3) (5) ((1,2) (
|#



USE TAIL RECURSION OF TATIL RECURSION
E.G. UNZIP(M UNZIP())


#|Question 4

zipped: ((1 4) (2 5) (3 6))
unzipped: (() ())

((2 5) (3 6))
((1) (4))

((3 6))
((1 2) (4 5))
|#


(define (unzip_help zipped unzipped)
  (if (null? zipped) unzipped      ; if null return unzipped list
      (unzip_help (cdr zipped)
                  (list
                     (list (car unzipped)  (car (car zipped)))
                     (list (car (cdr unzipped))  (car (cdr (car zipped)))))
             )))

#|
(define zipped '((1 4) (2 5) (3 6)))
(define unzipped '('() '()))


(define (unzip_help zipped unzipped)
  (cond
    ((null? zipped) unzipped)
    ((equal? unzipped '('() '()))
     (unzip_help (cdr zipped)
          (list
           (list (car unzipped) (car (car zipped)))
           (list (car (cdr unzipped)) (cdr (car zipped)))
      )))
    (else 
      (unzip_help
             (cdr zipped)     ; zipped  ((1 4) (2 5) (3 6))
             ; unzipped (() ())
             (list
              (append (car unzipped) (list (car (car zipped))))
              (append (car (cdr unzipped)) (cdr (car zipped)))))
      
    )
  )
)
|#


(define (unzip zipped) (unzip_help zipped '('() '()) ) )             

(unzip '((1 4) (2 5) (3 6)))


#|
Question 5
|#

#|
(define (removeElement li res x)
  (cond
    ((null? li) res)
    ((equal? (car li) x) (removeElement (cdr li) res x) )
    

(define (cancellist l1 l2)

|#



#|
Question 6 DONE
|#
(define (reverse_help x rX)
  (if (null? x) rX ; return full reversed list
      (reverse_help (cdr x) (cons (car x) rX)
               )))

(define (reverseX x) (reverse_help x '()))
      


#|
Question 7 DONE
|#
(define (interleave_help l1 l2 res)
  (cond
    ((and (null? l1) (null? l2)) res)
    ((null? l1) (append res l2))
    ((null? l2) (append res l1))
     (else (interleave_help (cdr l1) (cdr l2)
                       (append res (cons (car l1) (cons (car l2) '()))))
)))
; USE LET

   
(define (interleave_outer l1 l2) (interleave_help l1 (reverse l2) '()))

(interleave_outer '(1 2 3) '(a b c))
(interleave_outer '(1 2 3) '(a b c d e f))
(interleave_outer '(1 2 3 4 5 6) '(a b c))






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



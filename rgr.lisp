;;; ---------------------------------------------------------
;;; LOGIC SECTION
;;; ---------------------------------------------------------

(defun calculate-f (n)
  (cond
    ((= n 1) 1)
    ((= n 6) 1)
    ((and (>= n 2) (<= n 5))
     ;; Formula: sqrt(F_{i-1}) * ln(i) / 7
     (/ (* (sqrt (calculate-f (- n 1))) (log n)) 7.0))
    ((and (>= n 7) (<= n 15))
     ;; Formula: sqrt(F_{i-1}) * sqrt(i) / 4
     (/ (* (sqrt (calculate-f (- n 1))) (sqrt n)) 4.0))
    (t (error "n must be between 1-15"))))

(defun calculate-all-f (start end)
  (if (> start end)
      nil
      (cons (list start (calculate-f start))
            (calculate-all-f (+ start 1) end))))

;;; ---------------------------------------------------------
;;; DISPLAY SECTION
;;; ---------------------------------------------------------

(defun print-f-table (start end)
  (format t "~%+------+-------------------+~%")
  (format t "|  i   |        F_i        |~%")
  (format t "+------+-------------------+~%")
  (print-f-table-rows start end)
  (format t "+------+-------------------+~%"))

(defun print-f-table-rows (start end)
  (when (<= start end)
    (format t "| ~4d | ~17,10f |~%" start (calculate-f start))
    (print-f-table-rows (+ start 1) end)))

;;; ---------------------------------------------------------
;;; TESTING SECTION
;;; ---------------------------------------------------------

(defun check-f (name n expected &optional (epsilon 0.0001))
  (let ((actual (calculate-f n)))
    (format t "~:[FAILED~;passed~]... ~a (n=~a, expected=~,8f, actual=~,8f)~%"
            (< (abs (- actual expected)) epsilon)
            name
            n
            expected
            actual)))

(defun test-base-cases ()
  (format t "~%=== Test Base Cases ===~%")
  (check-f "test-F1" 1 1.0)
  (check-f "test-F6" 6 1.0))

(defun test-range-2-5 ()
  (format t "~%=== Tests between 2..5 ===~%")
  (check-f "test-F2" 2 0.09902103)
  (check-f "test-F3" 3 0.04938671) 
  (check-f "test-F4" 4 0.04401112) 
  (check-f "test-F5" 5 0.04823446)) 

(defun test-range-7-15 ()
  (format t "~%=== Test between i=7..15 ===~%")
  (check-f "test-F7"  7 0.66143780)
  (check-f "test-F8"  8 0.57508165)
  (check-f "test-F10" 10 0.59621520) 
  (check-f "test-F15" 15 0.87157154)) 

(defun test-all ()
  (test-base-cases)
  (test-range-2-5)
  (test-range-7-15)
  (format t "~%=== All Tests Completed ===~%"))

;;; ---------------------------------------------------------
;;; EXECUTION
;;; ---------------------------------------------------------

(test-all)
(print-f-table 1 15)

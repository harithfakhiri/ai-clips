; START
(defrule start
=>
	(assert (phase state-start)))

; CONT
(defrule cont
    ?phase <- (phase state-fin)
 =>
 (printout t "continue? (yes=1/no=0) ")
    (retract ?phase)
    (assert (phase state-opt))
    (assert (user-opt (read))))

; READ OPT
(defrule read_opt_1
    ?phase <- (phase state-opt)
    ?input <- (user-opt ?opt&1)
 =>
    (retract ?phase ?input)
    (assert (phase state-start)))

; EXIT
(defrule read_opt_0
    ?phase <- (phase state-opt)
    ?input <- (user-opt ?opt&0)
 =>
 (printout t "have a nice day! " crlf)
    (retract ?phase ?input))

; INVALID INPUT
(defrule invalid_opt
    ?phase <- (phase state-fin)
    ?input <- (user-opt ?opt&~1&~0)
 =>
 (printout t "invalid input")
    (retract ?phase ?input)
    (assert (phase state-fin)))
    
; MEAN CONCAVE
(defrule meanconcave
    ?phase <- (phase state-start)
=>
(printout t "mean_concave_point? ")
    (retract ?phase)
    (assert (phase state-mcp))
	(assert (user-mcp (read))))

; WORST RADIUS
(defrule worstradius
    ?phase <- (phase state-mcp)
    ?input <- (user-mcp ?number)
    (test (<= ?number 0.05))
=>
(printout t "worst_radius? ")
    (retract ?phase ?input)
    (assert (phase state-wr))
	(assert (user-wr (read))))

; WORST PERIMETER
(defrule worstperimeter
    ?phase <- (phase state-mcp)
    ?input <- (user-mcp ?number)
    (test (> ?number 0.05))
=>
(printout t "worst_perimeter? ")
    (retract ?phase)
    (assert (phase state-wp))
	(assert (user-wp (read))))

; RADIUS ERROR
(defrule radiuserror
    ?phase <- (phase state-wr)
    ?input <- (user-wr ?number)
    (test (<= ?number 16.83))
=>
(printout t "radius_error? ")
    (retract ?phase ?input)
    (assert (phase state-re))
	(assert (user-re (read))))

; MEAN TEXTURE WR
(defrule meantexture_wr   
    ?phase <- (phase state-wr)
    ?input <- (user-wr ?number)
    (test (> ?number 16.83))
=>
(printout t "mean_texture? ")
    (retract ?phase ?input)
    (assert (phase state-mt-wr))
	(assert (user-mt-wr (read))))

; MEAN TEXTURE MR WA
(defrule meantexture_mr_wa   
    ?phase <- (phase state-mr-wa)
    ?input <- (user-mr-wa ?number)
    (test (<= ?number 13.45))
=>
(printout t "mean_texture? ")
    (retract ?phase ?input)
    (assert (phase state-mt-mr))
	(assert (user-mt-mr (read))))

; WORST TEXTURE RE
(defrule worsttexture_re
    ?phase <- (phase state-re)
    ?input <- (user-re ?number)
    (test (<= ?number 0.63))
=>
(printout t "worst_texture? ")
    (retract ?phase ?input)
    (assert (phase state-wt-re))
	(assert (user-wt-re (read))))
    
; WORST TEXTURE WP
(defrule worsttexture_wp
    ?phase <- (phase state-wp)
    ?input <- (user-wp ?number)
    (test (<= ?number 114.45))
=>
(printout t "worst_texture? ")
    (retract ?phase ?input)
    (assert (phase state-wt-wp))
	(assert (user-wt-wp (read))))

; WORST AREA
(defrule worstarea_re
    ?phase <- (phase state-wt-re)
    ?input <- (user-wt-re ?number)
    (test (> ?number 30.15))
=>
(printout t "worst_Area? ")
    (retract ?phase ?input)
    (assert (phase state-wa))
	(assert (user-wa (read))))

; MEAN SMOOTHNESS
(defrule meansmoothness
    ?phase <- (phase state-re)
    ?input <- (user-re ?number)
    (test (> ?number 0.63))
=>
(printout t "mean_smoothness? ")
    (retract ?phase ?input)
    (assert (phase state-ms))
	(assert (user-ms (read))))
    
; CONCAVE POINTS ERROR
(defrule concave_points_error  
    ?phase <- (phase state-mt-wr)
    ?input <- (user-mt-wr ?number)
    (test (> ?number 16.19))
=>
(printout t "concave_points_error? ")
    (retract ?phase ?input)
    (assert (phase state-cpe))
	(assert (user-cpe (read))))

; WORST CONCAVE POINTS
(defrule worst_concave_points
    ?phase <- (phase state-wt-wp)
    ?input <- (user-wt-wp ?number)
    (test (<= ?number 25.65))
=>
(printout t "worst_concave_points? ")
    (retract ?phase)
    (assert (phase state-wcp))
	(assert (user-wcp (read))))

; PERIMETER ERROR
(defrule perimeter_error
    ?phase <- (phase state-wt-wp)
    ?input <- (user-wt-wp ?number)
    (test (> ?number 25.65))
=>
(printout t "perimeter_error? ")
    (retract ?phase)
    (assert (phase state-pe))
	(assert (user-pe (read))))
    
; MEAN RADIUS WA
(defrule meanradius_wa
    ?phase <- (phase state-wa)
    ?input <- (user-wa ?number)
    (test (> ?number 641.60))
=>
(printout t "mean_radius? ")
    (retract ?phase ?input)
    (assert (phase state-mr-wa))
	(assert (user-mr-wa (read))))

; MEAN RADIUS PE
(defrule mean_radius_pe
    ?phase <- (phase state-pe)
    ?input <- (user-pe ?number)
    (test (<= ?number 1.56))
=>
(printout t "mean_radius? ")
    (retract ?phase)
    (assert (phase state-mr-pe))
	(assert (user-mr-pe (read))))

;============================
;| IS KANKER / IS NOT KANKER |
;============================

; IS NOT KANKER WP
(defrule isnotkanker_wp
    ?phase <- (phase state-wp)
    ?input <- (user-wp ?number)
    (test (> ?number 114.45))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS KANKER WT
(defrule iskanker_wt
    ?phase <- (phase state-wt-re)
    ?input <- (user-wt-re ?number)
    (test (<= ?number 30.45))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))    

; IS KANKER WA
(defrule iskanker_wa
    ?phase <- (phase state-wa)
    ?input <- (user-wa ?number)
    (test (<= ?number 641.60))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin))) 

; IS NOT KANKER MT_MR
(defrule isnotkanker_mt_mr
    ?phase <- (phase state-mt-mr)
    ?input <- (user-mt-mr ?number)
    (test (<= ?number 28.79))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))   

; IS KANKER MT_MR
(defrule iskanker_mt_mr
    ?phase <- (phase state-mt-mr)
    ?input <- (user-mt-mr ?number)
    (test (> ?number 28.79))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS KANKER MR_WA
(defrule iskanker_mr_wa
    ?phase <- (phase state-mr-wa)
    ?input <- (user-mr-wa ?number)
    (test (> ?number 13.45))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS KANKER MS
(defrule iskanker_ms
    ?phase <- (phase state-ms)
    ?input <- (user-ms ?number)
    (test (<= ?number 0.09))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS NOT KANKER MS
(defrule isnotkanker_ms
    ?phase <- (phase state-ms)
    ?input <- (user-ms ?number)
    (test (> ?number 0.09))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))
    
; IS KANKER MT_WR
(defrule iskanker_mt_wr
    ?phase <- (phase state-mt-wr)
    ?input <- (user-mt-wr ?number)
    (test (<= ?number 16.19))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS KANKER CPE
(defrule iskanker_cpe
    ?phase <- (phase state-cpe)
    ?input <- (user-cpe ?number)
    (test (> ?number 0.01))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS NOT KANKER CPE
(defrule isnotkanker_cpe
    ?phase <- (phase state-cpe)
    ?input <- (user-cpe ?number)
    (test (<= ?number 0.01))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS KANKER WCP
(defrule iskanker_wcp
    ?phase <- (phase state-wcp)
    ?input <- (user-wcp ?number)
    (test (<= ?number 0.17))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS NOT KANKER WCP
(defrule isnotkanker_wcp
    ?phase <- (phase state-wcp)
    ?input <- (user-wcp ?number)
    (test (> ?number 0.17))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS NOT KANKER PE
(defrule isnotkanker_pe
    ?phase <- (phase state-pe)
    ?input <- (user-pe ?number)
    (test (> ?number 1.56))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))
    
; IS KANKER MR PE
(defrule iskanker_mr_pe
    ?phase <- (phase state-mr-pe)
    ?input <- (user-mr-pe ?number)
    (test (> ?number 13.34))
=>
(printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))

; IS NOT KANKER MR PE
(defrule isnotkanker_mr_pe
    ?phase <- (phase state-mr-pe)
    ?input <- (user-mr-pe ?number)
    (test (<= ?number 13.34))
=>
(printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract ?phase ?input)
    (assert (phase state-fin)))



; mean concave 1 v
; worst radius 1 v
; worst parameter 1 v
; radius error 1 v
; mean texture 2 v
; worst texture 2 v
; mean smoothness 1 v
; concave point error 1 v
; worst concave points 1 v
; perimeter error 1 v
; worst area 1 v
; mean radius 2
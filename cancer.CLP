 ; ======================================
 ; defrule Start
 ; Begins program for BetterFamily by asserting
 ; choose-action.
 ; ======================================


; START
(defrule start
=>
	(assert (phase state-start)))

; MEAN CONCAVE
(defrule meanconcave
    ?phase <- (phase state-start)
=>
(printout t "mean_concave_point?")
    (retract ?phase)
    (assert (phase state-mcp))
	(assert (user-mcp (read))))

; WORST RADIUS
(defrule worstradius
    ?phase <- (phase state-mcp)
    ?input <- (user-mcp ?number)
    (test (<= ?number 0.05))
=>
(printout t "worst_radius?")
    (retract ?phase ?input)
    (assert (phase state-wr))
	(assert (user-wr (read))))

; WORST PERIMETER
(defrule worstperimeter
    ?phase <- (phase state-mcp)
    ?input <- (user-mcp ?number)
    (test (> ?number 0.05))
=>
(printout t "worst_perimeter?")
    (retract ?phase)
    (assert (phase state-wp))
	(assert (user-wp (read))))

; RADIUS ERROR
(defrule radiuserror
    ?phase <- (phase state-wr)
    ?input <- (user-wr ?number)
    (test (<= ?number 16.83))
=>
(printout t "radius_error?")
    (retract ?phase ?input)
    (assert (phase state-re))
	(assert (user-re (read))))

; MEAN TEXTURE WR
(defrule meantexture_wr   
    ?phase <- (phase state-wr)
    ?input <- (user-wr ?number)
    (test (> ?number 16.83))
=>
(printout t "mean_texture?")
    (retract ?phase ?input)
    (assert (phase state-mt-wr))
	(assert (user-mt-wr (read))))

; MEAN TEXTURE MR
(defrule meantexture_mr   
    ?phase <- (phase state-mr)
    ?input <- (user-mr ?number)
    (test (<= ?number 13.45))
=>
(printout t "mean_texture?")
    (retract ?phase ?input)
    (assert (phase state-mt-mr))
	(assert (user-mt-wr (read))))

; WORST TEXTURE RE
(defrule worsttexture_re
    ?phase <- (phase state-re)
    ?input <- (user-re ?number)
    (test (<= ?number 0.63))
=>
(printout t "worst_texture?")
    (retract ?phase ?input)
    (assert (phase state-wt-re))
	(assert (user-wt-re (read))))
    
; WORST TEXTURE WP
(defrule worsttexture_wp
    ?phase <- (phase state-wp)
    ?input <- (user-wp ?number)
    (test (<= ?number 114.45))
=>
(printout t "worst_texture?")
    (retract ?phase ?input)
    (assert (phase state-wt-wp))
	(assert (user-wt-wp (read))))

; WORST AREA
(defrule worsttexture_re
    ?phase <- (phase state-wt-re)
    ?input <- (user-wt-re ?number)
    (test (> ?number 30.15))
=>
(printout t "worst_Area?")
    (retract ?phase ?input)
    (assert (phase state-wa))
	(assert (user-wa (read))))

; MEAN SMOOTHNESS
(defrule meansmoothness
    ?phase <- (phase state-re)
    ?input <- (user-re ?number)
    (test (> ?number 0.63))
=>
(printout t "mean_smoothness?")
    (retract ?phase ?input)
    (assert (phase state-ms))
	(assert (user-ms (read))))
    
; CONCAVE POINTS ERROR
(defrule concave_points_error  
    ?phase <- (phase state-mt-wr)
    ?input <- (user-mt-wr ?number)
    (test (> ?number 16.19))
=>
(printout t "concave_points_error  ?")
    (retract ?phase ?input)
    (assert (phase state-cpe))
	(assert (user-cpe (read))))

; WORST CONCAVE POINTS
(defrule worst_concave_points
    ?phase <- (phase state-wt-wp)
    ?input <- (user-wt-wp ?number)
    (test (<= ?number 25.65))
=>
(printout t "worst_concave_points?")
    (retract ?phase)
    (assert (phase state-wcp))
	(assert (user-wcp (read))))

; PERIMETER ERROR
(defrule perimeter_error
    ?phase <- (phase state-wt-wp)
    ?input <- (user-wt-wp ?number)
    (test (> ?number 25.65))
=>
(printout t "perimeter_error?")
    (retract ?phase)
    (assert (phase state-pe))
	(assert (user-pe (read))))
    
; MEAN RADIUS WA
(defrule meanradius_wa
    ?phase <- (phase state-wa)
    ?input <- (user-wa ?number)
    (test (> ?number 641.60))
=>
(printout t "worst_Area?")
    (retract ?phase ?input)
    (assert (phase state-mr-wa))
	(assert (user-mr-wa (read))))

; MEAN RADIUS PE
(defrule mean_radius_pe
    ?phase <- (phase state-pe)
    ?input <- (user-pe ?number)
    (test (> ?number 1.56))
=>
(printout t "perimeter_error?")
    (retract ?phase)
    (assert (phase state-mr-pe))
	(assert (user-mr-pe (read))))

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
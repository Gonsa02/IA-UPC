;;; Modulo para construir la solución(defmodule sintesis	(import MAIN ?ALL)	(import input ?ALL)	(export ?ALL))(deffunction sintesis::obtener_objetivos (?duracion_rutina $?enfermedades)	(bind ?nCardiovascular 0)	(bind ?nOsea 0)	(bind ?nMuscular 0)	(bind ?nRespiratoria 0)	(bind ?nHormonal 0)	(bind ?nNerviosa 0)	(progn$ (?enfermedad $?enfermedades)		(bind ?tipo (send ?enfermedad get-Afectación))		(switch ?tipo			(case Cardiovascular then (bind ?nCardiovascular (+ ?nCardiovascular 1)))			(case Osea then (bind ?nOsea (+ ?nOsea 1)))			(case Muscular then (bind ?nMuscular (+ ?nMuscular 1)))			(case Respiratoria then (bind ?nRespiratoria (+ ?nRespiratoria 1)))			(case Hormonal then (bind ?nHormonal (+ ?nHormonal 1)))			(case Nerviosa then (bind ?nNerviosa (+ ?nNerviosa 1)))		)	)			;; Creamos una lista donde aparecerán los objetivos ordenados según su frecuencia	;; Por el momento solo lo haremos sin ordenar y con los objetivos con valor > 0	(bind $?objetivos (create$))	if (> ?nCardiovascular 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Cardiovascular"))	if (> ?nOsea 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Osea"))	if (> ?nMuscular 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Muscular"))	if (> ?nRespiratoria 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Respiratoria"))	if (> ?nHormonal 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Hormonal"))	if (> ?nNerviosa 0) then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) "Nerviosa"))		;; Hacemos que para cada día haya un objetivo, de momento no nos preocupamos si tenemos más objetivos que días de rutina	(bind ?i 1)	while (< (length$ $?objetivos) ?duracion_rutina) do		if (= ?i (length$ $?objetivos)) then (bind ?i 1)		(bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) (nth$ ?i $?objetivos)))		(return $?objetivos))(deffunction sintesis::crear_sesion (?duracion_sesion ?objetivo)	(bind $?sesion (create$))	(bind ?tiempo_sesion 0)	(bind ?continue TRUE)		(while (and (> ?tiempo_sesion 0) (< ?tiempo_sesion ?duracion_sesion) ?continue) do		;; De momento no nos preocupamos si repetimos el mismo ejercicio		(bind ?continue (any-instancep ((?ej Ejercicio)) (and (eq ?ej:Tipo_Objetivo ?objetivo) (<= (+ ?tiempo_sesion ?ej:Tiempo_Ejercicio) ?duracion_sesion)))) ;; Hacerlo eficiente		(if (eq ?continue TRUE) then			(bind ?aux (find-instance ((?ej Ejercicio)) (<= (+ ?tiempo_sesion ?ej:Tiempo_Ejercicio) ?duracion_sesion)))			(bind $?sesion (insert$ $?sesion (+ (length$ $?sesion) 1) ?aux))			(bind ?tiempo_sesion (+ ?tiempo_sesion (send ?aux get-Tiempo_Ejercicio)))		else			(bind ?continue (any-instancep ((?act Actividad)) (and (eq ?act:Tipo_Objetivo ?objetivo) (<= (+ ?tiempo_sesion ?act:Tiempo_Actividad) ?duracion_sesion)))) ;; Hacerlo eficiente			if (eq ?continue TRUE) then			(bind ?aux (find-instance ((?act Actividad)) (<= (+ ?tiempo_sesion ?act:Tiempo_Actividad) ?duracion_sesion)))			(bind $?sesion (insert$ $?sesion (+ (length$ $?sesion) 1) ?aux))			(bind ?tiempo_sesion (+ ?tiempo_sesion (send ?aux get-Tiempo_Actividad)))		)	)		(make-instance (gensym) of Sesion (Acciones $?sesion)))(deffunction sintesis::crear_rutina (?paciente)	;; Obtenemos los parámetros de nuestro paciente	(bind ?duracion_rutina (send ?paciente get-Duracion_dias))	(bind ?duracion_sesion (send ?paciente get-duracion_sesion))	(bind $?padece (send ?paciente get-Padece))		;; Obtenemos una lista con solo las enfermedades del paciente	(bind $?enfermedades (create$))	;(progn$ (?aux $?padece)    ;    (if (= (type ?aux) Enfermedad)) then (bind $?enfermedades (insert$ $?enfermedades (+ (length$ $?enfermedades) 1) ?aux))    ;)    ;; Prueba    (bind $?enfermedades (insert$ $?enfermedades (length$ $?enfermedades) Cardiovascular))    (bind $?enfermedades (insert$ $?enfermedades (length$ $?enfermedades) Osea))		;; Creamos una lista con los objetivos	(bind ?objetivos (obtener_objetivos ?duracion_rutina $?enfermedades))		;; Creamos la rutina	(loop-for-count (?dia 1 ?duracion_rutina) do		(crear_sesion ?duracion_sesion (nth$ ?dia $?objetivos))	))(defrule sintesis::cambio_sintesis "Pasamos de descarte a síntesis"	(declare (salience -20)) ;; hay que poner en común los salience luego	=>	(printout t "Construyendo rutinas..." clrf)	(focus sintesis))(defrule sintesis::cambio_output "Pasamos de síntesis a output"	(declare (salience -20)) ;; hay que poner en común los salience luego	=>	(printout t "Escribiendo rutinas" clrf)	(focus output))
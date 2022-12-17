;;; Modulo para construir la solución
(defmodule sintesis
	(import MAIN ?ALL)
	(import input ?ALL)
	(export ?ALL)
)

(deffunction sintesis::obtener_objetivos (?duracion_rutina ?nFuerza ?nFlexibilidad ?nResistencia ?nEquilibrio)
	;; (1) Si el paciente tiene enfermedades (-> tiene almenos 1 objetivo > 0) calculamos sus objetivos con el siguiente método
	(if (or (> ?nFuerza 0)(> ?nFlexibilidad 0)(> ?nResistencia 0)(> ?nEquilibrio 0)) then
			
		;; Creamos una lista donde aparecerán los objetivos ordenados decrecientemente por su frecuencia
		;; Por el momento solo lo haremos sin ordenar y con los objetivos con valor > 0
		(bind $?objetivos (create$))
		(loop-for-count 4 do
			(if (and (> ?nFuerza 0)(>= ?nFuerza ?nFlexibilidad)(>= ?nFuerza ?nResistencia)(>= ?nFuerza ?nEquilibrio))
				then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) Fuerza)) (bind ?nFuerza -1))
			(if (and (> ?nFlexibilidad 0)(>= ?nFlexibilidad ?nFuerza)(>= ?nFlexibilidad ?nResistencia)(>= ?nFlexibilidad ?nEquilibrio))
				then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) Flexibilidad)) (bind ?nFlexibilidad -1))
			(if (and (> ?nResistencia 0)(>= ?nResistencia ?nFuerza)(>= ?nResistencia ?nFlexibilidad)(>= ?nResistencia ?nEquilibrio))
				then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) Resistencia)) (bind ?nResistencia -1))
			(if (and (> ?nEquilibrio 0)(>= ?nEquilibrio ?nFuerza)(>= ?nEquilibrio ?nFlexibilidad)(>= ?nEquilibrio ?nResistencia))
				then (bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) Equilibrio)) (bind ?nEquilibrio -1))
		)
		
		;; (2) Si no tiene enfermedades (-> todos los objetivos == 0) le añadimos todos los objetivos
		else (bind $?objetivos (create$ Fuerza Resistencia Flexibilidad Equilibrio))
	)
	
	;; Hacemos que para cada día de la rutina haya un objetivo fijado, repitiendo objetivos si hacen falta pero siguiendo su orden de frecuencia
	;; En el peor caso tendremos 3 días y un objetivo (el de menos frecuencia) que se quedará fuera
	(bind ?i 1)
	(while (< (length$ $?objetivos) ?duracion_rutina) do
		(bind $?objetivos (insert$ $?objetivos (+ (length$ $?objetivos) 1) (nth$ ?i $?objetivos)))
		(bind ?i (+ ?i 1))
	)
	
	(return $?objetivos)
)

(deffunction sintesis::es_repetido (?nombre $?lista)
	(bind ?result FALSE)
	(bind ?i 1)
	
	(while (and (<= ?i (length$ $?lista)) (eq ?result FALSE)) do
		(bind ?nombre2 (nth$ ?i $?lista))
		(if (eq ?nombre (send ?nombre2 get-nombre))
			then (bind ?result TRUE)
		)
		(bind ?i (+ ?i 1))
	)
	
	(return ?result)
)

(deffunction sintesis::crear_sesion_actividades (?duracion_sesion ?objetivo)
	(bind $?sesion (create$))
	(bind ?tiempo_sesion 0)
	(bind ?continue TRUE)
	(printout t "Intentamos crear la sesión con duración " ?duracion_sesion " y objetivo " ?objetivo crlf)
	
	(while (and (< ?tiempo_sesion ?duracion_sesion) (eq ?continue TRUE)) do
		(bind $?aux (find-instance ((?act Actividad)) (and (eq ?act:Tipo_Objetivo ?objetivo) (<= (+ ?tiempo_sesion ?act:Tiempo_Actividad) ?duracion_sesion) (not (es_repetido ?act:nombre $?sesion)) (not (any-instancep ((?ses Sesion)) (eq TRUE (es_repetido ?act:nombre ?ses:Es_un_conjunto_de)))) )))
		;; (not (any-instancep ((?ses Sesion)) (eq TRUE (member$ ?act ?ses:Es_un_conjunto_de))))
		(bind ?continue (> (length$ $?aux) 0))
		(if (eq ?continue TRUE) then
			(bind ?aux2 (nth$ 1 $?aux))
			(bind $?sesion (insert$ $?sesion (+ (length$ $?sesion) 1) ?aux2))
			(bind ?tiempo_sesion (+ ?tiempo_sesion (send ?aux2 get-Tiempo_Actividad)))
		)
	)
	
	(progn$ (?acc $?sesion)
		(printout t "He creado la sesión con la actividad " ?acc crlf)
	)
	
	(make-instance (gensym) of Sesion (Es_un_conjunto_de $?sesion) (Tipo_Objetivo ?objetivo) (Tiempo ?tiempo_sesion))
)

(deffunction sintesis::crear_sesion_ejercicios (?duracion_sesion ?objetivo)
	(bind $?sesion (create$))
	(bind ?tiempo_sesion 0)
	(bind ?continue TRUE)
	(printout t "Intentamos crear la sesión con duración " ?duracion_sesion " y objetivo " ?objetivo crlf)
	
	(while (and (< ?tiempo_sesion ?duracion_sesion) (eq ?continue TRUE)) do
		(bind $?aux (find-instance ((?ej Ejercicio)) (and (eq ?ej:Tipo_Objetivo ?objetivo) (<= (+ ?tiempo_sesion ?ej:Tiempo_Ejercicio) ?duracion_sesion) (not (es_repetido ?ej:nombre $?sesion)) (not (any-instancep ((?ses Sesion)) (eq TRUE (es_repetido ?ej:nombre ?ses:Es_un_conjunto_de)))) )))
		(bind ?continue (> (length$ $?aux) 0))
		(if (eq ?continue TRUE) then 
			(bind ?aux2 (nth$ 1 $?aux))
			(bind $?sesion (insert$ $?sesion (+ (length$ $?sesion) 1) ?aux2))
			(bind ?tiempo_sesion (+ ?tiempo_sesion (send ?aux2 get-Tiempo_Ejercicio)))
		)
	)
	
	(progn$ (?acc $?sesion)
		(printout t "He creado la sesión con el ejercicio " ?acc crlf)
	)
	
	(make-instance (gensym) of Sesion (Es_un_conjunto_de $?sesion) (Tipo_Objetivo ?objetivo) (Tiempo ?tiempo_sesion))
)

(defrule sintesis::start
	(declare (salience 30))
	=>
	(assert (nFuerza 0))
	(assert (nFlexibilidad 0))
	(assert (nResistencia 0))
	(assert (nEquilibrio 0))
)

(defrule sintesis::tratar_enfermedad
	(declare (salience 20))
	(nFuerza ?nFuerza)
	(nFlexibilidad ?nFlexibilidad)
	(nResistencia ?nResistencia)
	(nEquilibrio ?nEquilibrio)
	?enfermedad <- (object (is-a Enfermedad))
	=>
	(bind ?tipo (send ?enfermedad get-Afectacion))
	(switch ?tipo
		(case Cardiovascular then (modify ?nFlexibilidad (+ ?nFlexibilidad 1)) (modify ?nEquilibrio (+ ?nEquilibrio 1)))
		(case Osea then (modify ?nResistencia (+ ?nResistencia 1)) (modify ?nFlexibilidad (+ ?nFlexibilidad 1)) (modify ?nEquilibrio (+ ?nEquilibrio 1)))
		(case Muscular then (modify ?nFlexibilidad (+ ?nFlexibilidad 1)))
		(case Respiratoria then (modify ?nFuerza (+ ?nFuerza 1)) (modify ?nFlexibilidad (+ ?nFlexibilidad 1)) (modify ?nEquilibrio (+ ?nEquilibrio 1)))
		(case Hormonal then (modify ?nFuerza (+ ?nFuerza 1)) (modify ?nResistencia (+ ?nResistencia 1)))
		(case Nerviosa then (modify ?nEquilibrio (+ ?nEquilibrio 1)))
	)
)

(defrule sintesis::crear_rutina
	(declare (salience 10))
	(nFuerza ?nFuerza)
	(nFlexibilidad ?nFlexibilidad)
	(nResistencia ?nResistencia)
	(nEquilibrio ?nEquilibrio)
	?paciente <- (object (is-a Persona))
	=>
	(printout t "Empezamos la creacion de la rutina..." crlf)
	
	;; Obtenemos los parámetros de nuestro paciente
	(bind ?duracion_rutina (send ?paciente get-Duracion_dias))
	(bind ?duracion_sesion (send ?paciente get-duracion_sesion))
    
    ;; Creamos una lista con los objetivos de la rutina
    (bind $?objetivos (obtener_objetivos ?duracion_rutina ?nFuerza ?nFlexibilidad ?nResistencia ?nEquilibrio))
	
	;; Creamos la rutina
	(loop-for-count (?dia 1 ?duracion_rutina) do
		(if (= (mod (random) 2) 0)
			then (crear_sesion_ejercicios ?duracion_sesion (nth$ ?dia $?objetivos))
			else (crear_sesion_actividades ?duracion_sesion (nth$ ?dia $?objetivos))
		)
	)
)


(defrule sintesis::cambio_output "Pasamos de síntesis a output"
	(declare (salience -20)) ;; hay que poner en común los salience luego
	=>
	(printout t "Escribiendo rutinas..." crlf)
	(focus output)
)

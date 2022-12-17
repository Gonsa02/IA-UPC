(defclass Sesion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Es_un_conjunto_de
        (type INSTANCE)
        (create-accessor read-write))
    (slot Tipo_Objetivo
        (type SYMBOL)
        (create-accessor read-write))
    (slot Tiempo
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Circunstancia
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Antecedente
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (slot ZonaCuerpo
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Enfermedad
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (slot Afectacion
        (type SYMBOL)
        (create-accessor read-write))
    (slot Nivel
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Accion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot Intensidad
        (type SYMBOL)
        (create-accessor read-write))
    (slot Tipo_Objetivo
        (type SYMBOL)
        (create-accessor read-write))
    (slot ZonaCuerpo
        (type SYMBOL)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (multislot objeto
        (type STRING)
        (create-accessor read-write))
)

(defclass Actividad
    (is-a Accion)
    (role concrete)
    (pattern-match reactive)
    (slot Tiempo_Actividad
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Ejercicio
    (is-a Accion)
    (role concrete)
    (pattern-match reactive)
    (slot Tiempo_Ejercicio
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Padece
        (type INSTANCE)
        (create-accessor read-write))
    (slot Duracion_dias
        (type INTEGER)
        (create-accessor read-write))
    (slot Equilibrio
        (type SYMBOL)
        (create-accessor read-write))
    (slot Flexibilidad
        (type SYMBOL)
        (create-accessor read-write))
    (slot Fuerza_Muscular
        (type SYMBOL)
        (create-accessor read-write))
    (slot IMC
        (type SYMBOL)
        (create-accessor read-write))
    (slot Resistencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot duracion_sesion
        (type INTEGER)
        (create-accessor read-write))
    (slot edad
        (type INTEGER)
        (create-accessor read-write))
)

(defmodule MAIN
    (export ?ALL)
)
;; Módulo para extraer la información del usuario
(defmodule input
    (import MAIN ?ALL)
    (export ?ALL)
)
;; Módulo para descartar ejercicios y actividades incompatibles con el paciente
(defmodule descarte
    (import MAIN ?ALL)
    (export ?ALL)
)
;;; Modulo para construir la solución
(defmodule sintesis
	(import MAIN ?ALL)
	(import input ?ALL)
	(export ?ALL)
)
;; Módulo para imprimir la solución
(defmodule output
    (import MAIN ?ALL)
    (export ?ALL)
)

(deffunction input::obtener_edad ()
    ;printeamos pregunta
    (printout  t "Que edad tienes?" crlf)
    (bind ?edat (read))
    (while (< ?edat 0) do
            (printout t "No es una edad valida porfavor introduzca una edad valida" crlf) 
            (bind ?edat (read))
    )
    ;devolvemos la edad
    (return ?edat)
)

(deffunction input::obtenir_tipo_enfermedad ($?list_values)
    (printout t "Tienes algun tipo de enfermedad" crlf)
    (printout t "Estos son los tipos: " $?list_values crlf)
    (printout t "Para acabar escribe  FIN" crlf)
    (bind ?response (read))
    (bind $?return_list (create$))
    (while (not (eq ?response FIN)) do
        (if (and (member$ ?response $?list_values)(not(member$ ?response $?return_list)))then
            (bind $?return_list (insert$ $?return_list (+ (length$ $?return_list) 1) ?response))
        )
        (bind ?response (read))
    )
    (return $?return_list)
)
(deffunction input::obtenir_tipo_Antecentes ($?list_values)
    (printout t "Tienes algun tipo de Antecente?" crlf)
    (printout t "Estos son los tipos: " $?list_values crlf)
    (printout t "Para acabar escribe  FIN" crlf)
    (bind ?response (read))
    (bind $?return_list (create$))
    (while (not (eq ?response FIN)) do
        (if (and (member$ ?response $?list_values)(not(member$ ?response $?return_list)))then
            (bind $?return_list (insert$ $?return_list (+ (length$ $?return_list) 1) ?response))
        )
        (bind ?response (read))
    )
    (return $?return_list)
)

(deffunction input::instanciar_Antecendente (?tipo)
    (bind ?instancia (make-instance (gensym) of Antecedente (nombre ?tipo)(ZonaCuerpo ?tipo)))
    (return ?instancia)
)

(deffunction input::obtenir_enfermetats_tipos(?tipo $?nivel)
    (printout t "Que enfermedad del tipo " ?tipo " tienes" crlf)
    (printout t "Para acabar escribe  FIN" crlf)
    (bind ?response (read))
    (bind $?return_list (create$))
    (while (not (eq ?response FIN))do
        (printout t "Que nivel tienes de la enfermedad " ?response "? Estas son las opciones: " $?nivel crlf)
        (bind ?level (read))
        (while (not (member$ ?level $?nivel)) do
         (printout t "lo siento esta respuesta no es valida, vuelva a especificar el nivel" crlf)
         (bind ?level (read))
        )
        (bind ?instancia (make-instance (gensym) of Enfermedad (nombre ?response)(Afectacion ?tipo) (Nivel ?level)))
        (bind $?return_list (insert$ $?return_list (+ (length$ $?return_list) 1) ?instancia))
        (printout t "Introduce más enfermedades que puedas tener del tipo " ?tipo " o puedes parar escribiendo FIN" crlf)
        (bind ?response (read))
    )
    (return $?return_list)
)


(deffunction input::seleccion_una_opcion (?question $?opcions)
    (printout t ?question crlf)
    (printout t "Las opciones son: " $?opcions)
    (bind ?response (read))
    (while (not (member$ ?response $?opcions)) do 
        (printout t "No forma part de les opcions, porfavor eliga otra vez" crlf)
        (bind ?response (read))
    )
    (return ?response)
)
(deffunction input::seleccion_sobre_rango (?question ?min ?max)
    (printout t ?question crlf)
    (printout t "El valor tiene que ser mayor o igual a " ?min " y menor o igual a " ?max crlf)
    (bind ?response (read))
    (while (not (and (integerp ?response) (>= ?response ?min) (<= ?response ?max))) do
        (printout t "Valor invalido, porfavor vuelva a introducir uno nuevo" crlf)
        (bind ?response (read))
    )
    (return ?response)
)
(deffunction input::getIMC (?peso ?altura)
    (bind ?imc (/ ?peso (* ?altura ?altura)))
    (return ?imc)
)
(deffunction  input::inputfloat (?question ?valor)
    (printout t ?question crlf)
    (printout t "Introduce el dato con mínimo un decimal separando las unidades de las decimas con un punto (Ej " ?valor ")." crlf)
    (bind ?response (read))
    (while (not (floatp ?response)) do
        (printout t "El valor introducido no es válido, porfavor introdúzcalo separando las unidades de las decimas con un punto" crlf)
        (bind ?response (read))
    )
    (return ?response)
)

(deffunction input::valueOfIMC (?imc)
    (if (> ?imc 35.0) then (return Morvido))
    (if (and (<= ?imc 35.0) (> ?imc 30.0)) then (return Obeso))
    (if (and (<= ?imc 30.0) (> ?imc 25.0)) then (return Sobrepeso))
    (if (and (<= ?imc 25.0) (> ?imc 18.5)) then (return Normal))
    (return Delgado)
)

(deffunction input::instanciacion_persona ()
    ; preguntamos edad
    (bind ?edad (obtener_edad))
    (bind ?peso (inputfloat "¿Cuál es su peso en Kg?" 75.0))
    (bind ?estatura (inputfloat "¿Cuál es su estatura en Metros?" 1.8))
    (bind ?IMC (getIMC ?peso ?estatura))
    (bind ?valueIMC (valueOfIMC ?IMC))
    ;preguntamos escalas
    (bind ?fuerza (seleccion_una_opcion "¿Cómo describirías con estas opciones tu fuerza? " Baja Media Alta))
    (bind ?equilibrio (seleccion_una_opcion "¿Cómo describirías con estas opciones tu equilibrio? " Baja Media Alta))
    (bind ?resistencia (seleccion_una_opcion "¿Cómo describirías con estas opciones tu resistencia? " Baja Media Alta))
    (bind ?flexibilidad (seleccion_una_opcion "¿Cómo describirías con estas opciones tu flexibilidad? " Baja Media Alta))
    ; Preguntamos si tiene algun tipo de enfermedad
    (bind $?lista (obtenir_tipo_enfermedad Cardiovascular Osea Muscular Respiratoria Hormonal Nerviosa))
    
    (bind $?enfermedades (create$))
    (progn$ (?tipo $?lista)
        (bind $?list (create$))
        (bind $?list (obtenir_enfermetats_tipos ?tipo Temprano Medio Avanzado))
        (progn$(?instance $?list)
            (bind $?enfermedades (insert$ $?enfermedades (+(length$ $?enfermedades) 1) ?instance))
        )
    )
    ;preguntamos los antecente
    (bind $?lista2 (obtenir_tipo_Antecentes Brazos Piernas Cuello Cabeza Tronco))
    (progn$(?instance $?lista2)
            (bind $?enfermedades (insert$ $?enfermedades (+(length$ $?enfermedades) 1) (instanciar_Antecendente ?instance)))
    )
   

    (bind ?duracion_rutina (seleccion_sobre_rango "¿De cuanto dias desea la duracion de la rutina?" 3 7) )
    (bind ?duracion_sesion (seleccion_una_opcion "¿De cuantos minutos desea la sesion de cada sesion que compone la rutina?" 30 60 90))

    ;(printout t "La edad es: " ?edad crlf)
    ;(printout t "instancias: " $?enfermedades crlf)
    ;(printout t "duracion rutina: " ?duracion_rutina crlf)
    ;(printout t "duracion sesion: " ?duracion_sesion crlf)
    (make-instance Paciente of Persona (Padece $?enfermedades)(IMC ?valueIMC)(Duracion_dias ?duracion_rutina)(Equilibrio ?equilibrio) (Flexibilidad ?flexibilidad)(Fuerza_Muscular ?fuerza) (Resistencia ?resistencia) (duracion_sesion ?duracion_sesion) (edad ?edad))
)
(deffunction MAIN::instanciar_ejercicio (?nombre_ejercicio ?objetivo ?zonacuerpo ?objeto ?corte $?intensidades_tiempos)
    (bind $?intensidades (subseq$ $?intensidades_tiempos 1 ?corte))
    (bind $?tiempos (subseq$ $?intensidades_tiempos (+ ?corte 1) (length$ $?intensidades_tiempos)))
    (progn$ (?tiempo $?tiempos)
        (progn$ (?intensidad $?intensidades)
            (make-instance (gensym) of Ejercicio (nombre ?nombre_ejercicio)(ZonaCuerpo ?zonacuerpo)(Tipo_Objetivo ?objetivo)(objeto ?objeto)(Intensidad ?intensidad)(Tiempo_Ejercicio ?tiempo))
        )
    )
)
(deffunction MAIN::instanciar_actividad (?nombre_actividad ?objetivo ?zonacuerpo ?objeto ?corte $?intensidades_tiempos)
    (bind $?intensidades (subseq$ $?intensidades_tiempos 1 ?corte))
    (bind $?tiempos (subseq$ $?intensidades_tiempos (+ ?corte 1) (length$ $?intensidades_tiempos)))
    (progn$ (?tiempo $?tiempos)
        (progn$ (?intensidad $?intensidades)
            (make-instance (gensym) of Actividad (nombre ?nombre_actividad) (Tipo_Objetivo ?objetivo) (ZonaCuerpo ?zonacuerpo) (objeto ?objeto)(Intensidad ?intensidad)(Tiempo_Actividad ?tiempo))
        )
    )
)

(deffunction MAIN::setup ()

    (bind $?tiempos_ejercicio (create$ Alta Media Baja 15 10 5))
    (bind $?tiempos_actividad (create$ Alta Media Baja 90 60 30))

    (instanciar_ejercicio "Burpees" Resistencia Brazos "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Escaleras" Resistencia Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Bicicleta" Resistencia Piernas "Bicicleta estatica" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Press Banca" Fuerza Brazos "Mancuernas" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Press con mancuernas" Fuerza Brazos "Mancuernas" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Press de hombros" Fuerza Brazos "Mancuernas" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Remo" Resistencia Tronco "Maquina de remo" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Saltar a la cuerda" Resistencia Piernas "Cuerda" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Sentadillas" Resistencia Brazos "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Zancada con salto" Resistencia Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Sentadillas goblet" Fuerza Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Peso muerto" Fuerza Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Flexiones sobre pared" Fuerza Tronco "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Sentadillas goblet" Fuerza Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Curl de martillo" Fuerza Brazos "Mancuernas" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Pata coja" Equilibrio Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Marcha en línea" Equilibrio Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Elevaciones laterales" Equilibrio Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Elevaciones boca abajo" Fuerza Cuello "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Elevaciones boca arriba" Fuerza Cuello "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Ejercicio isométrico hacia los lados" Fuerza Cuello "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Esfera de reloj" Equilibrio Brazos "Nada" 3 ?tiempos_ejercicio)
    (instanciar_ejercicio "Levantamiento de brazo" Equilibrio Brazos "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Estiramiento lumbar" Flexibilidad Tronco "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Estiramiento isquiotibial" Flexibilidad Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Estiramiento frontal" Flexibilidad Piernas "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Zancada con rotación" Flexibilidad Tronco "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Postura del gato" Flexibilidad Tronco "Nada" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Puente con pelota" Flexibilidad Tronco "Pelota medicinal" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Flexiones de bíceps" Flexibilidad Brazos "Bandas elásticas" 3 $?tiempos_ejercicio)
    (instanciar_ejercicio "Patada de glúteos" Flexibilidad Piernas "Nada" 3 $?tiempos_ejercicio)
    ; actividades
    (instanciar_actividad "Caminar" Resistencia Piernas "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Aeróbic acúatico" Resistencia Brazos "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Pilates" Resistencia Tronco "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Ciclismo" Resistencia Piernas "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Surf" Equilibrio Tronco "Tabla de surf" 3 $?tiempos_actividad)
    (instanciar_actividad "Natación" Resistencia Tronco "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Yoga" Flexibilidad Tronco "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Senderismo" Resistencia Piernas "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Petanca" Fuerza Brazos "Bolas de petanca" 3 $?tiempos_actividad)
    (instanciar_actividad "Baile" Equilibrio Tronco "Nada" 3 $?tiempos_actividad)
    (instanciar_actividad "Tai-chi" Flexibilidad Tronco "Nada" 3 $?tiempos_actividad)

    
)   
(defrule input::creacion_persona
 (declare (salience 10)) => 
 (printout t "Ahora te haremos unas preguntas para poder generar la rutina que mejor se adapte a ti." crlf)
 (printout t crlf)
 (instanciacion_persona)
 (printout t "Pasamos a la fase de Descarte" crlf crlf)
 (focus descarte)
)

(defrule MAIN::setup_program
    (declare(salience 30))
    =>
    (setup)
)
(defrule MAIN::inicio 
(declare (salience 20)) 
=> 
(printout t "######" crlf)
(printout t "#     #  #####     ##     ####    #####     #     ####     ##" crlf) 
(printout t "#     #  #    #   #  #   #    #     #       #    #    #   #  #" crlf) 
(printout t "######   #    #  #    #  #          #       #    #       #    #" crlf)
(printout t "#        #####   ######  #          #       #    #       ######" crlf) 
(printout t "#        #   #   #    #  #    #     #       #    #    #  #    #" crlf) 
(printout t "#        #    #  #    #   ####      #       #     ####   #    #" crlf)
(printout t crlf)    
(focus input)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule descarte::alta_intensidad_con_lesiones "quita las acciones de intensidad alta si hay lesion previa"
    (declare (salience 10))
    (object (is-a Antecedente) (ZonaCuerpo ?z1))
    ?inst <- (object (is-a Accion) (ZonaCuerpo ?z2) (Intensidad ?i))
    (test (and (eq ?z1 ?z2) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::duracion_con_lesiones "quita las actividades muy largas que no son de flexibilidad si hay lesion previa"
    (declare (salience 10))
    (object (is-a Antecedente) (ZonaCuerpo ?z1))
    ?inst <- (object (is-a Actividad) (ZonaCuerpo ?z2) (Tipo_Objetivo ?o) (Tiempo_Actividad ?t))
    (test (and (eq ?z1 ?z2) (neq ?o Flexibilidad) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule descarte::alta_intensidad_con_problemas_cardiovasculares "quita las acciones de intensidad alta si se padece de un problema cardiovascular"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::intensidad_con_problema_cardivascular_grave "quita las acciones de intensidad media si se padece de un problema cardiovascular grave"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (eq ?i Media) (eq ?n Avanzado)))
    => (send ?inst delete)
)

(defrule descarte::duracion_con_problema_cardivascular_medio_grave "limita la duración de una actividad si se padece de un problema cardiovascular medio o grave y la intensidad no es baja"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (or (eq ?t 90) (eq ?t 60)) (or (eq ?n Medio) (eq ?n Avanzado)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule descarte::resistencia_fuera_alta_intensidad_con_problemas_respiratorios "quita las acciones de intensidad alta si se padece de problemas respiratorios"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Respiratoria) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::problemas_respiratorios_graves "Límita las actividades de fuerza y resistencia a 60 minutos si se padece de una enfermedad respiratoria grave"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Tipo_Objetivo ?o))
    (test (and (eq ?a Respiratoria) (eq 90 ?t) (eq ?n Avanzado) (or (eq ?o Fuerza) (eq ?o Resistencia))))
    => (send ?inst delete)
)

(defrule descarte::problemas_respiratorios_medios "Límita las actividades de resistencia a 60 minutos si se padece de una enfermedad respiratorio media"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Tipo_Objetivo ?o))
    (test (and (eq ?a Respiratoria) (eq 90 ?t) (eq ?n Avanzado) (eq ?o Resistencia)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_cardiacas_graves_con_oseas_medias_graves "las personas con una enfermedad cardíaca grave y con problemas oseos medios o graves no pueden realizar deporte"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a1) (Nivel ?n1))
    (object (is-a Enfermedad) (Afectacion ?a2) (Nivel ?n2))
    ?inst <- (object (is-a Accion))
    (test (and (eq ?a1 Cardiovascular) (eq ?n1 Avanzado) (eq ?a2 Osea) (neq ?n2 Temprano)))
    => (send ?inst delete)
)

(defrule descarte::limita_tiempo_enfermedad_osea "las personas con una enfermedad osea no deberían realizar actividades de más de 60 min"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t))
    (test (and (eq ?a Osea) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_oseas_graves "las personas con enfermedades oseas graves no pueden realizar ejercicios de Fuerza de alta intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Osea) (eq ?i Alta) (eq ?o Fuerza)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_musculares_graves "quita las acciones que la gente con problemas musculares graves no puede realizar"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Muscular) (eq ?n Avanzado) (or (eq ?o Equilibrio) (eq ?o Muscular)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_musculares_medias "quita las acciones que la gente con problemas musculares medios no puede realizar"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Muscular) (eq ?n Medio) (or (eq ?o Equilibrio) (eq ?o Muscular)) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_musculares_leves "quita las acciones de más de 60 min a las personas con problemas musculares leves"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t))
    (test (and (eq ?a Muscular) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_hormonales "las personas con enfermedades hormonales no pueden hacer ejercicios de alta intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Hormonal) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_nerviosas_graves "las personas con enfermedades nerviosas graves solo pueden hacer ejercicios con Tipo_Objetivo de flexibilidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o))
    (test (and (eq ?a Nerviosa) (eq ?n Avanzado) (neq ?o Flexibilidad)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_nerviosas_medias "las personas con enfermedades nerviosas medias solo pueden hacer ejercicios de media i baja intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Nerviosa) (eq ?n Medio) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::enfermedades_nerviosas "las personas con enfermedades nerviosas si hacen acciones de equilibro solo pueden realizar las de baja intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Nerviosa) (eq ?o Equilibrio) (neq Intensidad Baja)))
    => (send ?inst delete)
)

(defrule descarte::obesidad_morvida "las personas con obesidad morvida solo pueden hacer acciones de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?x Morvido) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule descarte::obesidad "las personas con obesidad solo pueden hacer ejercicios de media intensidad como mucho menos en resistencia que solo van a poder hacer ejercicios de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?x Obeso) (or (eq ?i Alta) (and (eq ?i Media) (eq ?o Resistencia)))))
    => (send ?inst delete)
)

(defrule descarte::sobrepeso "las personas con sobrepeso solo puede hacer ejercicios de media intensidad como mucho"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?x Obeso) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::obesidad_morvida_y_problemas_cardiovasculares_o_respiratorios "las personas con obesidad morvida, problemas cardiovasculares o problemas respiratorios no pueden realizar deporte hasta que no adelgazen (dieta)"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion))
    (test (and (eq ?x Morvido) (or (eq ?a Cardiovascular) (eq ?a Respiratoria))))
    => (send ?inst delete)
)

(defrule descarte::obesidad_y_problemas_cardiovasculares_o_respiratorios "las personas con obesidad, problemas cardivasculares o respiratorios solo pueden realizar ejercicio de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    (object (is-a Enfermedad) (Afectacion ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?x Obeso) (or (eq ?a Cardiovascular) (eq ?a Respiratoria)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule descarte::mas_90_años "las personas con más de 90 años solo pueden realizar ejercicios de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (> ?e 90) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule descarte::mas_80_años "las personas con más de 80 años solo pueden realizar ejercicios de media intensidad en Equilibrio, Flexbilidad y Resistencia, pero baja en Fuerza"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (> ?e 80) (or (and (eq ?i Alta) (or (eq ?o Equilibrio) (eq ?o Flexbilidad) (eq ?o Resistencia))) (and (neq ?i Baja) (eq ?o Fuerza)))))
    => (send ?inst delete)
)

(defrule descarte::mas_70_años "las personas con más de 70 años solo pueden realizar ejercicios de media intensidad"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (> ?e 70) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule descarte::duracion_maxima_80 "las personas entre 80 y 90 años ya no hacen ejercicios de 15 min"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Ejercicio) (Tiempo_Ejercicio ?t))
    (test (and (> ?e 80) (eq ?t 15)))
    => (send ?inst delete)
)

(defrule descarte::duracion_maxima_mas_de_90 "las personas con más de 90 años ya no hacen ejercicios de 10 min"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Ejercicio) (Tiempo_Ejercicio ?t))
    (test (and (> ?e 90) (or (eq ?t 15) (eq ?t 10))))
    => (send ?inst delete)
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
	;;(printout t "Intentamos crear la sesión con duración " ?duracion_sesion " y objetivo " ?objetivo crlf)
	
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
	
	(make-instance (gensym) of Sesion (Es_un_conjunto_de $?sesion) (Tipo_Objetivo ?objetivo) (Tiempo ?tiempo_sesion))
)

(deffunction sintesis::crear_sesion_ejercicios (?duracion_sesion ?objetivo)
	(bind $?sesion (create$))
	(bind ?tiempo_sesion 0)
	(bind ?continue TRUE)
	;;(printout t "Intentamos crear la sesión con duración " ?duracion_sesion " y objetivo " ?objetivo crlf)
	
	(while (and (< ?tiempo_sesion ?duracion_sesion) (eq ?continue TRUE)) do
		(bind $?aux (find-instance ((?ej Ejercicio)) (and (eq ?ej:Tipo_Objetivo ?objetivo) (<= (+ ?tiempo_sesion ?ej:Tiempo_Ejercicio) ?duracion_sesion) (not (es_repetido ?ej:nombre $?sesion)) (not (any-instancep ((?ses Sesion)) (eq TRUE (es_repetido ?ej:nombre ?ses:Es_un_conjunto_de)))) )))
		(bind ?continue (> (length$ $?aux) 0))
		(if (eq ?continue TRUE) then 
			(bind ?aux2 (nth$ 1 $?aux))
			(bind $?sesion (insert$ $?sesion (+ (length$ $?sesion) 1) ?aux2))
			(bind ?tiempo_sesion (+ ?tiempo_sesion (send ?aux2 get-Tiempo_Ejercicio)))
		)
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

(defrule descarte::cambio_sintesis "Pasamos de descarte a síntesis cuando ya no hay nada más que descartar"
	(declare (salience -20)) ;; hay que poner en común los salience luego
	=>
	(printout t "Construyendo rutinas..." crlf)
	(printout t crlf)
	(focus sintesis)
)


(defrule sintesis::cambio_output "Pasamos de síntesis a output"
	(declare (salience -20)) ;; hay que poner en común los salience luego
	=>
	(printout t "Escribiendo rutinas..." crlf)
	(focus output)
)

(deffunction output::printAccion (?accion)
    (bind ?nombre (send ?accion get-nombre))
    (bind ?objetivo (send ?accion get-Tipo_Objetivo))
    (bind ?intensidad (send ?accion get-Intensidad))
    (bind ?zonaCuerpo (send ?accion get-ZonaCuerpo))
    (bind $?objetos (send ?accion get-objeto))
    (printout t "Nombre: " ?nombre crlf)
    (printout t "   Hacerlo con una intensidad " ?intensidad "." crlf)
    (printout t "   Principalmente, estarás trabajando la zona de " ?zonaCuerpo "." crlf)
    (if (member$ "Nada" $?objetos) then
        (printout t "   No necesitarás ningún tipo de objeto para realizar este ejercicio." crlf)
        else (printout t "   Para realizar el ejercicio necesitarás los siguientes objetos:")
        (progn$ (?obj $?objetos)
            (printout t " " ?obj)
        )
        (printout t "." crlf)
    )
)

(deffunction output::printEjercicio (?ejercicio)
    (printAccion ?ejercicio)
    (bind ?tiempo_ejercicio (send ?ejercicio get-Tiempo_Ejercicio))
    (printout t "   Es recomendable hacer este ejercicio por un período de " ?tiempo_ejercicio " minutos." crlf)
)

(deffunction output::printActividad (?actividad)
    (printAccion ?actividad)
    (bind ?tiempo_actividad (send ?actividad get-Tiempo_Actividad))
    (printout t "   Es recomendable hacer este ejercicio por un período de " ?tiempo_actividad " minutos" crlf)
)

(defrule output::mostrarSesion 
    (declare (salience 10))
    ?sesion <- (object (is-a Sesion))
    =>
    (bind ?objetivo (send ?sesion get-Tipo_Objetivo))
    (bind ?tiempo (send ?sesion get-Tiempo))
    
    (printout t crlf) (printout t "-------------------------------------------------------------------------------------" crlf)
    (printout t "Harás esta sesión con el objetivo principal de conseguir " ?objetivo ". (Tiempo: " ?tiempo " min)" crlf)
    
    (bind $?acciones (send ?sesion get-Es_un_conjunto_de))
    (progn$ (?accion $?acciones)
    	(printout t crlf)
        (if (eq (type ?accion) Ejercicio) then (printEjercicio ?accion)
         else  (printActividad ?accion)
        )
    )
    (printout t crlf)
)
	

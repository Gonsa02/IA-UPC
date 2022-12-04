(defclass Accion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot Intensidad
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
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Ejercicio
    (is-a Accion)
    (role concrete)
    (pattern-match reactive)
    (slot Tiempo_Ejercicio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot Tipo_Objetivo
        (type SYMBOL)
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
(defclass Enfermedad
    (is-a Circunstancia)
    (role concrete)
    (pattern-match reactive)
    (slot Afectación
        (type SYMBOL)
        (allowed-values Cardiovascular Osea Muscular Respiratoria Hormonal Nerviosa)
        (create-accessor read-write))
    (slot Nivel
        (type SYMBOL)
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
    (slot Resistencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot duracion_sesion
        (type INTEGER)
        (create-accessor read-write))
    (slot edad
        (type SYMBOL)
        (create-accessor read-write))
)

(defmodule MAIN
    (export ?ALL)
)
(defmodule input
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
        (printout t "Que nivel tienes de la enfermedad " ?response " tienes, estas son las opciones: " $?nivel crlf)
        (bind ?level (read))
        (while (not (member$ ?level $?nivel)) do
         (printout t "lo siento esta respuesta no es valida, vuelva a especificar el nivel" crlf)
         (bind ?level (read))
        )
        (bind ?instancia (make-instance (gensym) of Enfermedad (nombre ?response)(Afectación ?tipo) (Nivel ?level)))
        (bind $?return_list (insert$ $?return_list (+ (length$ $?return_list) 1) ?instancia))
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
(deffunction input::instanciacion_persona ()
    ; preguntamos edad
    (bind ?edad (obtener_edad))
   

    ;preguntamos escalas
    (bind ?fuerza (seleccion_una_opcion "Como describirías con estas opciones tu fuerza" BAJO MEDIO ALTO))
    (bind ?equilibrio (seleccion_una_opcion "Como describirías con estas opciones tu equilibrio" BAJO MEDIO ALTO))
    (bind ?resistencia (seleccion_una_opcion "Como describirías con estas opciones tu resistencia" BAJO MEDIO ALTO))
    (bind ?flexibilidad (seleccion_una_opcion "Como describirías con estas opciones tu flexibilidad" BAJO MEDIO ALTO))
    ;preguntamos si tiene algun tipo de enfermedad
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

   

    (bind ?duracion_rutina (seleccion_sobre_rango "De cuanto dias desea la duracion de la rutina" 3 7) )
    (bind ?duracion_sesion (seleccion_una_opcion "De cuantos minutos desea la sesion de cada sesion que compone la rutina" 30 60 90))

    ;(printout t "La edad es: " ?edad crlf)
    ;(printout t "instancias: " $?enfermedades crlf)
    ;(printout t "duracion rutina: " ?duracion_rutina crlf)
    ;(printout t "duracion sesion: " ?duracion_sesion crlf)
    (make-instance Paciente of Persona (Padece $?enfermedades)(Duracion_dias ?duracion_rutina)(Equilibrio ?equilibrio) (Flexibilidad ?flexibilidad)(Fuerza_Muscular ?fuerza) (Resistencia ?resistencia) (duracion_sesion ?duracion_sesion) (edad ?edad))

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
(deffunction MAIN::instanciar_actividad (?nombre_actividad ?zonacuerpo ?objeto ?corte $?intensidades_tiempos)
    (bind $?intensidades (subseq$ $?intensidades_tiempos 1 ?corte))
    (bind $?tiempos (subseq$ $?intensidades_tiempos (+ ?corte 1) (length$ $?intensidades_tiempos)))
    (progn$ (?tiempo $?tiempos)
        (progn$ (?intensidad $?intensidades)
            (make-instance (gensym) of Actividad (nombre ?nombre_actividad) (ZonaCuerpo ?zonacuerpo) (objeto ?objeto)(Intensidad ?intensidad)(Tiempo_Actividad ?tiempo))
        )
    )
)

(deffunction MAIN::setup ()

    (bind $?tiempos_ejercicio (create$ Baja Media Alta 5 10 15))
    (bind $?tiempos_actividad (create$ Baja Media Alta 30 60 90))

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


    
)   
(defrule input::creacion_persona
 (declare (salience 10)) => 
 (printout t "Ahora te haremos unas preguntas sobre ti para saber sobre ti." crlf)
 (printout t crlf)
 (instanciacion_persona)
 ;falta el focus a la fase de descarte
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


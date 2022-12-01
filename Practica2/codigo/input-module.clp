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
    (while (and (integerp ?response) (>= ?response ?min) (<= ?response ?min)) do
        (printout t "Valor invalido, porfavor vuelva a introducir uno nuevo" crlf)
        (bind ?response (read))
    )
    (return ?response)
)
(deffunction input::instanciacion_persona ()
    ; preguntamos edad
    (bind ?edat (obtener_edad))
   

    ;preguntamos escalas
    (bind ?fuerza (seleccion_una_opcion "Como describirías con estas opciones tu fuerza" BAJO MEDIO ALTO))
    (bind ?equilibrio (seleccion_una_opcion "Como describirías con estas opciones tu equilibrio" BAJO MEDIO ALTO))
    (bind ?resistencia (seleccion_una_opcion "Como describirías con estas opciones tu resistencia" BAJO MEDIO ALTO))
    (bind ?fuerza (seleccion_una_opcion "Como describirías con estas opciones tu flexibilidad" BAJO MEDIO ALTO))
    ;preguntamos si tiene algun tipo de enfermedad
    (bind $?lista (obtenir_tipo_enfermedad Cardiovascular Osea Muscular Respiratoria Hormonal Nerviosa))
    
    (bind $?enfermedades (create$))
    (progn$ (?tipo $?lista)
        (bind $?list (create$))
        (bind $?list (obtenir_enfermetats_tipos ?tipo temprano medio avanzado))
        (progn$(?instance $?list)
            (bind $?enfermedades (insert$ $?enfermedades (+(length$ $?enfermedades) 1) ?instance))
        )
    )
    ;preguntamos los antecente
    (bind $?lista2 (obtenir_tipo_Antecentes brazos piernas cuello cabeza tronco))
    (progn$(?instance $?lista2)
            (bind $?enfermedades (insert$ $?enfermedades (+(length$ $?enfermedades) 1) (instanciar_Antecendente ?instance)))
    )

   

    (bind ?duracion_rutina (seleccion_sobre_rango "De cuanto dias desea la duracion de la rutina" 3 7) )
    (bind ?duracion_sesion (seleccion_una_opcion "De cuantos minutos desea la sesion de cada sesion que compone la rutina" 30 60 90))

    ;(printout t "La edad es: " ?edat crlf)
    ;(printout t "instancias: " $?enfermedades crlf)
    ;(printout t "duracion rutina: " ?duracion_rutina crlf)
    ;(printout t "duracion sesion: " ?duracion_sesion crlf)
)





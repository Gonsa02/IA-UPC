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
)
(defmodule MAIN
    (export ?ALL)
)
(defmodule output
    (import MAIN ?ALL)
    (export ?ALL)
)

(deffunction output::printAccion (?accion)
    (bind ?nombre (send ?accion get-nombre))
    (bind ?objetivo (send ?accion get-Tipo_Objetivo))
    (bind ?intensidad (send ?accion get-Intensidad))
    (bind ?zonaCuerpo (send ?accion get-ZonaCuerpo))
    (bind $?objetos (send ?accion get-objeto))
    (printout t "Nombre: " ?nombre crlf)
    (printout t "   Hacerlo con una intensidad " ?intensidad " y con el objetivo de conseguir " ?objetivo crlf)
    (printout t "   Principalmente, estarás trabajando la zona de " ?zonaCuerpo)
    (if (member$ "  Nada" $?objetos)then
        (printout t "   No necesitarás ningún tipo de objeto para realizar este ejercicio" crlf)
        else (printout t "  Para realizar el ejercicio necesitarás los siguientes objetos:" crlf)
        (progn$ (?obj $?objetos)
            (printout t "       " ?obj crlf)
        )
    )
)
(deffunction output::printActividad (?actividad)
    (printAccion ?actividad)
    (bind ?tiempo_actividad (send ?actividad get-Tiempo_Actividad))
    (printout t "   Es recomendable hacer este ejercicio por un período de " ?tiempo_actividad " minutos" crlf)
)
(deffunction output::printEjercicio (?ejercicio)
    (printAccion ?ejercicio)
    (bind ?tiempo_ejercicio (send ?ejercicio get-Tiempo_Ejercicio))
    (printout t "   Es recomendable hacer este ejercicio por un período de " ?tiempo_ejercicio " minutos" crlf)
)
(deffunction output::printSesion (?sesion)
    (bind ?objetivo (send ?sesion get-Tipo_Objetivo))
    (printout t "Harás esta sesion con el objetivo principal de conseguir "?objetivo crlf)
    (bind $?acciones (send ?sesion get-Es_un_conjunto_de))
    (progn$ (?accion $?acciones)
        (if (eq (type ?accion) Ejercicio) then (printEjercicio ?accion)
         else  (printActividad ?accion)
        )
    )
)
(defrule mostrarSesion 
    (declare (salience 10))
    ?instancia <- (object (is-a Sesion))
    =>
    (printSesion ?instancia)
    (printout t clrf)
)

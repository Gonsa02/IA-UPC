;;; ---------------------------------------------------------
;;; ontologia-8.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia-8.owl
;;; :Date 03/12/2022 16:29:05

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
    (slot Afectación
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
    (slot Intesidad
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
    (multislot Complementa
        (type INSTANCE)
        (create-accessor read-write))
    (slot Tiempo_Actividad
        (type SYMBOL)
        (create-accessor read-write))
    (slot Tipo_de_Actividad
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Ejercicio
    (is-a Accion)
    (role concrete)
    (pattern-match reactive)
    (multislot Ayuda_a_contrarestar
        (type INSTANCE)
        (create-accessor read-write))
    (multislot Contraindicado_para
        (type INSTANCE)
        (create-accessor read-write))
    (slot Tiempo_Ejercicio
        (type SYMBOL)
        (create-accessor read-write))
    (slot ZonaCuerpo
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Objetivo
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Tipo_Objetivo
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

(defclass Sesion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Es_un_conjunto_de
        (type INSTANCE)
        (create-accessor read-write))
)

(definstances instances
)

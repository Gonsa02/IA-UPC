;;; ---------------------------------------------------------
;;; ontologia-10.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia-10.owl
;;; :Date 04/12/2022 17:29:22

(defclass Accion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot Intesidad
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
        (type INTEGER)
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
    ([Baile] of Actividad
    )

    ([Bicicleta] of Actividad
    )

    ([Burpees] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Burpees")
    )

    ([Caminata] of Actividad
    )

    ([Escaleras] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Escaleras")
         (objeto  "Maquina de escalera")
    )

    ([Gimansia] of Actividad
    )

    ([M.Bicicleta] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Bicicleta")
         (objeto  "Bicicleta estatica")
    )

    ([Natacion] of Actividad
    )

    ([Press_Banca] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "" "Press Banca")
    )

    ([Press_con_mancuernas] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Press con mancuernas")
         (objeto  "Mancuernas")
    )

    ([Press_de_hombros] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Press de hombros")
         (objeto  "Mancuernas")
    )

    ([Remo] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Remo")
         (objeto  "Maquina de remo")
    )

    ([Saltar_a_la_cuerda] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (objeto  "Cuerda")
    )

    ([Sentadillas] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Sentadillas")
    )

    ([Zancada_con_salto] of Ejercicio
         (Tiempo_Ejercicio  "")
         (Intesidad  "")
         (ZonaCuerpo  "")
         (nombre  "Zancada con salto")
    )

)

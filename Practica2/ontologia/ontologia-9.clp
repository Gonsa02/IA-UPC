;;; ---------------------------------------------------------
;;; ontologia-9.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia-9.owl
;;; :Date 04/12/2022 17:28:57

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
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Burpees")
    )

    ([Caminata] of Actividad
    )

    ([Equilibrio] of Objetivo
         (Tipo_Objetivo  "EQUILIBRIO")
    )

    ([Escaleras] of Ejercicio
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Escaleras")
         (objeto  "Maquina de escalera")
    )

    ([Flexibilidad] of Objetivo
         (Tipo_Objetivo  "FLEXIBILIDAD")
    )

    ([Fuerza] of Objetivo
         (Tipo_Objetivo  "FUERZA")
    )

    ([Gimansia] of Actividad
    )

    ([M.Bicicleta] of Ejercicio
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Bicicleta")
         (objeto  "Bicicleta estatica")
    )

    ([Natacion] of Actividad
    )

    ([Press_Banca] of Ejercicio
         (Ayuda_a_contrarestar  [Fuerza])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "" "Press Banca")
    )

    ([Press_con_mancuernas] of Ejercicio
         (Ayuda_a_contrarestar  [Fuerza])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Press con mancuernas")
         (objeto  "Mancuernas")
    )

    ([Press_de_hombros] of Ejercicio
         (Ayuda_a_contrarestar  [Fuerza])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Press de hombros")
         (objeto  "Mancuernas")
    )

    ([Remo] of Ejercicio
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Remo")
         (objeto  "Maquina de remo")
    )

    ([Resistencia] of Objetivo
         (Tipo_Objetivo  "RESISTENCIA")
    )

    ([Saltar_a_la_cuerda] of Ejercicio
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (objeto  "Cuerda")
    )

    ([Sentadillas] of Ejercicio
         (Ayuda_a_contrarestar  [Fuerza])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Sentadillas")
    )

    ([Zancada_con_salto] of Ejercicio
         (Ayuda_a_contrarestar  [Resistencia])
         (Tiempo_Ejercicio  "")
         (ZonaCuerpo  "")
         (Intesidad  "")
         (nombre  "Zancada con salto")
    )

)

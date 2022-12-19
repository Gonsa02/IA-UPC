(defrule alta_intensidad_con_lesiones "quita las acciones de intensidad alta si hay lesion previa"
    (declare (salience 10))
    (object (is-a Antecedente) (ZonaCuerpo ?z1))
    ?inst <- (object (is-a Accion) (ZonaCuerpo ?z2) (Intensidad ?i))
    (test (and (eq ?z1 ?z2) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule duracion_con_lesiones "quita las actividades muy largas que no son de flexibilidad si hay lesion previa"
    (declare (salience 10))
    (object (is-a Antecedente) (ZonaCuerpo ?z1))
    ?inst <- (object (is-a Actividad) (ZonaCuerpo ?z2) (Tipo_Objetivo ?o) (Tiempo_Actividad ?t))
    (test (and (eq ?z1 ?z2) (neq ?o Flexibilidad) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule alta_intensidad_con_problemas_cardiovasculares "quita las acciones de intensidad alta si se padece de un problema cardiovascular"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule intensidad_con_problema_cardivascular_grave "quita las acciones de intensidad media si se padece de un problema cardiovascular grave"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (eq ?i Media) (eq ?n Avanzado)))
    => (send ?inst delete)
)

(defrule duracion_con_problema_cardivascular_medio_grave "limita la duración de una actividad si se padece de un problema cardiovascular medio o grave y la intensidad no es baja"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Intensidad ?i))
    (test (and (eq ?a Cardiovascular) (or (eq ?t 90) (eq ?t 60)) (or (eq ?n Medio) (eq ?n Avanzado)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule resistencia_fuera_alta_intensidad_con_problemas_respiratorios "quita las acciones de intensidad alta si se padece de problemas respiratorios"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Respiratoria) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule problemas_respiratorios_graves "Límita las actividades de fuerza y resistencia a 60 minutos si se padece de una enfermedad respiratoria grave"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Tipo_Objetivo ?o))
    (test (and (eq ?a Respiratoria) (eq 90 ?t) (eq ?n Avanzado) (or (eq ?o Fuerza) (eq ?o Resistencia))))
    => (send ?inst delete)
)

(defrule problemas_respiratorios_medios "Límita las actividades de resistencia a 60 minutos si se padece de una enfermedad respiratorio media"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t) (Tipo_Objetivo ?o))
    (test (and (eq ?a Respiratoria) (eq 90 ?t) (eq ?n Avanzado) (eq ?o Resistencia)))
    => (send ?inst delete)
)

(defrule enfermedades_cardiacas_graves_con_oseas_medias_graves "las personas con una enfermedad cardíaca grave y con problemas oseos medios o graves no pueden realizar deporte"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a1) (Nivel ?n1))
    (object (is-a Enfermedad) (Afectación ?a2) (Nivel ?n2))
    ?inst <- (object (is-a Accion))
    (test (and (eq ?a1 Cardiovascular) (eq ?n1 Avanzado) (eq ?a2 Osea) (neq ?n2 Temprano)))
    => (send ?inst delete)
)

(defrule limita_tiempo_enfermedad_osea "las personas con una enfermedad osea no deberían realizar actividades de más de 60 min"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t))
    (test (and (eq ?a Osea) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule enfermedades_oseas_graves "las personas con enfermedades oseas graves no pueden realizar ejercicios de Fuerza de alta intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Osea) (eq ?i Alta) (eq ?o Fuerza)))
    => (send ?inst delete)
)

(defrule enfermedades_musculares_graves "quita las acciones que la gente con problemas musculares graves no puede realizar"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Muscular) (eq ?n Avanzado) (or (eq ?o Equilibrio) (eq ?o Muscular)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule enfermedades_musculares_medias "quita las acciones que la gente con problemas musculares medios no puede realizar"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Muscular) (eq ?n Medio) (or (eq ?o Equilibrio) (eq ?o Muscular)) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule enfermedades_musculares_leves "quita las acciones de más de 60 min a las personas con problemas musculares leves"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Actividad) (Tiempo_Actividad ?t))
    (test (and (eq ?a Muscular) (eq 90 ?t)))
    => (send ?inst delete)
)

(defrule enfermedades_hormonales "las personas con enfermedades hormonales no pueden hacer ejercicios de alta intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Hormonal) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule enfermedades_nerviosas_graves "las personas con enfermedades nerviosas graves solo pueden hacer ejercicios con Tipo_Objetivo de flexibilidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o))
    (test (and (eq ?a Nerviosa) (eq ?n Avanzado) (neq ?o Flexibilidad)))
    => (send ?inst delete)
)

(defrule enfermedades_nerviosas_medias "las personas con enfermedades nerviosas medias solo pueden hacer ejercicios de media i baja intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a) (Nivel ?n))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?a Nerviosa) (eq ?n Medio) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule enfermedades_nerviosas "las personas con enfermedades nerviosas si hacen acciones de equilibro solo pueden realizar las de baja intensidad"
    (declare (salience 10))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?a Nerviosa) (eq ?o Equilibrio) (neq Intensidad Baja)))
    => (send ?inst delete)
)

(defrule obesidad_morvida "las personas con obesidad morvida solo pueden hacer acciones de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?x Morvido) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule obesidad "las personas con obesidad solo pueden hacer ejercicios de media intensidad como mucho menos en resistencia que solo van a poder hacer ejercicios de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?x Obeso) (or (eq ?i Alta) (and (eq ?i Media) (eq ?o Resistencia)))))
    => (send ?inst delete)
)

(defrule sobrepeso "las personas con sobrepeso solo puede hacer ejercicios de media intensidad como mucho"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (eq ?x Obeso) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule obesidad_morvida_y_problemas_cardiovasculares_o_respiratorios "las personas con obesidad morvida, problemas cardiovasculares o problemas respiratorios no pueden realizar deporte hasta que no adelgazen (dieta)"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion))
    (test (and (eq ?x Morvido) (or (eq ?a Cardiovascular) (eq ?a Respiratoria))))
    => (send ?inst delete)
)

(defrule obesidad_y_problemas_cardiovasculares_o_respiratorios "las personas con obesidad, problemas cardivasculares o respiratorios solo pueden realizar ejercicio de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (IMC ?x))
    (object (is-a Enfermedad) (Afectación ?a))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (eq ?x Obeso) (or (eq ?a Cardiovascular) (eq ?a Respiratoria)) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule mas_90_años "las personas con más de 90 años solo pueden realizar ejercicios de baja intensidad"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (> ?e 90) (neq ?i Baja)))
    => (send ?inst delete)
)

(defrule mas_80_años "las personas con más de 80 años solo pueden realizar ejercicios de media intensidad en Equilibrio, Flexbilidad y Resistencia, pero baja en Fuerza"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Tipo_Objetivo ?o) (Intensidad ?i))
    (test (and (> ?e 80) (or (and (eq ?i Alta) (or (eq ?o Equilibrio) (eq ?o Flexbilidad) (eq ?o Resistencia))) (and (neq ?i Baja) (eq ?o Fuerza)))))
    => (send ?inst delete)
)

(defrule mas_70_años "las personas con más de 70 años solo pueden realizar ejercicios de media intensidad"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Accion) (Intensidad ?i))
    (test (and (> ?e 70) (eq ?i Alta)))
    => (send ?inst delete)
)

(defrule duracion_maxima_80 "las personas entre 80 y 90 años ya no hacen ejercicios de 15 min"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Ejercicio) (Tiempo_Ejercicio ?t))
    (test (and (> ?e 80) (eq ?t 15)))
    => (send ?inst delete)
)

(defrule duracion_maxima_mas_de_90 "las personas con más de 90 años ya no hacen ejercicios de 10 min"
    (declare (salience 10))
    (object (is-a Persona) (edad ?e))
    ?inst <- (object (is-a Ejercicio) (Tiempo_Ejercicio ?t))
    (test (and (> ?e 90) (or (eq ?t 15) (eq ?t 10))))
    => (send ?inst delete)
)

(defrule fuerza_intensidad_alta_con_base_media "Las personas que tienen un nivel medio de fuerza no pueden realizar ejercicios de alta intensidad de fuerza"
    (declare (salience 10))
    (object (is-a Persona) (Fuerza_Muscular ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Media) (eq ?i Alta))
    => (send ?inst delete)
)

(defrule fuerza_intensidad_alta_y_media_con_base_baja "Las personas que tienen un nivel bajo de fuerza no pueden realizar ejercicios de alta y media intensidad de fuerza"
    (declare (salience 10))
    (object (is-a Persona) (Fuerza_Muscular ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Baja) (or (eq ?i Alta) (eq ?i Media))))
    => (send ?inst delete)
)

(defrule resistencia_intensidad_alta_con_base_media "Las personas que tienen un nivel medio de resistencia no pueden realizar ejercicios de alta intensidad de resistencia"
    (declare (salience 10))
    (object (is-a Persona) (Resistencia ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Media) (eq ?i Alta))
    => (send ?inst delete)
)

(defrule resistencia_intensidad_alta_y_media_con_base_baja "Las personas que tienen un nivel bajo de resistencia no pueden realizar ejercicios de alta y media intensidad de resistencia"
    (declare (salience 10))
    (object (is-a Persona) (Resistencia ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Baja) (or (eq ?i Alta) (eq ?i Media))))
    => (send ?inst delete)
)

(defrule flexibilidad_intensidad_alta_con_base_media "Las personas que tienen un nivel medio de flexibilidad no pueden realizar ejercicios de alta intensidad de flexibilidad"
    (declare (salience 10))
    (object (is-a Persona) (Flexbilidad ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Media) (eq ?i Alta))
    => (send ?inst delete)
)

(defrule flexibilidad_intensidad_alta_y_media_con_base_baja "Las personas que tienen un nivel bajo de flexibilidad no pueden realizar ejercicios de alta y media intensidad de flexibilidad"
    (declare (salience 10))
    (object (is-a Persona) (Flexbilidad ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Baja) (or (eq ?i Alta) (eq ?i Media))))
    => (send ?inst delete)
)

(defrule equilibrio_intensidad_alta_con_base_media "Las personas que tienen un nivel medio de equilibrio no pueden realizar ejercicios de alta intensidad de equilibrio"
    (declare (salience 10))
    (object (is-a Persona) (Equilibrio ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Media) (eq ?i Alta))
    => (send ?inst delete)
)

(defrule equilibrio_intensidad_alta_y_media_con_base_baja "Las personas que tienen un nivel bajo de equilibrio no pueden realizar ejercicios de alta y media intensidad de equilibrio"
    (declare (salience 10))
    (object (is-a Persona) (Equilibrio ?f))
    ?inst <- (object (is-a Ejercicio) (intensidad ?i))
    (test (and (eq ?f Baja) (or (eq ?i Alta) (eq ?i Media))))
    => (send ?inst delete)
)

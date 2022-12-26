;Header and description

(define (domain Robert)

;remove requirements that are not needed
(:requirements :adl :fluents)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
  robert carga lugar peticion - object
  suministro personal - carga
  pPersona pCarga - peticion
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
)


(:functions ;todo: define numeric functions here
 (capacidad ?r - robert)
 (combustible ?r - robert)
 (prioridad ?p - peticion)
)

;define actions here
    (:action mover
        :parameters (?r - robert ?l1 - lugar ?l2 - lugar)
        :precondition (and  (>(capacidad ?r)) (>(combustible ?r)) (esta_en ?r ?l1) (not(esta_en ?r ?l2)) (accedible_desde ?l2 ?l1)
        )
        :effect (and (decrease (capacidad ?r) 1) de)
    )
    
)
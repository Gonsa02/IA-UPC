(define (domain ext1)
(:requirements :adl :typing :fluents)

(:types Base Rover Carga - object
		Asentamiento Almacen - Base
		Suministro Personal - Carga
		
)


(:predicates
	(aparcado ?r - Rover ?l - Base) ; Indica si el Rover se encuentra aparcado en la Base
	(accesible ?l1 - Base ?l2 - Base) ; Indica si se puede acceder a la Base l2 desde la Base l1
	(esta ?c - Carga ?l - Base) ; Indica si la Carga se encuentra en la Base
	(transportando ?r - Rover ?c - Carga) ; Indica si el Rover está transportando la Carga
	(objetivo ?p - Carga ?l - Asentamiento) ; Indica la Base destino de la Petición
	 
	(entregada ?c - Carga) ; Comprueba que la carga no se haya entregado ya, nos servirá para el GOAL
)


(:functions
	(capacidad ?r - Rover)
	(combustible ?r - Rover) ; necesario
	(prioridad ?c - Carga ?l - Asentamiento)
	(combustible-total)
	(penalidad)
)


(:action mover ; Mueve al Rover de la Base l1 a la Base l2 ////// esto esta guay
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (> (combustible ?r) 0) (aparcado ?r ?l1) (accesible ?l1 ?l2) )
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2) (decrease (combustible ?r) 1) (increase (combustible-total) 1))
)

(:action recogerS ; El Rover recoge el Suministro del Almacén
	:parameters (?r - Rover ?c - Suministro ?l - Almacen)
	:precondition (and (not (entregada ?c)) (aparcado ?r ?l) (esta ?c ?l) (>= (capacidad ?r) 2))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 2))
)

(:action recogerP ; El Rover recoge el Personal del Almacén
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento)
	:precondition (and (not (entregada ?c)) (aparcado ?r ?l) (esta ?c ?l) (>= (capacidad ?r) 1) )
	:effect (and  (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 1))
)

(:action entregarS
	:parameters (?r - Rover ?c - Suministro ?l - Asentamiento)
	:precondition (and (objetivo ?c ?l) (not (entregada ?c)) (aparcado ?r ?l) (transportando ?r ?c))
	:effect (and (not (transportando ?r ?c)) (not (objetivo ?c ?l)) (increase (capacidad ?r) 2) (increase (penalidad) (- 3 (prioridad ?c ?l))) (entregada ?c) )
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento)
	:precondition (and (objetivo ?c ?l) (not (entregada ?c)) (aparcado ?r ?l) (transportando ?r ?c))
	:effect (and (not (transportando ?r ?c)) (not (objetivo ?c ?l))(increase (capacidad ?r) 1) (increase (penalidad) (- 3 (prioridad ?c ?l))) (entregada ?c))
)

)

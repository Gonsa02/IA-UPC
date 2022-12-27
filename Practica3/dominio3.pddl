(define (domain ext1)
(:requirements :adl :typing :fluents :conditional-effects)

(:types Base Rover Carga Peticion - object
		Asentamiento Almacen - Base
		Suministro Personal - Carga
		pSuministro pPersonal - Peticion
)


(:predicates
	(aparcado ?r - Rover ?l - Base) ; Indica si el Rover se encuentra aparcado en la Base
	(accesible ?l1 - Base ?l2 - Base) ; Indica si se puede acceder a la Base l2 desde la Base l1
	(esta ?c - Carga ?l - Base) ; Indica si la Carga se encuentra en la Base
	(transportando ?r - Rover ?c - Carga) ; Indica si el Rover está transportando la Carga
	(objetivo ?p - Peticion ?l - Asentamiento) ; Indica la Base destino de la Petición
	(servida ?p - Peticion) ; Indica si la Petición ya ha estado servida
	(entregada ?c - Carga) ; Comprueba que la carga no se haya entregado ya, nos servirá para el GOAL
)


(:functions
	(capacidad ?r - Rover)
	(combustible ?r - Rover) ; necesario
	(prioridad ?p - Peticion)
	(penalidad)
)


(:action mover ; Mueve al Rover de la Base l1 a la Base l2
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2) (> (combustible ?r) 0))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2) (decrease (combustible ?r) 1))
)

(:action recogerS ; El Rover recoge el Suministro del Almacén
	:parameters (?r - Rover ?c - Suministro ?l - Almacen)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (= (capacidad ?r) 2))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 2))
)

(:action recogerP ; El Rover recoge el Personal del Almacén
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (>= (capacidad ?r) 1))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 1))
)

(:action entregarS
	:parameters (?c - Suministro ?l - Asentamiento ?p - pSuministro)
	:precondition (and (objetivo ?p ?l) (not (entregada ?c)) (not (servida ?p)))
	:effect (and (entregada ?c) (servida ?p)
	(forall (?p2 - pSuministro)
		when (and (objetivo ?p2 ?l) (not (servida ?p2)) (> (prioridad ?p2) (prioridad ?p)))
			(increase (penalidad) 1)
	))
)

(:action entregarP
	:parameters (?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (objetivo ?p ?l) (not (entregada ?c)) (not (servida ?p)))
	:effect (and (entregada ?c) (servida ?p)
	(forall (?p2 - pPersonal)
		(when (and (objetivo ?p2 ?l) (not (servida ?p2)) (> (prioridad ?p2) (prioridad ?p)))
			(increase (penalidad) 1))
	))
)

(:action dejarS ; El Rover deja el Suministro en el Almacén
 :parameters (?r - Rover ?c - Suministro ?l - Base)
 :precondition (and (aparcado ?r ?l) (transportando ?r ?c))
 :effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 2) (esta ?c ?l))
)

(:action dejarP ; El Rover deja el Personal en el Asentamiento
 :parameters (?r - Rover ?c - Personal ?l - Base)
 :precondition (and (aparcado ?r ?l) (transportando ?r ?c))
 :effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 1) (esta ?c ?l))
)
)

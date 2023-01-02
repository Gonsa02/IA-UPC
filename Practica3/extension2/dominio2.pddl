(define (domain dominio2)
(:requirements :adl :typing :fluents)


(:types Base Rover Carga Peticion - object
		Asentamiento Almacen - Base
		Suministro Personal - Carga
		pSuministro pPersonal - Peticion
)


(:predicates
	(aparcado ?r - Rover ?l - Base)
	(accesible ?l1 - Base ?l2 - Base)
	(esta ?c - Carga ?l - Base)
	(transportando ?r - Rover ?c - Carga)
	(objetivo ?p - Peticion ?l - Asentamiento)
	(servida ?p - Peticion)
	(entregada ?c - Carga) ; Comprueba que la carga no se haya entregado ya, nos servirá para el GOAL
)


(:functions
	(capacidad ?r - Rover)
	(combustible ?r - Rover)
	(combustible-total)
)


(:action mover
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2) (> (combustible ?r) 0))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2) (decrease (combustible ?r) 1) (increase (combustible-total) 1))
)

(:action recogerS
	:parameters (?r - Rover ?c - Suministro ?l - Almacen)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (= (capacidad ?r) 2))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 2))
)

(:action recogerP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (>= (capacidad ?r) 1))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 1))
)

(:action entregarS
	:parameters (?r - Rover ?c - Suministro ?l - Asentamiento ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c) (increase (capacidad ?r) 2))
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c) (increase (capacidad ?r) 1))
)

)

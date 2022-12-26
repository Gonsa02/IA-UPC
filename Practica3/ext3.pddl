(define (domain ext1)
	(:requirements :adl :typing :fluents)
	(:types Base Asentamiento Almacen Rover)


(:types Base Rover Carga Peticion - object
		Asentamiento Almacen - Base
		Suministro Personal - Carga
		pSuministro pPersonal - Peticion
)

(:predicates
	(aparcado ?r - Rover ?l - Base)
	(accesible ?l1 - Base ?l2 - Base)
	(esta ?c - Carga ?l - Base)
	(libre ?p - Peticion)
	(transportando ?r - Rover ?c - Carga)
	(objetivo ?p - Peticion ?l - Asentamiento)
	(servida ?p - Peticion)
)

(:functions
	(capacidad ?r - Rover)
	(combustible ?r - Rover)
	(prioridad ?p - Peticion)
	(prioridad-total)
)

(:action mover
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2) (> (combustible ?r) 0))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2) (decrease (combustible ?r) 1))
)

(:action recogerS
	:parameters (?r - Rover ?c - Suministro ?l - Almacen ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (libre ?p) (>= (capacidad ?r) 2))
	:effect (and (not (libre ?p)) (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 2))
)

(:action recogerP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (libre ?p) (>= (capacidad ?r) 1))
	:effect (and (not (libre ?p)) (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 1))
)

(:action entregarS
	:parameters (?r - Rover ?c - Suministro ?l - Asentamiento ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p)) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 2) (servida ?p) (increase (prioridad-total) (prioridad ?p)))
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p)) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 1) (servida ?p) (increase (prioridad-total) (prioridad ?p)))
)

)

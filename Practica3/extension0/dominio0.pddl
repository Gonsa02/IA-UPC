(define (domain dominio0)
(:requirements :adl :typing)


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


(:action mover
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2))
)

(:action recogerS
	:parameters (?r - Rover ?c - Suministro ?l - Almacen)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)))
)

(:action recogerP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l))
	:effect (and (transportando ?r ?c) (not (esta ?c ?l)))
)

(:action entregarS
	:parameters (?r - Rover ?c - Suministro ?l - Asentamiento ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c))
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c))
)

)

<<<<<<< HEAD:Practica3/extension1/ext1.pddl
(define (domain ext1)
	(:requirements :adl :typing :fluents)
=======
(define (domain dominio1)
(:requirements :adl :typing :fluents)
>>>>>>> e6a291055f27e6148e310e1ea20af511e8c11c8a:Practica3/dominio1.pddl


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
<<<<<<< HEAD:Practica3/extension1/ext1.pddl
	(entregada ?c - Carga)
=======
	(entregada ?c - Carga) ; Comprueba que la carga no se haya entregado ya, nos servirá para el GOAL
>>>>>>> e6a291055f27e6148e310e1ea20af511e8c11c8a:Practica3/dominio1.pddl
)


(:functions
	(capacidad ?r - Rover)
)


(:action mover
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2))
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
<<<<<<< HEAD:Practica3/extension1/ext1.pddl
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p)) (not (servida ?p)) (not (entregada ?c)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 2) (servida ?p) (entregada ?c))
=======
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c) (increase (capacidad ?r) 2))
>>>>>>> e6a291055f27e6148e310e1ea20af511e8c11c8a:Practica3/dominio1.pddl
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
<<<<<<< HEAD:Practica3/extension1/ext1.pddl
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p)) (not (servida ?p)) (not (entregada ?c)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 1) (servida ?p) (entregada ?c))
=======
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (servida ?p)))
	:effect (and (not (transportando ?r ?c)) (servida ?p) (entregada ?c) (increase (capacidad ?r) 1))
>>>>>>> e6a291055f27e6148e310e1ea20af511e8c11c8a:Practica3/dominio1.pddl
)

)

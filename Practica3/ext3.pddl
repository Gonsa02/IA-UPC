(define (domain ext1)
(:requirements :adl :typing :fluents)

(:types Base Rover Carga Peticion - object
		Asentamiento Almacen - Base
		Suministro Personal - Carga
		pSuministro pPersonal - Peticion
)


(:predicates
	(aparcado ?r - Rover ?l - Base) ; Indica si el Rover se encuentra aparcado en la Base
	(accesible ?l1 - Base ?l2 - Base) ; Indica si se puede acceder a la Base l2 desde la Base l1
	(esta ?c - Carga ?l - Base) ; Indica si la Carga se encuentra en la Base
	(libre ?p - Peticion) ; Indica si ya hay un Rover que se está encargando/se ha encargado de la Petición
	(transportando ?r - Rover ?c - Carga) ; Indica si el Rover está transportando la Carga
	(objetivo ?p - Peticion ?l - Asentamiento) ; Indica la Base destino de la Petición
	(servida ?p - Peticion) ; Indica si la Petición ya ha estado servida
	(entregada ?c - Carga) ; Comprueba que la carga no se haya entregado ya 
)


(:functions
	(capacidad ?r - Rover)
	(combustible ?r - Rover) ; necesario
	(prioridad ?p - Peticion)
	(prioridad-total)
)


(:action mover ; Mueve al Rover de la Base l1 a la Base l2
	:parameters (?r - Rover ?l1 - Base ?l2 - Base)
	:precondition (and (aparcado ?r ?l1) (accesible ?l1 ?l2) (> (combustible ?r) 0))
	:effect (and (not (aparcado ?r ?l1)) (aparcado ?r ?l2) (decrease (combustible ?r) 1))
)

(:action recogerS ; El Rover recoge el Suministro del Almacén para la Petición
	:parameters (?r - Rover ?c - Suministro ?l - Almacen ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (libre ?p) (>= (capacidad ?r) 2) (not (entregada ?c)))
	:effect (and (not (libre ?p)) (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 2) )
)

(:action recogerP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (esta ?c ?l) (libre ?p) (>= (capacidad ?r) 1)(not (entregada ?c)))
	:effect (and (not (libre ?p)) (transportando ?r ?c) (not (esta ?c ?l)) (decrease (capacidad ?r) 1))
)

; Hay un problema y es que no hay relación entre Pedido y Carga, por lo que podría pasar que un Rover cogiera una Carga para un Pedido
; y luego esa carga se entregase en otro Pedido distinto
(:action entregarS
	:parameters (?r - Rover ?c - Suministro ?l - Asentamiento ?p - pSuministro)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p))  (not (entregada ?c)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 2)  (increase (prioridad-total) (prioridad ?p)) (entregada ?c))
)

(:action entregarP
	:parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
	:precondition (and (aparcado ?r ?l) (transportando ?r ?c) (objetivo ?p ?l) (not (libre ?p)) (not (entregada ?c)))
	:effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 1)  (increase (prioridad-total) (prioridad ?p))(entregada ?c))
)

(:action dejarS
 :parameters (?r - Rover ?c - Suministro ?l - Almacen ?p - pSuministro)
 :precondition (and (aparcado ?r ?l) (transportando ?r ?c) (not (entregada ?c)) (not (libre ?p)))
 :effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 2) (esta ?c ?l) (libre ?p))
)

(:action dejarP
 :parameters (?r - Rover ?c - Personal ?l - Asentamiento ?p - pPersonal)
 :precondition (and (aparcado ?r ?l) (transportando ?r ?c) (not (entregada ?c)) (not (libre ?p)))
 :effect (and (not (transportando ?r ?c)) (increase (capacidad ?r) 1) (esta ?c ?l) (libre ?p))
)
)

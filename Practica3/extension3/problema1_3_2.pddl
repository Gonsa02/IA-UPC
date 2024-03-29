(define (problem ext1)
(:domain dominio3)
(:objects	r1 r2 - Rover
		 	as1 as2 as3 as4 - Asentamiento
		 	al1 al2 al3 al4 al5 - Almacen
		 	s1 s2 - Suministro
		 	pers1 - Personal
)

(:init
	(= (capacidad r1) 2)
	(= (capacidad r2) 2)
	(= (combustible r1) 20)
	(= (combustible r2) 20)
	(= (combustible-total) 0)
	(=(penalidad) 0)
	(aparcado r1 as1)
	(aparcado r2 as1)
	
	(accesible as1 al3) (accesible al3 as1)
	(accesible al3 as4) (accesible as4 al3)
	(accesible as4 al4) (accesible al4 as4)
	(accesible al3 al5) (accesible al5 al3)
	(accesible al3 as3) (accesible as3 al3)
	(accesible as3 al1) (accesible al1 as3)
	(accesible al1 as2) (accesible as2 al1)
	(accesible as3 al2) (accesible al2 as3)
	
	(esta pers1 as3)
	(esta s1 al4)
	(esta s2 al4)
	
	
	(objetivo s1 as4)
	(=(prioridad s1 as4) 1)
	(objetivo s1 as1)
	(=(prioridad s1 as1) 3)
	(objetivo pers1 as2)
	(=(prioridad pers1 as2) 2)
	(objetivo s2 as3)
	(=(prioridad s2 as3) 2)
)

(:goal (forall (?c - Carga) (entregada ?c)))

(:metric minimize (+(combustible-total) (penalidad)))

)

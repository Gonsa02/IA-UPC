(define (problem ext1)
(:domain ext1)
(:objects	r1 r2 - Rover
		 	as1 as2 as3 as4 - Asentamiento
		 	al1 al2 al3 al4 al5 - Almacen
		 	s1 s2 - Suministro
		 	pers1 - Personal
		 	p1 p3 p4 - pSuministro
		 	p2 - pPersonal
)

(:init
	(= (capacidad r1) 2)
	(= (capacidad r2) 2)
	(= (combustible r1) 40)
	(= (combustible r2) 2)
	(= (combustible-total) 0)
	(= (prioridad p1) 2)
	(= (prioridad p2) 2)
	(= (prioridad p3) 1)
	(= (prioridad p4) 3)
	(= (penalidad) 0)
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
	(accesible as1 as3) (accesible as3 as1)
	(accesible as4 al5) (accesible al5 as4)
	(accesible al4 as3) (accesible as3 al4)
	(accesible al3 as2) (accesible as2 al3)
	
	(esta pers1 as3)
	(esta s1 al4)
	(esta s2 al4)
	
	(libre p1) (libre p2) (libre p3) (libre p4)
	
	(objetivo p1 as1)
	(objetivo p2 as2)
	(objetivo p3 as3)
	(objetivo p4 as1)
)

(:goal (forall (?s - Carga) (entregada ?s)))

(:metric minimize (+ (* 2 (penalidad)) (combustible-total)))

)

(define (problem ext1)
(:domain dominio3)
(:objects
		r1 r2  - Rover
		as1 as2 as3 - Asentamiento
		al1 al2 al3 al4 - Almacen
		s1 s2 s3 - Suministro
		pers1 pers2 pers3 pers4 - Personal

		
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)
	
		(=(combustible r1) 20)
		(=(combustible r2) 20)
	
		(=(combustible-total) 0)
		(=(penalidad) 0)
		(aparcado r1 al1)
		(aparcado r2 as1)
	

		(accesible as1 as2)
		(accesible as1 as3)
		(accesible as1 al1)
		(accesible as2 as1)
		(accesible as2 as3)
		(accesible as2 al3)
		(accesible as3 as1)
		(accesible as3 as2)
		(accesible as3 al1)
		(accesible as3 al2)
		(accesible as3 al3)
		(accesible al1 as1)
		(accesible al1 as3)
		(accesible al1 al2)
		(accesible al1 al3)
		(accesible al2 as3)
		(accesible al2 al1)
		(accesible al2 al4)
		(accesible al3 as2)
		(accesible al3 as3)
		(accesible al3 al1)
		(accesible al3 al4)
		(accesible al4 al2)
		(accesible al4 al3)

		(esta pers1 as1)
		(esta pers2 as1)
		(esta pers3 as2)
		(esta pers4 as2)
		(esta s1 al4)
		(esta s2 al3)
		(esta s3 al2)
		
		
		(objetivo s1 as1)
		(= (prioridad s1 as1) 1)
		(objetivo s1 as3)
		(= (prioridad s1 as3) 3)
		(objetivo s2 as3)
		(= (prioridad s2 as3) 2)
		(objetivo s3 as3)
		(= (prioridad s3 as3) 2)
		(objetivo pers1 as3)
		(= (prioridad pers1 as3) 3)
		(objetivo pers2 as3)
		(= (prioridad pers2 as3) 2)
		(objetivo pers3 as3)
		(= (prioridad pers3 as3) 3)
		(objetivo pers4 as3)
		(= (prioridad pers4 as3) 2)
		

)

(:goal (forall (?c - Carga) (entregada ?c)))
(:metric minimize (+(combustible-total) (penalidad)))

)

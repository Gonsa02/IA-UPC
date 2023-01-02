(define (problem ext1)
(:domain ext1)
(:objects
		r1 r2 - Rover
		as1 as2 as3 - Asentamiento
		al1 al2 al3 al4 - Almacen
		s1 s2 s3 - Suministro
		pers1 pers2 pers3 pers4 - Personal
		ps1 ps2 ps3 ps4 - pSuministro
		pp1 pp2 pp3 pp4 - pPersonal 
		
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)


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
		
	
		(objetivo ps1 as3)
		
		(objetivo ps2 as3)
		
		(objetivo ps3 as3)
		(objetivo ps4 as1)
		(objetivo pp1 as3)
		
		(objetivo pp2 as3)
		
		(objetivo pp3 as3)
		
		(objetivo pp4 as3)
		
		

)

(:goal (forall (?c - Carga) (entregada ?c)))


)

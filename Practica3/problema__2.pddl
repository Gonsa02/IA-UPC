(define (problem ext1)
(:domain ext1)
(:objects
		r1 r2 r3 r4 r5 r6 - Rover
		as1 as2 as3 as4 as5 as6 - Asentamiento
		al1 al2 al3 al4 al5 al6 - Almacen
		s1 s2 s3 s4 s5 s6 - Suministro
		pers1 pers2 pers3 pers4 pers5 pers6 - Personal
		
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)
		(= (capacidad r3) 2)
		(= (capacidad r4) 2)
		(= (capacidad r5) 2)
		(= (capacidad r6) 2)

		(= (combustible r1) 520)
		(= (combustible r2) 522)
		(= (combustible r3) 522)
		(= (combustible r4) 508)
		(= (combustible r5) 520)
		(= (combustible r6) 504)

		(= (penalidad) 0)

		(= (combustible-total) 0)

		(aparcado r1 as1)
		(aparcado r2 as3)
		(aparcado r3 as4)
		(aparcado r4 al1)
		(aparcado r5 as3)
		(aparcado r6 al4)

		(accesible as1 as3)
		(accesible as1 al1)
		(accesible as1 al2)
		(accesible as2 al5)
		(accesible as3 as1)
		(accesible as4 as5)
		(accesible as4 al2)
		(accesible as5 as4)
		(accesible as6 al2)
		(accesible al1 as1)
		(accesible al1 al4)
		(accesible al2 as1)
		(accesible al2 as4)
		(accesible al2 as6)
		(accesible al3 al4)
		(accesible al3 al5)
		(accesible al3 al6)
		(accesible al4 al1)
		(accesible al4 al3)
		(accesible al4 al5)
		(accesible al5 as2)
		(accesible al5 al3)
		(accesible al5 al4)
		(accesible al6 al3)

		(esta pers1 as2)
		(esta pers2 as6)
		(esta pers3 as4)
		(esta pers4 as2)
		(esta pers5 as3)
		(esta pers6 as1)
		(esta s1 al2)
		(esta s2 al6)
		(esta s3 al1)
		(esta s4 al5)
		(esta s5 al3)
		(esta s6 al6)

		(objetivo s1 as5)
       (=(prioridad s1 as5) 2)
		(objetivo s2 as6)
       (=(prioridad s2 as6) 3)
		(objetivo s3 as1)
       (=(prioridad s3 as1) 1)
		(objetivo s4 as4)
       (=(prioridad s4 as4) 3)
		(objetivo s5 as5)
       (=(prioridad s5 as5) 1)
		(objetivo s6 as1)
       (=(prioridad s6 as1) 1)

		(objetivo pers1 as3)
       (=(prioridad pers1 as3) 3)
		(objetivo pers2 as2)
       (=(prioridad pers2 as2) 2)
		(objetivo pers3 as4)
       (=(prioridad pers3 as4) 2)
		(objetivo pers4 as2)
       (=(prioridad pers4 as2) 2)
		(objetivo pers5 as1)
       (=(prioridad pers5 as1) 3)
		(objetivo pers6 as1)
       (=(prioridad pers6 as1) 1)

)

(:goal (forall (?c - Carga) (entregada ?c)))

(:metric minimize (+ (penalidad) (combustible-total)))

)


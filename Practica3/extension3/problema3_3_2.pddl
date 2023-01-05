(define (problem ext1)
(:domain ext1)
(:objects
		r1 r2 r3 - Rover
		base as1 as2 as3 as4 as5 en1 en2 en3 en4 en5 en6 - Asentamiento
		al1 al2 al3 al4 al5 - Almacen
		s1 s2 - Suministro
		pers1 pers2 - Personal
	
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)
		(= (capacidad r3) 2)
		(= (combustible r1) 20)
		(= (combustible r2) 20)
		(= (combustible r3) 20)
		(= (combustible-total) 0)
		(= (penalidad) 0)
		(aparcado r1 base)
		(aparcado r2 base)
		(aparcado r3 base)

		(accesible base as1)(accesible as1 base)
		(accesible as1 as2) (accesible as2 as1)
		(accesible as2 as3) (accesible as3 as2)
		(accesible as3 as4) (accesible as4 as3)
		(accesible as4 as5) (accesible as5 as4)
		
		(accesible as5 en1) (accesible en1 as5)
		(accesible en1 en2)  (accesible en2 en1)
		(accesible en1 en3) (accesible en3 en1)
		(accesible en2 en3) (accesible en3 en2)
		
		(accesible base al1)(accesible al1 base)
		(accesible al1 al2) (accesible al2 al1)
		(accesible al2 al3) (accesible al3 al2)
		(accesible al3 al4) (accesible al4 al3)
		(accesible al4 al5) (accesible al5 al4)
		(accesible al5 en4) (accesible en4 al5)
		(accesible en4 en5)  (accesible en5 en4)
		(accesible en4 en6) (accesible en6 en4)
		(accesible en5 en6) (accesible en6 en5)

		(esta pers1 en3)
		(esta pers2 en2)
		
		(esta s1 al5)
		(esta s2 al1)
		
		(objetivo s1 en1)
		(=(prioridad s1 en1) 3)
	        (objetivo s2 en3)
	        (=(prioridad s2 en3) 3)
	       
	        (objetivo pers1 en4)
	        (=(prioridad pers1 en4) 3)
	        (objetivo pers2 en5)
	        (=(prioridad pers2 en5) 3)
	        
       

)

(:goal (forall (?c - Carga) (entregada ?c)))

(:metric minimize (+ (penalidad) (combustible-total)))
)

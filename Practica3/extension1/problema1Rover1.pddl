(define (problem problema1)
(:domain dominio1)
(:objects
		r1 r2 - Rover
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - Asentamiento
		al1 al2 al3 al4 al5 al6 al7 al8 al9 al10 - Almacen
		s1 s2 s3 s4 s5 - Suministro
		pers1 pers2 pers3 pers4 pers5 - Personal
		
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)

		(= (combustible r1) 516)
		(= (combustible r2) 518)

		(= (penalidad) 0)

		(= (combustible-total) 0)

		(aparcado r1 al3)
		(aparcado r2 al8)

		(accesible as1 as2)
		(accesible as1 as3)
		(accesible as1 as5)
		(accesible as1 as7)
		(accesible as1 as8)
		(accesible as1 as9)
		(accesible as1 as10)
		(accesible as1 al1)
		(accesible as1 al2)
		(accesible as1 al5)
		(accesible as1 al6)
		(accesible as1 al8)
		(accesible as1 al9)
		(accesible as1 al10)
		(accesible as2 as1)
		(accesible as2 as3)
		(accesible as2 as5)
		(accesible as2 as7)
		(accesible as2 as8)
		(accesible as2 as9)
		(accesible as2 as10)
		(accesible as2 al2)
		(accesible as2 al5)
		(accesible as2 al7)
		(accesible as2 al8)
		(accesible as2 al10)
		(accesible as3 as1)
		(accesible as3 as2)
		(accesible as3 as4)
		(accesible as3 as5)
		(accesible as3 as8)
		(accesible as3 as10)
		(accesible as3 al2)
		(accesible as3 al3)
		(accesible as3 al4)
		(accesible as3 al5)
		(accesible as3 al7)
		(accesible as3 al10)
		(accesible as4 as3)
		(accesible as4 as5)
		(accesible as4 as8)
		(accesible as4 al1)
		(accesible as4 al3)
		(accesible as4 al4)
		(accesible as4 al5)
		(accesible as4 al6)
		(accesible as5 as1)
		(accesible as5 as2)
		(accesible as5 as3)
		(accesible as5 as4)
		(accesible as5 as6)
		(accesible as5 as8)
		(accesible as5 as10)
		(accesible as5 al4)
		(accesible as5 al5)
		(accesible as5 al6)
		(accesible as5 al10)
		(accesible as6 as5)
		(accesible as6 as7)
		(accesible as6 as8)
		(accesible as6 as9)
		(accesible as6 al1)
		(accesible as6 al2)
		(accesible as6 al3)
		(accesible as6 al4)
		(accesible as6 al7)
		(accesible as7 as1)
		(accesible as7 as2)
		(accesible as7 as6)
		(accesible as7 as8)
		(accesible as7 as9)
		(accesible as7 as10)
		(accesible as7 al3)
		(accesible as7 al4)
		(accesible as7 al5)
		(accesible as7 al6)
		(accesible as7 al8)
		(accesible as7 al9)
		(accesible as7 al10)
		(accesible as8 as1)
		(accesible as8 as2)
		(accesible as8 as3)
		(accesible as8 as4)
		(accesible as8 as5)
		(accesible as8 as6)
		(accesible as8 as7)
		(accesible as8 as9)
		(accesible as8 al1)
		(accesible as8 al2)
		(accesible as8 al5)
		(accesible as8 al6)
		(accesible as8 al7)
		(accesible as8 al10)
		(accesible as9 as1)
		(accesible as9 as2)
		(accesible as9 as6)
		(accesible as9 as7)
		(accesible as9 as8)
		(accesible as9 as10)
		(accesible as9 al1)
		(accesible as9 al4)
		(accesible as9 al6)
		(accesible as9 al7)
		(accesible as9 al9)
		(accesible as10 as1)
		(accesible as10 as2)
		(accesible as10 as3)
		(accesible as10 as5)
		(accesible as10 as7)
		(accesible as10 as9)
		(accesible as10 al1)
		(accesible as10 al3)
		(accesible as10 al4)
		(accesible as10 al5)
		(accesible as10 al7)
		(accesible as10 al9)
		(accesible as10 al10)
		(accesible al1 as1)
		(accesible al1 as4)
		(accesible al1 as6)
		(accesible al1 as8)
		(accesible al1 as9)
		(accesible al1 as10)
		(accesible al1 al2)
		(accesible al1 al3)
		(accesible al1 al4)
		(accesible al1 al5)
		(accesible al1 al9)
		(accesible al1 al10)
		(accesible al2 as1)
		(accesible al2 as2)
		(accesible al2 as3)
		(accesible al2 as6)
		(accesible al2 as8)
		(accesible al2 al1)
		(accesible al2 al3)
		(accesible al2 al4)
		(accesible al2 al5)
		(accesible al2 al6)
		(accesible al2 al9)
		(accesible al3 as3)
		(accesible al3 as4)
		(accesible al3 as6)
		(accesible al3 as7)
		(accesible al3 as10)
		(accesible al3 al1)
		(accesible al3 al2)
		(accesible al3 al4)
		(accesible al3 al8)
		(accesible al4 as3)
		(accesible al4 as4)
		(accesible al4 as5)
		(accesible al4 as6)
		(accesible al4 as7)
		(accesible al4 as9)
		(accesible al4 as10)
		(accesible al4 al1)
		(accesible al4 al2)
		(accesible al4 al3)
		(accesible al4 al5)
		(accesible al4 al6)
		(accesible al4 al8)
		(accesible al4 al9)
		(accesible al4 al10)
		(accesible al5 as1)
		(accesible al5 as2)
		(accesible al5 as3)
		(accesible al5 as4)
		(accesible al5 as5)
		(accesible al5 as7)
		(accesible al5 as8)
		(accesible al5 as10)
		(accesible al5 al1)
		(accesible al5 al2)
		(accesible al5 al4)
		(accesible al5 al6)
		(accesible al5 al10)
		(accesible al6 as1)
		(accesible al6 as4)
		(accesible al6 as5)
		(accesible al6 as7)
		(accesible al6 as8)
		(accesible al6 as9)
		(accesible al6 al2)
		(accesible al6 al4)
		(accesible al6 al5)
		(accesible al6 al7)
		(accesible al6 al9)
		(accesible al7 as2)
		(accesible al7 as3)
		(accesible al7 as6)
		(accesible al7 as8)
		(accesible al7 as9)
		(accesible al7 as10)
		(accesible al7 al6)
		(accesible al7 al8)
		(accesible al7 al10)
		(accesible al8 as1)
		(accesible al8 as2)
		(accesible al8 as7)
		(accesible al8 al3)
		(accesible al8 al4)
		(accesible al8 al7)
		(accesible al8 al9)
		(accesible al8 al10)
		(accesible al9 as1)
		(accesible al9 as7)
		(accesible al9 as9)
		(accesible al9 as10)
		(accesible al9 al1)
		(accesible al9 al2)
		(accesible al9 al4)
		(accesible al9 al6)
		(accesible al9 al8)
		(accesible al9 al10)
		(accesible al10 as1)
		(accesible al10 as2)
		(accesible al10 as3)
		(accesible al10 as5)
		(accesible al10 as7)
		(accesible al10 as8)
		(accesible al10 as10)
		(accesible al10 al1)
		(accesible al10 al4)
		(accesible al10 al5)
		(accesible al10 al7)
		(accesible al10 al8)
		(accesible al10 al9)

		(esta pers1 as6)
		(esta pers2 as10)
		(esta pers3 as7)
		(esta pers4 as8)
		(esta pers5 as5)
		(esta s1 al6)
		(esta s2 al7)
		(esta s3 al9)
		(esta s4 al1)
		(esta s5 al8)

		(objetivo s1 as6)
       (=(prioridad s1 as6) 3)
		(objetivo s2 as4)
       (=(prioridad s2 as4) 3)
		(objetivo s3 as10)
       (=(prioridad s3 as10) 1)
		(objetivo s4 as9)
       (=(prioridad s4 as9) 2)
		(objetivo s5 as4)
       (=(prioridad s5 as4) 1)

		(objetivo pers1 as5)
       (=(prioridad pers1 as5) 2)
		(objetivo pers2 as8)
       (=(prioridad pers2 as8) 2)
		(objetivo pers3 as9)
       (=(prioridad pers3 as9) 1)
		(objetivo pers4 as7)
       (=(prioridad pers4 as7) 2)
		(objetivo pers5 as3)
       (=(prioridad pers5 as3) 2)

)

(:goal (forall (?c - Carga) (entregada ?c)))

(:metric minimize (+ (penalidad) (combustible-total)))

)

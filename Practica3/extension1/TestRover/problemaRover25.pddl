(define (problem problemaRover25)
(:domain dominio1)

(:objects
		r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 - Rover
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - Asentamiento
		al1 al2 al3 al4 al5 al6 al7 al8 al9 al10 - Almacen
		s1 s2 s3 s4 s5 - Suministro
		pers1 pers2 pers3 pers4 pers5 - Personal
		p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 - pSuministro
		p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 - pPersonal
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)
		(= (capacidad r3) 2)
		(= (capacidad r4) 2)
		(= (capacidad r5) 2)
		(= (capacidad r6) 2)
		(= (capacidad r7) 2)
		(= (capacidad r8) 2)
		(= (capacidad r9) 2)
		(= (capacidad r10) 2)
		(= (capacidad r11) 2)
		(= (capacidad r12) 2)
		(= (capacidad r13) 2)
		(= (capacidad r14) 2)
		(= (capacidad r15) 2)
		(= (capacidad r16) 2)
		(= (capacidad r17) 2)
		(= (capacidad r18) 2)
		(= (capacidad r19) 2)
		(= (capacidad r20) 2)
		(= (capacidad r21) 2)
		(= (capacidad r22) 2)
		(= (capacidad r23) 2)
		(= (capacidad r24) 2)
		(= (capacidad r25) 2)

		(aparcado r1 as9)
		(aparcado r2 as10)
		(aparcado r3 al3)
		(aparcado r4 al8)
		(aparcado r5 al6)
		(aparcado r6 as10)
		(aparcado r7 as7)
		(aparcado r8 al8)
		(aparcado r9 as5)
		(aparcado r10 al6)
		(aparcado r11 as7)
		(aparcado r12 al9)
		(aparcado r13 al1)
		(aparcado r14 as8)
		(aparcado r15 as6)
		(aparcado r16 as9)
		(aparcado r17 al4)
		(aparcado r18 as5)
		(aparcado r19 al10)
		(aparcado r20 al1)
		(aparcado r21 al9)
		(aparcado r22 al2)
		(aparcado r23 al4)
		(aparcado r24 al3)
		(aparcado r25 al5)

		(accesible as1 as2) (accesible as1 as3) (accesible as1 as5) (accesible as1 as7) (accesible as1 as8) (accesible as1 as9) (accesible as1 as10) (accesible as1 al1) (accesible as1 al2) (accesible as1 al5) (accesible as1 al6) (accesible as1 al8) (accesible as1 al9) (accesible as1 al10) 
		(accesible as2 as1) (accesible as2 as3) (accesible as2 as5) (accesible as2 as7) (accesible as2 as8) (accesible as2 as9) (accesible as2 as10) (accesible as2 al2) (accesible as2 al5) (accesible as2 al7) (accesible as2 al8) (accesible as2 al10) 
		(accesible as3 as1) (accesible as3 as2) (accesible as3 as4) (accesible as3 as5) (accesible as3 as8) (accesible as3 as10) (accesible as3 al2) (accesible as3 al3) (accesible as3 al4) (accesible as3 al5) (accesible as3 al7) (accesible as3 al10) 
		(accesible as4 as3) (accesible as4 as5) (accesible as4 as8) (accesible as4 al1) (accesible as4 al3) (accesible as4 al4) (accesible as4 al5) (accesible as4 al6) 
		(accesible as5 as1) (accesible as5 as2) (accesible as5 as3) (accesible as5 as4) (accesible as5 as6) (accesible as5 as8) (accesible as5 as10) (accesible as5 al4) (accesible as5 al5) (accesible as5 al6) (accesible as5 al10) 
		(accesible as6 as5) (accesible as6 as7) (accesible as6 as8) (accesible as6 as9) (accesible as6 al1) (accesible as6 al2) (accesible as6 al3) (accesible as6 al4) (accesible as6 al7) 
		(accesible as7 as1) (accesible as7 as2) (accesible as7 as6) (accesible as7 as8) (accesible as7 as9) (accesible as7 as10) (accesible as7 al3) (accesible as7 al4) (accesible as7 al5) (accesible as7 al6) (accesible as7 al8) (accesible as7 al9) (accesible as7 al10) 
		(accesible as8 as1) (accesible as8 as2) (accesible as8 as3) (accesible as8 as4) (accesible as8 as5) (accesible as8 as6) (accesible as8 as7) (accesible as8 as9) (accesible as8 al1) (accesible as8 al2) (accesible as8 al5) (accesible as8 al6) (accesible as8 al7) (accesible as8 al10) 
		(accesible as9 as1) (accesible as9 as2) (accesible as9 as6) (accesible as9 as7) (accesible as9 as8) (accesible as9 as10) (accesible as9 al1) (accesible as9 al4) (accesible as9 al6) (accesible as9 al7) (accesible as9 al9) 
		(accesible as10 as1) (accesible as10 as2) (accesible as10 as3) (accesible as10 as5) (accesible as10 as7) (accesible as10 as9) (accesible as10 al1) (accesible as10 al3) (accesible as10 al4) (accesible as10 al5) (accesible as10 al7) (accesible as10 al9) (accesible as10 al10) 
		(accesible al1 as1) (accesible al1 as4) (accesible al1 as6) (accesible al1 as8) (accesible al1 as9) (accesible al1 as10) (accesible al1 al2) (accesible al1 al3) (accesible al1 al4) (accesible al1 al5) (accesible al1 al9) (accesible al1 al10) 
		(accesible al2 as1) (accesible al2 as2) (accesible al2 as3) (accesible al2 as6) (accesible al2 as8) (accesible al2 al1) (accesible al2 al3) (accesible al2 al4) (accesible al2 al5) (accesible al2 al6) (accesible al2 al9) 
		(accesible al3 as3) (accesible al3 as4) (accesible al3 as6) (accesible al3 as7) (accesible al3 as10) (accesible al3 al1) (accesible al3 al2) (accesible al3 al4) (accesible al3 al8) 
		(accesible al4 as3) (accesible al4 as4) (accesible al4 as5) (accesible al4 as6) (accesible al4 as7) (accesible al4 as9) (accesible al4 as10) (accesible al4 al1) (accesible al4 al2) (accesible al4 al3) (accesible al4 al5) (accesible al4 al6) (accesible al4 al8) (accesible al4 al9) (accesible al4 al10) 
		(accesible al5 as1) (accesible al5 as2) (accesible al5 as3) (accesible al5 as4) (accesible al5 as5) (accesible al5 as7) (accesible al5 as8) (accesible al5 as10) (accesible al5 al1) (accesible al5 al2) (accesible al5 al4) (accesible al5 al6) (accesible al5 al10) 
		(accesible al6 as1) (accesible al6 as4) (accesible al6 as5) (accesible al6 as7) (accesible al6 as8) (accesible al6 as9) (accesible al6 al2) (accesible al6 al4) (accesible al6 al5) (accesible al6 al7) (accesible al6 al9) 
		(accesible al7 as2) (accesible al7 as3) (accesible al7 as6) (accesible al7 as8) (accesible al7 as9) (accesible al7 as10) (accesible al7 al6) (accesible al7 al8) (accesible al7 al10) 
		(accesible al8 as1) (accesible al8 as2) (accesible al8 as7) (accesible al8 al3) (accesible al8 al4) (accesible al8 al7) (accesible al8 al9) (accesible al8 al10) 
		(accesible al9 as1) (accesible al9 as7) (accesible al9 as9) (accesible al9 as10) (accesible al9 al1) (accesible al9 al2) (accesible al9 al4) (accesible al9 al6) (accesible al9 al8) (accesible al9 al10) 
		(accesible al10 as1) (accesible al10 as2) (accesible al10 as3) (accesible al10 as5) (accesible al10 as7) (accesible al10 as8) (accesible al10 as10) (accesible al10 al1) (accesible al10 al4) (accesible al10 al5) (accesible al10 al7) (accesible al10 al8) (accesible al10 al9) 

		(esta pers1 as7)
		(esta pers2 as8)
		(esta pers3 as5)
		(esta pers4 as9)
		(esta pers5 as2)
		(esta s1 al7)
		(esta s2 al9)
		(esta s3 al3)
		(esta s4 al2)
		(esta s5 al7)

		(objetivo p1 as8) (objetivo p2 as1) 
		(objetivo p3 as5) (objetivo p4 as5) 
		(objetivo p5 as5) (objetivo p6 as3) 
		(objetivo p7 as4) (objetivo p8 as6) 
		(objetivo p9 as3) (objetivo p10 as1) 
		(objetivo p11 as3) (objetivo p12 as3) 
		(objetivo p13 as4) (objetivo p14 as9) 
		(objetivo p15 as5) (objetivo p16 as6) 
		(objetivo p17 as7) (objetivo p18 as6) 
		(objetivo p19 as2) (objetivo p20 as1) 
		(objetivo p21 as3) (objetivo p22 as8) 
		(objetivo p23 as8) (objetivo p24 as7) 
		(objetivo p25 as8) (objetivo p26 as1) 
		(objetivo p27 as6) (objetivo p28 as8) 
		(objetivo p29 as5) (objetivo p30 as7) 

)

(:goal (forall (?c - Carga) (entregada ?c)))

)

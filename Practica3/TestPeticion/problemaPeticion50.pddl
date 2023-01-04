(define (problem problemaPeticion50)
(:domain dominio1)

(:objects
		r1 r2 r3 - Rover
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - Asentamiento
		al1 al2 al3 al4 al5 al6 al7 al8 al9 al10 - Almacen
		s1 s2 s3 s4 s5 - Suministro
		pers1 pers2 pers3 pers4 pers5 - Personal
		p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 - pSuministro
		p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 - pPersonal
)

(:init
		(= (capacidad r1) 2)
		(= (capacidad r2) 2)
		(= (capacidad r3) 2)

		(aparcado r1 as9)
		(aparcado r2 as10)
		(aparcado r3 al3)

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

		(esta pers1 as8)
		(esta pers2 as6)
		(esta pers3 as10)
		(esta pers4 as7)
		(esta pers5 as8)
		(esta s1 al5)
		(esta s2 al6)
		(esta s3 al7)
		(esta s4 al9)
		(esta s5 al1)

		(objetivo p1 as8) (objetivo p2 as6) 
		(objetivo p3 as9) (objetivo p4 as4) 
		(objetivo p5 as5) (objetivo p6 as10) 
		(objetivo p7 as1) (objetivo p8 as9) 
		(objetivo p9 as2) (objetivo p10 as4) 
		(objetivo p11 as3) (objetivo p12 as5) 
		(objetivo p13 as7) (objetivo p14 as8) 
		(objetivo p15 as5) (objetivo p16 as9) 
		(objetivo p17 as2) (objetivo p18 as7) 
		(objetivo p19 as9) (objetivo p20 as3) 
		(objetivo p21 as2) (objetivo p22 as7) 
		(objetivo p23 as8) (objetivo p24 as1) 
		(objetivo p25 as5) (objetivo p26 as5) 
		(objetivo p27 as5) (objetivo p28 as3) 
		(objetivo p29 as4) (objetivo p30 as6) 
		(objetivo p31 as3) (objetivo p32 as1) 
		(objetivo p33 as3) (objetivo p34 as3) 
		(objetivo p35 as4) (objetivo p36 as9) 
		(objetivo p37 as5) (objetivo p38 as6) 
		(objetivo p39 as7) (objetivo p40 as6) 
		(objetivo p41 as2) (objetivo p42 as1) 
		(objetivo p43 as3) (objetivo p44 as8) 
		(objetivo p45 as8) (objetivo p46 as7) 
		(objetivo p47 as8) (objetivo p48 as1) 
		(objetivo p49 as6) (objetivo p50 as8) 

)

(:goal (forall (?c - Carga) (entregada ?c)))

)

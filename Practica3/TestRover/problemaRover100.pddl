(define (problem problemaRover100)
(:domain dominio1)

(:objects
		r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31 r32 r33 r34 r35 r36 r37 r38 r39 r40 r41 r42 r43 r44 r45 r46 r47 r48 r49 r50 r51 r52 r53 r54 r55 r56 r57 r58 r59 r60 r61 r62 r63 r64 r65 r66 r67 r68 r69 r70 r71 r72 r73 r74 r75 r76 r77 r78 r79 r80 r81 r82 r83 r84 r85 r86 r87 r88 r89 r90 r91 r92 r93 r94 r95 r96 r97 r98 r99 r100 - Rover
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
		(= (capacidad r26) 2)
		(= (capacidad r27) 2)
		(= (capacidad r28) 2)
		(= (capacidad r29) 2)
		(= (capacidad r30) 2)
		(= (capacidad r31) 2)
		(= (capacidad r32) 2)
		(= (capacidad r33) 2)
		(= (capacidad r34) 2)
		(= (capacidad r35) 2)
		(= (capacidad r36) 2)
		(= (capacidad r37) 2)
		(= (capacidad r38) 2)
		(= (capacidad r39) 2)
		(= (capacidad r40) 2)
		(= (capacidad r41) 2)
		(= (capacidad r42) 2)
		(= (capacidad r43) 2)
		(= (capacidad r44) 2)
		(= (capacidad r45) 2)
		(= (capacidad r46) 2)
		(= (capacidad r47) 2)
		(= (capacidad r48) 2)
		(= (capacidad r49) 2)
		(= (capacidad r50) 2)
		(= (capacidad r51) 2)
		(= (capacidad r52) 2)
		(= (capacidad r53) 2)
		(= (capacidad r54) 2)
		(= (capacidad r55) 2)
		(= (capacidad r56) 2)
		(= (capacidad r57) 2)
		(= (capacidad r58) 2)
		(= (capacidad r59) 2)
		(= (capacidad r60) 2)
		(= (capacidad r61) 2)
		(= (capacidad r62) 2)
		(= (capacidad r63) 2)
		(= (capacidad r64) 2)
		(= (capacidad r65) 2)
		(= (capacidad r66) 2)
		(= (capacidad r67) 2)
		(= (capacidad r68) 2)
		(= (capacidad r69) 2)
		(= (capacidad r70) 2)
		(= (capacidad r71) 2)
		(= (capacidad r72) 2)
		(= (capacidad r73) 2)
		(= (capacidad r74) 2)
		(= (capacidad r75) 2)
		(= (capacidad r76) 2)
		(= (capacidad r77) 2)
		(= (capacidad r78) 2)
		(= (capacidad r79) 2)
		(= (capacidad r80) 2)
		(= (capacidad r81) 2)
		(= (capacidad r82) 2)
		(= (capacidad r83) 2)
		(= (capacidad r84) 2)
		(= (capacidad r85) 2)
		(= (capacidad r86) 2)
		(= (capacidad r87) 2)
		(= (capacidad r88) 2)
		(= (capacidad r89) 2)
		(= (capacidad r90) 2)
		(= (capacidad r91) 2)
		(= (capacidad r92) 2)
		(= (capacidad r93) 2)
		(= (capacidad r94) 2)
		(= (capacidad r95) 2)
		(= (capacidad r96) 2)
		(= (capacidad r97) 2)
		(= (capacidad r98) 2)
		(= (capacidad r99) 2)
		(= (capacidad r100) 2)

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
		(aparcado r26 as7)
		(aparcado r27 al8)
		(aparcado r28 al5)
		(aparcado r29 al9)
		(aparcado r30 al2)
		(aparcado r31 al7)
		(aparcado r32 al9)
		(aparcado r33 al3)
		(aparcado r34 as2)
		(aparcado r35 al7)
		(aparcado r36 as8)
		(aparcado r37 al1)
		(aparcado r38 al5)
		(aparcado r39 as5)
		(aparcado r40 al5)
		(aparcado r41 as3)
		(aparcado r42 as4)
		(aparcado r43 as6)
		(aparcado r44 al3)
		(aparcado r45 al1)
		(aparcado r46 as3)
		(aparcado r47 al3)
		(aparcado r48 as4)
		(aparcado r49 al9)
		(aparcado r50 as5)
		(aparcado r51 as6)
		(aparcado r52 al7)
		(aparcado r53 al6)
		(aparcado r54 al2)
		(aparcado r55 as1)
		(aparcado r56 as3)
		(aparcado r57 al8)
		(aparcado r58 al8)
		(aparcado r59 al7)
		(aparcado r60 as8)
		(aparcado r61 as1)
		(aparcado r62 as6)
		(aparcado r63 al8)
		(aparcado r64 as5)
		(aparcado r65 as7)
		(aparcado r66 as6)
		(aparcado r67 as5)
		(aparcado r68 as9)
		(aparcado r69 al3)
		(aparcado r70 as1)
		(aparcado r71 as3)
		(aparcado r72 al5)
		(aparcado r73 as4)
		(aparcado r74 as8)
		(aparcado r75 al9)
		(aparcado r76 al4)
		(aparcado r77 as2)
		(aparcado r78 al1)
		(aparcado r79 as9)
		(aparcado r80 al10)
		(aparcado r81 al5)
		(aparcado r82 al5)
		(aparcado r83 as9)
		(aparcado r84 as3)
		(aparcado r85 as6)
		(aparcado r86 as9)
		(aparcado r87 al7)
		(aparcado r88 al5)
		(aparcado r89 al9)
		(aparcado r90 as5)
		(aparcado r91 al4)
		(aparcado r92 al1)
		(aparcado r93 as10)
		(aparcado r94 al1)
		(aparcado r95 al6)
		(aparcado r96 as8)
		(aparcado r97 al7)
		(aparcado r98 al10)
		(aparcado r99 al6)
		(aparcado r100 as9)

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

		(esta pers1 as10)
		(esta pers2 as1)
		(esta pers3 as5)
		(esta pers4 as6)
		(esta pers5 as10)
		(esta s1 al3)
		(esta s2 al1)
		(esta s3 al2)
		(esta s4 al5)
		(esta s5 al10)

		(objetivo p1 as1) (objetivo p2 as2) 
		(objetivo p3 as6) (objetivo p4 as9) 
		(objetivo p5 as6) (objetivo p6 as3) 
		(objetivo p7 as10) (objetivo p8 as2) 
		(objetivo p9 as9) (objetivo p10 as10) 
		(objetivo p11 as6) (objetivo p12 as2) 
		(objetivo p13 as2) (objetivo p14 as8) 
		(objetivo p15 as4) (objetivo p16 as7) 
		(objetivo p17 as7) (objetivo p18 as10) 
		(objetivo p19 as8) (objetivo p20 as5) 
		(objetivo p21 as10) (objetivo p22 as10) 
		(objetivo p23 as5) (objetivo p24 as4) 
		(objetivo p25 as7) (objetivo p26 as6) 
		(objetivo p27 as8) (objetivo p28 as7) 
		(objetivo p29 as7) (objetivo p30 as3) 

)

(:goal (forall (?c - Carga) (entregada ?c)))

)

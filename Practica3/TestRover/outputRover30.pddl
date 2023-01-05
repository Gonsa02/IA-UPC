ff: parsing domain file
domain 'DOMINIO1' defined
 ... done.
ff: parsing problem file
problem 'PROBLEMAROVER30' defined
 ... done.


no metric specified. plan length assumed.

checking for cyclic := effects --- OK.

ff: search configuration is  best-first on 1*g(s) + 5*h(s) where
    metric is  plan length

advancing to distance:   25
                         24
                         23
                         22
                         21
                         20
                         19
                         18
                         17
                         16
                         15
                         14
                         13
                         12
                         11
                         10
                          9
                          8
                          7
                          6
                          5
                          4
                          3
                          2
                          1
                          0

ff: found legal plan as follows

step    0: RECOGERS R4 S1 AL8
        1: RECOGERS R13 S2 AL1
        2: RECOGERP R1 PERS2 AS9
        3: RECOGERP R7 PERS1 AS7
        4: RECOGERP R7 PERS5 AS7
        5: ENTREGARP R7 PERS5 AS7 P25
        6: ENTREGARP R7 PERS1 AS7 P19
        7: ENTREGARP R1 PERS2 AS9 P28
        8: MOVER R2 AS10 AS3
        9: RECOGERP R2 PERS3 AS3
       10: ENTREGARP R2 PERS3 AS3 P29
       11: MOVER R4 AL8 AS7
       12: ENTREGARS R4 S1 AS7 P12
       13: MOVER R13 AL1 AS9
       14: ENTREGARS R13 S2 AS9 P9
       15: RECOGERS R25 S3 AL5
       16: MOVER R25 AL5 AS5
       17: ENTREGARS R25 S3 AS5 P10
       18: RECOGERS R28 S4 AL5
       19: MOVER R28 AL5 AS4
       20: ENTREGARS R28 S4 AS4 P2
       21: MOVER R28 AS4 AL5
       22: RECOGERS R28 S5 AL5
       23: MOVER R28 AL5 AS4
       24: ENTREGARS R28 S5 AS4 P8
       25: MOVER R25 AS5 AS2
       26: RECOGERP R25 PERS4 AS2
       27: MOVER R25 AS2 AS8
       28: ENTREGARP R25 PERS4 AS8 P23
     

time spent:    0.00 seconds instantiating 14340 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 980 facts and 11640 actions
               0.00 seconds creating final representation with 980 relevant facts, 60 relevant fluents
               0.03 seconds computing LNF
               0.00 seconds building connectivity graph
               3.99 seconds searching, evaluating 16153 states, to a max depth of 0
               4.02 seconds total time

(deffacts datos_iniciales
    (palabra B B C D C F Z)
)

(defrule inicio
    (initial-fact)
    (palabra $?x)
    =>
    (assert (Regla_1 $?x))
    (assert (Regla_2 $?x))
    (assert (Regla_3 $?x))
    (assert (Regla_4 $?x))
)

(defrule Regla1
    ?h <- (Regla_1 $?x C $?y)
    =>
    (retract ?h)
    (assert (Regla_1 $?x D L $?y))
)

(defrule Regla2
    ?h <- (Regla_2 $?x C $?y)
    =>
    (retract ?h)
    (assert (Regla_2 $?x B M $?y))
)

(defrule Regla3
    ?h <- (Regla_3 $?x B $?y)
    =>
    (retract ?h)
    (assert (Regla_3 $?x M M $?y))
)

(defrule Regla4
    ?h <- (Regla_4 $?x Z $?y)
    =>
    (retract ?h)
    (assert (Regla_4 $?x B B M $?y))
)
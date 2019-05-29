(deffacts datos
    (cadena B C A D E E B C E)
    (cadena E E B F D E)
)

(defrule inicio
    (cadena $? ?x $?)
    (not (union $?))
    =>
    (assert (union ?x))
)

(defrule regla_union
    (cadena $? ?x $?)
    ?h <- (union $?f)
    (not (union $? ?x $?))
    =>
    (retract ?h)
    (assert (union $?f ?x))
)
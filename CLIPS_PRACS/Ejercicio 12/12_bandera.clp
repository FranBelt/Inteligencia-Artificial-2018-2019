(deftemplate Pais
	(field Nombre)
	(multifield Bandera)
)

(defrule color1
	?h <- (fase color)
    =>
	(retract ?h)
	(printout t "Introduzca el color 1: ")
	(assert (color (read)) (fase otro_color))
)

(defrule otro_color
	?h <- (fase otro_color)
    =>
	(retract ?h)
	(printout t "Introduzca el color 2: ")
	(assert (color (read)) (fase dos_colores))
)

(defrule banderas_colores
	(Pais (Nombre ?x))
	(forall (color ?y) (Pais (Nombre ?x) (Bandera $? ?y $?)))
=>
	(printout t ?x crlf)
)
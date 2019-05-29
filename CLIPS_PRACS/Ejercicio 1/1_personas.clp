(defrule LosPadresQuierenALosHijos
	(EsPadre ?var)
	=>
	(assert (QuiereASusHijos ?var)))
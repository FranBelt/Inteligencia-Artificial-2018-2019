(deftemplate FichaPaciente
    (field Nombre)
    (field Casado)
    (field Direccion)
)

(deftemplate DatosExploracion
    (field Nombre)
    (multifield Sintomas)
    (field GravedadAfeccion)
)

(defrule OrdenSintomas
    ?f <- (DatosExploracion (Nombre ?nombre) (Sintomas $?x vesiculas $?g picor $?y) (GravedadAfeccion ?gravedad))
    =>
    (retract ?f)
    (assert(DatosExploracion (Nombre ?nombre) (Sintomas $?x picor vesiculas $?y) (GravedadAfeccion ?gravedad)))
)

(defrule DiagnosticoEccema
    (DatosExploracion
        (Nombre ?N)
        (Sintomas $? picor $? vesiculas $?))
    (FichaPaciente
        (Nombre ?N))
    =>
    (printout t "Posible diagnostico para el paciente " ?N ": Eccema " crlf)
)

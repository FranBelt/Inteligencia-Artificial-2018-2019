; Regla A
(deftemplate FichaPaciente
    (field Nombre)
    (field Edad)
    (field Casado)
    (field Sexo)
    (field Peso)
)

(deftemplate DatosExploracion
    (field Nombre)
    (multifield Sintomas)
    (field GravedadAfeccion)
)

; Regla B
(deftemplate Diagnostico
    (field Nombre)
    (field Resultado)
    (field ProximaRevision)
)

; Regla C
(deftemplate Paciente
    (field Nombre)
    (field Tipo)
)

; Regla D
(deftemplate Terapia
    (field Nombre)
    (field PrincipioActivo)
    (field Posologia)
)


; Regla A
; Añada una regla para el siguiente diagnóstico: Si un paciente tiene los síntomas
; picor y vesículas, entonces mostrar un mensaje diciendo que tiene un eccema.
(defrule Diagnosticar_Eccema
    (DatosExploracion (Nombre ?nombre_paciente) (Sintomas $? picor $? vesiculas inflamada))
    (FichaPaciente (Nombre ?nombre_paciente))
    =>
    (printout t "El paciente " ?nombre_paciente " tiene un eccema." crlf)
)

; Regla B
(defrule Almacenar_Diagnostico
    (DatosExploracion (Nombre ?nombre_paciente) (Sintomas $?) (GravedadAfeccion ?gravedad))
    (FichaPaciente (Nombre ?nombre_paciente))
    =>
    (assert(Diagnostico (Nombre ?nombre_paciente) (Resultado ?gravedad) (ProximaRevision proximamente...)))
)

(defrule Mostrar_diagnosticos
    (Diagnostico (Nombre ?nombre_paciente))
    (FichaPaciente (Nombre ?nombre_paciente))
    =>
    (printout t "El paciente " ?nombre_paciente " tiene un diagnostico." crlf)
)

; Regla C
(defrule Vector_ninios
    (FichaPaciente (Nombre ?nombre) (Edad ?edad))
    =>
    (if (< ?edad 2)
        then
        (assert(Paciente (Nombre ?nombre) (Tipo Bebe)))
        else
        (assert(Paciente (Nombre ?nombre) (Tipo Adulto)))
    )
)

; Regla D E
(defrule Diagnosticar_Terapia
    (DatosExploracion (Nombre ?nombre) (GravedadAfeccion ?gravedad))
    (Paciente (Nombre ?nombre) (Tipo ?paciente))
    =>
    (if (eq (str-compare ?paciente "Bebe") 0)
        then
        (if (eq (str-compare ?gravedad "Grave") 0)
            then
            (assert(Terapia (Nombre ?nombre) (PrincipioActivo corticoides) (Posologia alta)))
            (printout t "Para el paciente " ?nombre " seria recomendable usar corticoides." crlf)
            else
            (assert(Terapia (Nombre ?nombre) (PrincipioActivo crema_hidratante) (Posologia baja)))
            (printout t "Para el paciente " ?nombre " seria recomendable usar crema_hidratante." crlf))
        else
        (assert(Terapia (Nombre ?nombre) (PrincipioActivo corticoides) (Posologia normal)))
        (printout t "Para el paciente " ?nombre " seria recomendable usar corticoides." crlf)
    )
)
; Plantillas
(deftemplate Doctor
    (field Especialidad)
    (multifield Tratamientos)
)

(deftemplate Enfermedad
    (field Nombre_enfermedad)
    (multifield Sintomas)
    (multifield Medicamentos)
    (multifield Doctores)
)

(deftemplate Posibles_Enfermedades
    (field Nombre)
    (multifield Sintomas_detectados)
    (multifield Sintomas_posibles)
    (field Mostrado)
)

; Introducir datos
(defrule inicio
    ?i <- (inicio)
    =>
    (retract ?i)
    (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
    (printout t "       Sistema experto determinista realizado por Fco. Jesus Beltran Moreno     " crlf)
    (printout t "       Bienvenido al programa de diagnostico     " crlf)
    (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
    (assert (Sintomas_paciente))
)

(defrule Introducir_sintomas
    ?h <- (Sintomas_paciente)
    (not (diagnosticado))
    =>
    (retract ?h)
    (printout t "A continuacion, introduzca sus sintomas de 1 en 1, cuando termine introduzca 'fin': " crlf)
    (assert (Sintomas (read)))
    (assert (seguir_pidiendo))
)

(defrule Seguir_pidiendo_sintomas
    ?h <- (seguir_pidiendo)
    (not (Sintomas fin))
    =>
    (retract ?h)
    (assert (seguir_pidiendo_2))
)

(defrule Introducir_sintomas_2
    ?h <- (seguir_pidiendo_2)
    (not (diagnosticado))
    =>
    (retract ?h)
    (printout t "Introduzca el siguiente sintoma, cuando termine introduzca 'fin': " crlf)
    (assert (Sintomas (read)))
    (assert (seguir_pidiendo))
)

(defrule dejar_pedir_sintomas
    ?f <- (Sintomas fin)
    =>
    (retract ?f)
    (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
    (printout t crlf)
    (assert (diagnosticado))
)

; ------ AGRUPACIÓN SINTOMAS --------
(defrule Enfermedades-Doctores
    (diagnosticado)
    (forall (Enfermedad) (Doctor))
    ?h <- (Enfermedad (Nombre_enfermedad ?nombre) (Sintomas $?s) (Medicamentos $?a ?m $?b) (Doctores $?d))
    (Doctor (Especialidad ?espe) (Tratamientos $?u ?m $?k))
    (test (eq (member$ ?espe $?d) FALSE))
    =>
    (retract ?h)
    (assert (Enfermedad (Nombre_enfermedad ?nombre) (Sintomas $?s) (Medicamentos $?a ?m $?b) (Doctores $?d ?espe)))
    (assert(ordenados))
)

(defrule agrupar_sintomas
    (diagnosticado)
    ?f <- (Conjunto_sintomas $?t)
    ?h <- (Sintomas ?x)
    =>
    (retract ?f ?h)
    (assert(Conjunto_sintomas $?t ?x))
)

(defrule seguir_agrupando
    (diagnosticado)
    (not (Sintomas ?x))
    =>
    (assert (sintomas_agrupados))
)
; ------------------------------------

(defrule almacenar_posibles_enfermedades
    (ordenados)
    (diagnosticado)
    (sintomas_agrupados)
    (Conjunto_sintomas $?x)
    (Enfermedad (Nombre_enfermedad ?nombre) (Sintomas $?y) (Medicamentos $?m))
    (test (subsetp $?x $?y))
    =>
    (assert (Posibles_Enfermedades (Nombre ?nombre) (Sintomas_detectados $?x) (Sintomas_posibles $?y)))
    (assert (listo))
)

(defrule posibles_sintomas
    ?p <- (listo)
    ?h <- (Posibles_Enfermedades (Nombre ?nombre) (Sintomas_detectados $?a ?x $?b) (Sintomas_posibles $?c ?y $?d))
    (test (eq (str-compare ?x ?y) 0))
    =>
    (retract ?h ?p)
    (assert (Posibles_Enfermedades (Nombre ?nombre) (Sintomas_detectados $?a ?x $?b) (Sintomas_posibles $?c $?d) (Mostrado No)))
    (assert (listo))
)

(defrule mostrar_enfermedades
    (listo)
    ?p <- (Posibles_Enfermedades (Nombre ?nombre) (Sintomas_detectados $?x) (Sintomas_posibles $?y) (Mostrado No))
    (Enfermedad (Nombre_enfermedad ?nombre) (Medicamentos $?m) (Doctores $?d))
    (forall (Enfermedad) (Posibles_Enfermedades))
    =>
    (retract ?p)
    (assert(Posibles_Enfermedades (Nombre ?nombre) (Sintomas_detectados $?x) (Sintomas_posibles $?y) (Mostrado Si)))
    (printout t "El paciente podria tener " ?nombre "." crlf)
    (printout t "El paciente presenta los siguientes sintomas: " (implode$ ?x) "." crlf)
    (printout t "El paciente podria tener, ademas, los siguientes sintomas: " (implode$ ?y) "." crlf)
    (printout t "Los medicamentos para tratarla son " (implode$ ?m) crlf)
    (printout t "Puede ser tratada por " (implode$ ?d) crlf)
    (printout t crlf)
)

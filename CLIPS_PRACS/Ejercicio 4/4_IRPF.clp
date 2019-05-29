; Plantilla persona
(deftemplate Persona
    (field Nombre)
    (field Edad)
    (field NombreConyuge)
    (field PosicionEconomica)
    (field Salario)
)

(deftemplate DatosFiscales
    (field Nombre)
    (field Estado)
)

; Datos para procesar
(deffacts Datos
    (Persona (Nombre Juan) (Edad 40) (NombreConyuge Alba) (PosicionEconomica desahogada) (Salario 1000))
    (Persona (Nombre Aaron) (Edad 40) (NombreConyuge Sofia) (PosicionEconomica ahogada) (Salario 1200))
    (Persona (Nombre Isaac) (Edad 40) (NombreConyuge Carla) (PosicionEconomica ahogada) (Salario 1500))
    (Persona (Nombre Alba) (Edad 60) (NombreConyuge Juan) (PosicionEconomica ahogada) (Salario 2200))
    (Persona (Nombre Sofia) (Edad 60) (NombreConyuge Aaron) (PosicionEconomica ahogada) (Salario 1800))
    (Persona (Nombre Carla) (Edad 60) (NombreConyuge Isaac) (PosicionEconomica desahogada) (Salario 1700))
)

; Regla A
; Mostrar en pantalla los nombres de todas las personas de 60 años.
(defrule Personas_60
    (Persona (Nombre ?Nombre) (Edad 60))
    =>
    (printout t ?Nombre " tiene 60 anios." crlf)
)

; Regla B
; Mostrar en pantalla el nombre y salario de las personas de 40 años.
(defrule Personas_40
    (Persona (Nombre ?Nombre) (Edad 40) (Salario ?Salario))
    =>
    (printout t ?Nombre " tiene 40 anios y su salario es " ?Salario " euros." crlf)
)

; Regla C
; Mostrar en pantalla los datos de todas las personas.
(defrule Mostrar_personas
    (Persona (Nombre ?n) (Edad ?e) (NombreConyuge ?p) (PosicionEconomica ?ec) (Salario ?s))
    =>
    (printout t ?n " tiene " ?e " anios, su pareja es " ?p ", su posicion economica es " ?ec " y su salario es de " ?s " euros." crlf)
)

; Regla D
; Mostrar en pantalla el nombre de aquellas personas cuyo cónyuge tenga una posición económica desahogada.
(defrule Conyuge_desahogado
    (Persona (NombreConyuge ?n) (PosicionEconomica desahogada))
    (Persona (Nombre ?n))
    =>
    (printout t ?n ", su pareja esta en una posicion desahogada." crlf)
)

; Regla E
; Por cada persona cuyo cónyuge tenga una posición económica desahogada,
; añadir a la memoria de trabajo un vector ordenado de características de la forma (DatosFiscales <Nombre> ConyugeDesahogado)
(defrule Conyuge_desahogado_vector
    (Persona (Nombre ?p) (NombreConyuge ?n))
    (Persona (Nombre ?n) (PosicionEconomica desahogada))
    =>
    (assert(DatosFiscales (Nombre ?n) (Estado ConyugeDesahogado)))
)

; Regla F
; Borrar de la memoria de trabajo aquellas personas que tengan un cónyuge con
; una posición económica desahogada. Recomendación: Use los hechos (DatosFiscales) del apartado anterior.
(defrule EliminarConyuge
    (DatosFiscales (Nombre ?nombre))
    ?Persona <- (Persona (Nombre ?nombre))
    =>
    (retract ?Persona)
    ;(Persona (Nombre ?n) (NombreConyuge ?p))
    ;?Conyuge <- (Persona (Nombre ?p) (PosicionEconomica desahogada))
    ;=>
    ;(retract ?Conyuge)
    ;(printout t ?p " ha sido eliminado." crlf)
)

; Regla G
; Borrar de la memoria de trabajo aquellas personas que tengan una posición económica desahogada.
(defrule EliminarDesahogados
    ?Persona <- (Persona (PosicionEconomica desahogada))
    =>
    (retract ?Persona)
)
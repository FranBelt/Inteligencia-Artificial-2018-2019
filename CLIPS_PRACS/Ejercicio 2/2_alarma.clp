(deftemplate Emergencia
    (field tipo)
    (field sector)
    (field campo)
)

(deftemplate SistemaExtincion
    (field tipo)
    (field status)
    (field UltimaRevision)
)

(defrule Emergencia-Fuego-ClaseB
    (Emergencia
        (tipo ClaseB))
    (SistemaExtincion
        (tipo DioxidoCarbono)
        (status activado))        
    =>
    (printout t "Usar Extintor CO2" crlf) 
)
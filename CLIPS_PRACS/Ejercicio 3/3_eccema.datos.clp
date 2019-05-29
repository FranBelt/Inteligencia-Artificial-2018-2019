(deffacts Nombre_Pacientes
    (FichaPaciente
        (Nombre Pedro)
        (Casado No))
    (FichaPaciente
        (Nombre Juan)
        (Casado No))
    (FichaPaciente
        (Nombre Manuel)
        (Casado Si))
)

(deffacts Datos_Pacientes
    (DatosExploracion (Nombre Pedro) (Sintomas rojo picor blanco vesiculas verde))
    (DatosExploracion (Nombre Juan) (Sintomas rojo vesiculas blanco picor verde))
    (DatosExploracion (Nombre Manuel) (Sintomas rojo vesiculas blanco picor verde))
)
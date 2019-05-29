(deffacts Inventario
    (Articulo (Nombre cristal) (Tipo fragil) (Forrado Si) (Empaquetado No) (Dimension 10))
	(Articulo (Nombre botas) (Tipo fragil) (Forrado No) (Empaquetado No) (Dimension 2))
	(Articulo (Nombre bateria) (Tipo pesado) (Forrado No) (Empaquetado No) (Dimension 4))
)

(deffacts MisCajas
    (Caja (IdCaja 1) (Abierta Si) (Empezada No) (TipoContenido fragil) (EspacioLibre 6))
	(Caja (IdCaja 2) (Abierta Si) (Empezada No) (TipoContenido pesado) (EspacioLibre 11))
	(Caja (IdCaja 3) (Abierta No) (Empezada No) (TipoContenido fragil) (EspacioLibre 5))
)
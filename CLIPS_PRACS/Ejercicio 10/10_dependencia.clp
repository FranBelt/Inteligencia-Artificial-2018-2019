(deftemplate Producto
    (field CodigoVendedor)
    (field CodigoProducto)
    (field PVPProducto)
)

(defrule dependencia
    (Producto (CodigoVendedor ?c) (CodigoProducto ?x) (PVPProducto ?y))
    (Producto (CodigoVendedor ?d) (CodigoProducto ?z) (PVPProducto ?t))
    ;(test (<> ?c ?d))
    =>
    (if (eq ?x ?z)
        then
        (if (eq ?y ?t)
            then
            (printout t "CodigoVendedor: " ?c "-" ?d ". CodigoProducto: " ?x "-" ?z ". PVPProducto: " ?y "-" ?t ". Es completa." crlf)
        )
        else
            (printout t "CodigoVendedor: " ?c "-" ?d ". CodigoProducto: " ?x "-" ?z ". PVPProducto: " ?y "-" ?t ". Es incompleta." crlf)
    )
)
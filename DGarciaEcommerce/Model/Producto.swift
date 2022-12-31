//
//  Producto.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 28/12/22.
//

import Foundation

struct Producto {
    var IdProducto : Int
    var Nombre : String
    var PrecioUnitario : Double
    var Stock : Int
    var Proveedor : Proveedor
    var Departamento : Departamento
    var Descripcion : String?
    var Imagen : String?
}

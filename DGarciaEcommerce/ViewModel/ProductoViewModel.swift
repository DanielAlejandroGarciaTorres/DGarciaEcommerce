//
//  AlumnoViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 28/12/22.
//

import Foundation
import SQLite3

class ProductoViewModel{
    
    let producto : Producto?  = nil
    
    func Add (producto : Producto) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Producto (Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion,Imagen) VALUES (?,?,?,?,?,?,?)"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                sqlite3_bind_text(statement, 6, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 7, (producto.Imagen! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                } else {
                    print(sqlite3_step(statement))
                    result.Correct = false
                    result.ErrorMessage = "Recurso no insertado."
                }
            }
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
 
    func Update (producto : Producto, idProducto : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "UPDATE Producto SET Nombre = ?, PrecioUnitario = ?, Stock = ?, IdProveedor = ?, IdDepartamento = ?, Descripcion = ?, Imagen = ? WHERE IdProducto = ?"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                sqlite3_bind_text(statement, 6, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 7, (producto.Imagen! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 8, Int32(idProducto))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                } else {
                    print(sqlite3_step(statement))
                    result.Correct = false
                    result.ErrorMessage = "No logre modificar los recursos en la Base de Datos."
                }
            } else {
                print(sqlite3_step(statement))
                print(statement)
                print(context.db!)
            }
            
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func Delete (idProducto : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Producto WHERE IdProducto = \(idProducto)"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                } else {
                    print(sqlite3_step(statement))
                    result.Correct = false
                    result.ErrorMessage = "No logre eliminar los recursos en la Base de Datos."
                }
            } else {
                print(sqlite3_step(statement))
                print(statement)
                print(context.db!)
            }
            
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetAll () -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT
                IdProducto,
                Producto.Nombre AS NombreProducto,
                PrecioUnitario,
                Stock,
                Producto.IdProveedor,
                Proveedor.Nombre AS NombreProveedor,
                Proveedor.Telefono,
                Producto.IdDepartamento,
                Departamento.Nombre AS NombreDepartamento,
                Departamento.IdArea,
                Area.Nombre AS NombreArea,
                Descripcion,
                Imagen
                FROM Producto
                INNER JOIN Proveedor ON Producto.IdProveedor = Proveedor.IdProveedor
                INNER JOIN Departamento ON Producto.IdDepartamento = Departamento.IdDepartamento
                INNER JOIN Area ON Departamento.IdArea = Area.IdArea
                """
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW){
                    
                    var description : String? = nil
                    if sqlite3_column_text(statement, 11) != nil {
                        description = String(cString: sqlite3_column_text(statement, 11))
                    }
                    var imagen : String? = nil
                    if sqlite3_column_text(statement, 12) != nil{
                        imagen = String(cString: sqlite3_column_text(statement, 12))
                    }
                    
                    let producto = Producto(
                                        IdProducto: Int(sqlite3_column_int(statement, 0)),
                                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                                        PrecioUnitario: sqlite3_column_double(statement, 2),
                                        Stock: Int(sqlite3_column_int(statement, 3)),
                                        Proveedor: Proveedor(
                                            IdProveedor: Int(sqlite3_column_int(statement, 4)),
                                            Nombre: String(cString: sqlite3_column_text(statement, 5)),
                                            Telefono: String(cString: sqlite3_column_text(statement, 6))
                                        ),
                                        Departamento: Departamento(
                                            IdDepartamento: Int(sqlite3_column_int(statement, 7)),
                                            Nombre: String(cString: sqlite3_column_text(statement, 8)),
                                            Area: Area(
                                                IdArea: Int(sqlite3_column_int(statement, 9)),
                                                Nombre: String(cString: sqlite3_column_text(statement, 10))
                                            )
                                        ),
                                        Descripcion: description ,
                                        Imagen: imagen
                                    )
                    result.Objects?.append(producto)
                }
                result.Correct = true
                
            }
            
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetByIdDepartamento (idDepartamento : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT IdProducto,
                Nombre,
                PrecioUnitario,
                Stock,
                IdProveedor,
                IdDepartamento,
                Descripcion,
                Imagen
                FROM Producto
                WHERE IdDepartamento == \(idDepartamento)
                """
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW){
                    var description : String? = nil
                    if sqlite3_column_text(statement, 6) != nil {
                        description = String(cString: sqlite3_column_text(statement, 6))
                    }
                    var imagen : String? = nil
                    if sqlite3_column_text(statement, 7) != nil{
                        imagen = String(cString: sqlite3_column_text(statement, 7))
                    }
                    
                    let producto = Producto(
                                        IdProducto: Int(sqlite3_column_int(statement, 0)),
                                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                                        PrecioUnitario: sqlite3_column_double(statement, 2),
                                        Stock: Int(sqlite3_column_int(statement, 3)),
                                        Proveedor: Proveedor(
                                            IdProveedor: Int(sqlite3_column_int(statement, 4)),
                                            Nombre: "",
                                            Telefono: ""
                                        ),
                                        Departamento: Departamento(
                                            IdDepartamento: Int(sqlite3_column_int(statement, 5)),
                                            Nombre: "",
                                            Area: Area(
                                                IdArea: 0,
                                                Nombre: ""
                                            )
                                        ),
                                        Descripcion: description ,
                                        Imagen: imagen
                                    )
                    result.Objects?.append(producto)
                }
                result.Correct = true
                
            }
            
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetById (idProducto : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT
                IdProducto,
                Producto.Nombre AS NombreProducto,
                PrecioUnitario,
                Stock,
                Producto.IdProveedor,
                Proveedor.Nombre AS NombreProveedor,
                Proveedor.Telefono,
                Producto.IdDepartamento,
                Departamento.Nombre AS NombreDepartamento,
                Departamento.IdArea,
                Area.Nombre AS NombreArea,
                Descripcion,
                Imagen
                FROM Producto
                INNER JOIN Proveedor ON Producto.IdProveedor = Proveedor.IdProveedor
                INNER JOIN Departamento ON Producto.IdDepartamento = Departamento.IdDepartamento
                INNER JOIN Area ON Departamento.IdArea = Area.IdArea
                WHERE IdProducto == \(idProducto)
                """
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                if(sqlite3_step(statement) == SQLITE_ROW){
                    var description : String? = nil
                    if sqlite3_column_text(statement, 11) != nil {
                        description = String(cString: sqlite3_column_text(statement, 11))
                    }
                    
                    var imagen : String? = nil
                    if sqlite3_column_text(statement, 12) != nil {
                        imagen = String(cString: sqlite3_column_text(statement, 12))
                    }
                    
                    let producto = Producto(
                                        IdProducto: Int(sqlite3_column_int(statement, 0)),
                                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                                        PrecioUnitario: sqlite3_column_double(statement, 2),
                                        Stock: Int(sqlite3_column_int(statement, 3)),
                                        Proveedor: Proveedor(
                                            IdProveedor: Int(sqlite3_column_int(statement, 4)),
                                            Nombre: String(cString: sqlite3_column_text(statement, 5)),
                                            Telefono: String(cString: sqlite3_column_text(statement, 6))
                                        ),
                                        Departamento: Departamento(
                                            IdDepartamento: Int(sqlite3_column_int(statement, 7)),
                                            Nombre: String(cString: sqlite3_column_text(statement, 8)),
                                            Area: Area(
                                                IdArea: Int(sqlite3_column_int(statement, 9)),
                                                Nombre: String(cString: sqlite3_column_text(statement, 10))
                                            )
                                        ),
                                        Descripcion: description ,
                                        Imagen: imagen
                                    )
                    result.Object = producto
                    result.Correct = true
                } else {
                    result.Correct = false
                    result.ErrorMessage = "Producto no encontrado"
                }
                
                
            }
            
        } catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}

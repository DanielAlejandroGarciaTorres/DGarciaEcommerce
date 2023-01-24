//
//  ProveedorViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 10/01/23.
//

import Foundation
import SQLite3

class ProveedorViewModel {
    
    
    func GetAll() -> Result {
        var result = Result()
        
        let context = DB.init()
        let query = """
                SELECT
                IdProveedor,
                Nombre,
                Telefono
                FROM Proveedor
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    let proveedor = Proveedor(
                            IdProveedor: Int(sqlite3_column_int(statement, 0)),
                            Nombre: String(cString: sqlite3_column_text(statement, 1)),
                            Telefono: String(cString: sqlite3_column_text(statement, 1))
                    )
                    
                    result.Objects?.append(proveedor)
                }
                result.Correct = true
            }
        } catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        
        return result
    }
    
    func GetById(idProveedor: Int) -> Result {
        var result = Result()
        
        let context = DB.init()
        let query = """
                SELECT
                IdProveedor,
                Nombre,
                Telefono
                FROM Proveedor
                WHERE idProveedor = \(idProveedor)
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                if sqlite3_step(statement) == SQLITE_ROW {
                    let proveedor = Proveedor(
                        IdProveedor: Int(sqlite3_column_int(statement, 0)),
                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                        Telefono: String(cString: sqlite3_column_text(statement, 1))
                    )
                    
                    result.Object = proveedor
                    result.Correct = true
                }
            } else {
                result.Correct = false
                result.ErrorMessage = "Error al obtener al usuario"
            }
        } catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        
        return result
    }
    
}

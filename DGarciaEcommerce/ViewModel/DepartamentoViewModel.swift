//
//  DepartamentoViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 04/01/23.
//

import Foundation
import SQLite3

class DepartamentoViewModel{
    
    let departamento: Departamento? = nil
    
    func Add(departamento : Departamento) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Departamento (Nombre, IdArea) VALUES (?,?)"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(departamento.Area.IdArea))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                } else {
                    result.Correct = false
                    result.ErrorMessage = "Recurso no insertado."
                }
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
    
    func Update(departamento : Departamento, idDepartamento : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "UPDATE Departamento SET Nombre = ?, IdArea = ? WHERE IdDepartamento = ?"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(departamento.Area.IdArea))
                sqlite3_bind_int(statement, 3, Int32(idDepartamento))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print(sqlite3_changes(context.db))
                    if sqlite3_changes(context.db) != 0 {
                        result.Correct = true
                    } else {
                        result.Correct = false
                        result.ErrorMessage = "Recurso no actualizado."
                    }
                } else {
                    result.Correct = false
                    result.ErrorMessage = "Recurso no actualizado."
                }
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
    
    func Delete(idDepartamento : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Departamento WHERE IdDepartamento = \(idDepartamento)"
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    if sqlite3_changes(context.db) != 0 {
                        result.Correct = true
                    } else {
                        result.Correct = false
                        result.ErrorMessage = "Recurso no eliminado."
                    }
                } else {
                    result.Correct = false
                    result.ErrorMessage = "Recurso no eliminado."
                }
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
    
    func GetAll() -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT
                IdDepartamento,
                Departamento.Nombre,
                Departamento.IdArea,
                Area.Nombre
                FROM Departamento
                INNER JOIN Area ON Departamento.IdArea = Area.IdArea
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    let departamento = Departamento(
                        IdDepartamento: Int(sqlite3_column_int(statement, 0)),
                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                        Area: Area(
                            IdArea: Int(sqlite3_column_int(statement, 2)),
                            Nombre: String(cString: sqlite3_column_text(statement, 3))))
                    result.Objects?.append(departamento)
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
    
    
    func GetByIdDepartamentos(idArea : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT
                IdDepartamento,
                Nombre,
                IdArea
                FROM Departamento
                WHERE IdArea == \(idArea)
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    let departamento = Departamento(
                        IdDepartamento: Int(sqlite3_column_int(statement, 0)),
                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                        Area: Area(
                            IdArea: Int(sqlite3_column_int(statement, 2)),
                            Nombre: ""))
                    result.Objects?.append(departamento)
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
    
    func GetById(idDepartamento : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = """
                SELECT
                IdDepartamento,
                Departamento.Nombre,
                Departamento.IdArea,
                Area.Nombre
                FROM Departamento
                INNER JOIN Area ON Departamento.IdArea = Area.IdArea
                WHERE IdDepartamento == \(idDepartamento)
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_ROW {
                    let departamento = Departamento(
                        IdDepartamento: Int(sqlite3_column_int(statement, 0)),
                        Nombre: String(cString: sqlite3_column_text(statement, 1)),
                        Area: Area(
                            IdArea: Int(sqlite3_column_int(statement, 2)),
                            Nombre: String(cString: sqlite3_column_text(statement, 3))))
                    result.Object = departamento
                    result.Correct = true
                } else {
                    result.Correct = false
                    result.ErrorMessage = "Departamento no encontrado"
                }
                
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

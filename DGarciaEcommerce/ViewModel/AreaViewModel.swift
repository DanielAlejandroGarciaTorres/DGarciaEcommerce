//
//  AreaViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 11/01/23.
//

import Foundation
import SQLite3

class AreaViewModel {
    
    func GetAll() -> Result {
        var result = Result()
        
        let context = DB.init()
        let query = """
                SELECT
                IdArea,
                Nombre
                FROM Area
                """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    let area = Area(
                            IdArea: Int(sqlite3_column_int(statement, 0)),
                            Nombre: String(cString: sqlite3_column_text(statement, 1))
                    )
                    
                    result.Objects?.append(area)
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
    
}

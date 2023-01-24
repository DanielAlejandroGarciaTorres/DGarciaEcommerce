//
//  DB.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 27/12/22.
//

import Foundation
import SQLite3

class DB {
    let path :  String = "DGarciaEcommere.sql"
    var db : OpaquePointer? = nil
    
    init(){
        db = OpenConection()
    }
    
    func OpenConection() -> OpaquePointer?{
//        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(self.path)
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK {
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, "PRAGMA foreign_keys = TRUE", -1, &statement, nil) == SQLITE_OK {
                
                print("Conexion correcta")
                print(filePath)
                
                sqlite3_finalize(statement)
                
                return db
            }
        }
        return nil
    }
    
}


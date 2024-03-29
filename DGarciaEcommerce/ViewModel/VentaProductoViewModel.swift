//
//  VentaProductoViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 24/01/23.
//

import Foundation
import CoreData
import UIKit
import SQLite3

class VentaProductoViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(idProducto : Int, cantidad: Int) -> Result {
        
        var result = Result()
        
        let existente = validarExistenciaProducto(idProducto: idProducto)
        
        if existente == -1 {
//            print("No existe el producto")
            do {
                let context = appDelegate.persistentContainer.viewContext
                let entidad = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)
                let ventaProductoCoreData = NSManagedObject(entity: entidad!, insertInto: context)
    
                ventaProductoCoreData.setValue(idProducto, forKey: "idProducto")
                ventaProductoCoreData.setValue(cantidad, forKey: "cantidad")
    
                try! context.save()
                result.Correct = true
    
            } catch let error {
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            
        } else {
//            print("El producto existe en la posicicon \(existente)")
            do {
                let context = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
                let productos = try context.fetch(request) as! [NSManagedObject]
                
                productos[existente].setValue(productos[existente].value(forKey: "cantidad") as! Int + cantidad, forKey: "cantidad")
                
                try! context.save()
                result.Correct = true
                
            } catch let error {
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
        }
        return result
    }
    
    func Update(idProducto : Int, cantidad: Int) -> Result {
        
        var result = Result()
        
        let existente = validarExistenciaProducto(idProducto: idProducto)
        
        if existente != -1 {
//            print("El producto existe en la posicicon \(existente)")
            do {
                let context = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
                let productos = try context.fetch(request) as! [NSManagedObject]
                
                productos[existente].setValue(cantidad, forKey: "cantidad")
                
                try! context.save()
                result.Correct = true
                
            } catch let error {
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
        } else {
            result.Correct = false
            result.ErrorMessage = "Prodcuto no encontrado"
        }
        return result
    }
    
    func validarExistenciaProducto(idProducto: Int) -> Int{
        var encontrado = -1
        
        do {
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            
            let productos = try! context.fetch(request) as! [NSManagedObject]
            var productoContador = 0
            
            while productos.count > productoContador {
                if productos[productoContador].value(forKey: "idProducto") as! Int == idProducto {
                     encontrado = productoContador
                    break
                }
                productoContador += 1
            }
        }
        
        return encontrado
    }
    
    func Delete(posicionProducto : Int) -> Result {
        var result = Result()
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let producto = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(producto[posicionProducto])
            try context.save()
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func DeleteAll() -> Result {
        var result = Result()
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let productos = try context.fetch(request) as! [NSManagedObject]
            
            for producto in productos {
                context.delete(producto)
            }
            
            try context.save()
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    
    func GetAll() -> Result{
        
        var result = Result()
        
        do {
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            
            let ventaProducto = try context.fetch(request) as! [NSManagedObject]
            result.Objects = []
            
            for producto in ventaProducto {
               
                let productoId = ProductoViewModel().GetById(idProducto: producto.value(forKey: "idProducto") as! Int).Object as! Producto
                
                let productoRecupera = VentaProducto(
                                    idVentaProducto: Int(producto.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                                    producto: productoId,
                                    cantidad: producto.value(forKey: "cantidad") as! Int)
                
                result.Objects?.append(productoRecupera)
            }
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func AddVentaRealizada(total : Double, metodoPago : Int) ->Result {
        var result = Result()
        
        let context = DB.init()
        let query = """
                    INSERT INTO Venta
                    (IdUsuario,
                    Total,
                    IdMetodoPago,
                    Fecha)
                    VALUES (?,?,?,?)
                    """
        var statement : OpaquePointer? = nil
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, 1)
                sqlite3_bind_double(statement, 2, total)
                sqlite3_bind_int(statement, 3, Int32(metodoPago))
                sqlite3_bind_text(statement, 4, DateFormatter().string(from: Date()), -1, nil)

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
    
    func GetAllMetodoPago() -> Result {
        var result = Result()
        
        let context = DB.init()
        
        let query = """
                    SELECT
                    IdMetodoPago,
                    Metodo
                    FROM MetodoPago
                    """
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    let metodoPago = MetodoPago(
                        idMetodoPago: Int(sqlite3_column_int(statement, 0)),
                        Metodo: String(cString: sqlite3_column_text(statement, 1))
                    )
                    
                    result.Objects?.append(metodoPago)
                }
                result.Correct = true
            }
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
}

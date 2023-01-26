//
//  VentaProductoViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 24/01/23.
//

import Foundation
import CoreData
import UIKit

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
}

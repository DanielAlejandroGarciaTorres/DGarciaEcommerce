//
//  UsuarioViewModel.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 06/01/23.
//

import CoreData
import UIKit

class UsuarioViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var usuario : Usuario? = nil
    
    func Add (usuario : Usuario) -> Result{
        
        var result = Result()
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
            usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
            usuarioCoreData.setValue(usuario.ApelldioPaterno, forKey: "apellidoPaterno")
            usuarioCoreData.setValue(usuario.ApelldioMaterno, forKey: "apellidoMaterno")
            usuarioCoreData.setValue(usuario.Email, forKey: "email")
            usuarioCoreData.setValue(usuario.password, forKey: "password")
            usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
            usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
            usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
            usuarioCoreData.setValue(usuario.CURP, forKey: "curp")
            usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
            
            
            try! context.save()
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func Update(usuario : Usuario, posicionUsuario : Int) -> Result {
        
        var result = Result()
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            //            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            //            let usuarioCoreData = NSManagedObject(context: context)
            
            
            
            
            
            usuarios[posicionUsuario].setValue(usuario.UserName, forKey: "userName")
            usuarios[posicionUsuario].setValue(usuario.Nombre, forKey: "nombre")
            usuarios[posicionUsuario].setValue(usuario.ApelldioPaterno, forKey: "apellidoPaterno")
            usuarios[posicionUsuario].setValue(usuario.ApelldioMaterno, forKey: "apellidoMaterno")
            usuarios[posicionUsuario].setValue(usuario.Email, forKey: "email")
            usuarios[posicionUsuario].setValue(usuario.password, forKey: "password")
            print(usuario.FechaNacimiento)
            usuarios[posicionUsuario].setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarios[posicionUsuario].setValue(usuario.Sexo, forKey: "sexo")
            usuarios[posicionUsuario].setValue(usuario.Telefono, forKey: "telefono")
            usuarios[posicionUsuario].setValue(usuario.Celular, forKey: "celular")
            usuarios[posicionUsuario].setValue(usuario.CURP, forKey: "curp")
            usuarios[posicionUsuario].setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func Delete(posicionUsuario : Int) -> Result {
        var result = Result()
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(usuarios[posicionUsuario])
            try context.save()
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    
    func GetAll() -> Result {
        
        var result = Result()
        
        do {
            
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            result.Objects = []
            
            for usuario in usuarios {
                let user = Usuario(
                        IdUsuario: Int(usuario.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                        UserName: usuario.value(forKey: "userName") as! String,
                        Nombre: usuario.value(forKey: "nombre") as! String,
                        ApelldioPaterno: usuario.value(forKey: "apellidoPaterno") as! String,
                        ApelldioMaterno: usuario.value(forKey: "apellidoMaterno") as? String,
                        Email: usuario.value(forKey: "email") as! String,
                        password: usuario.value(forKey: "password") as! String,
                        FechaNacimiento: usuario.value(forKey: "fechaNacimiento") as! Date,
                        Sexo: usuario.value(forKey: "sexo") as! String,
                        Telefono: usuario.value(forKey: "telefono") as! String,
                        Celular: usuario.value(forKey: "celular") as? String,
                        CURP: usuario.value(forKey: "curp") as? String,
                        Imagen: usuario.value(forKey: "imagen") as? String
                )
                result.Objects?.append(user)
            }
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func GetById(posisicionUsuario : Int) -> Result {
        
        var result = Result()
        
        do {
            
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            
            usuario = Usuario(
                        IdUsuario: Int(usuarios[posisicionUsuario].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                        UserName: usuarios[posisicionUsuario].value(forKey: "userName") as! String,
                        Nombre: usuarios[posisicionUsuario].value(forKey: "nombre") as! String,
                        ApelldioPaterno: usuarios[posisicionUsuario].value(forKey: "apellidoPaterno") as! String,
                        ApelldioMaterno: usuarios[posisicionUsuario].value(forKey: "apellidoMaterno") as? String,
                        Email: usuarios[posisicionUsuario].value(forKey: "email") as! String,
                        password: usuarios[posisicionUsuario].value(forKey: "password") as! String,
                        FechaNacimiento: usuarios[posisicionUsuario].value(forKey: "fechaNacimiento") as! Date,
                        Sexo: usuarios[posisicionUsuario].value(forKey: "sexo") as! String,
                        Telefono: usuarios[posisicionUsuario].value(forKey: "telefono") as! String,
                        Celular: usuarios[posisicionUsuario].value(forKey: "celular") as? String,
                        CURP: usuarios[posisicionUsuario].value(forKey: "curp") as? String,
                        Imagen: usuarios[posisicionUsuario].value(forKey: "imagen") as? String
                )

            result.Object = usuario
            result.Correct = true
            
            
//            var contadorUsuarios = 0
            
//            while usuarios.count > contadorUsuarios  && result.Correct == false{
//
//                if usuarios[contadorUsuarios].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1] == String(idUsuario) {
//                    print("Encontre al usuario")
//
//                    usuario = Usuario(
//                            IdUsuario: Int(usuarios[contadorUsuarios].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
//                            UserName: usuarios[contadorUsuarios].value(forKey: "userName") as! String,
//                            Nombre: usuarios[contadorUsuarios].value(forKey: "nombre") as! String,
//                            ApelldioPaterno: usuarios[contadorUsuarios].value(forKey: "apellidoPaterno") as! String,
//                            ApelldioMaterno: usuarios[contadorUsuarios].value(forKey: "apellidoMaterno") as? String,
//                            Email: usuarios[contadorUsuarios].value(forKey: "email") as! String,
//                            password: usuarios[contadorUsuarios].value(forKey: "password") as! String,
//                            FechaNacimiento: usuarios[contadorUsuarios].value(forKey: "fechaNacimiento") as! Date,
//                            Sexo: usuarios[contadorUsuarios].value(forKey: "sexo") as! String,
//                            Telefono: usuarios[contadorUsuarios].value(forKey: "telefono") as! String,
//                            Celular: usuarios[contadorUsuarios].value(forKey: "celular") as? String,
//                            CURP: usuarios[contadorUsuarios].value(forKey: "curp") as? String,
//                            Imagen: usuarios[contadorUsuarios].value(forKey: "imagen") as? String
//                    )
//
//                    result.Object = usuario
//                    result.Correct = true
//
//
//                }
//                contadorUsuarios += 1
//            }
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
        
    }
    
}

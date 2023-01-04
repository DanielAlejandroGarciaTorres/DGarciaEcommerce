//
//  ViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 27/12/22.
//

import UIKit

class ProductoController: UIViewController {
    
    @IBOutlet weak var NombreProducto: UITextField!
    @IBOutlet weak var PrecioUnitario: UITextField!
    @IBOutlet weak var Stock: UITextField!
    @IBOutlet weak var IdProveedor: UITextField!
    @IBOutlet weak var IdDepartamento: UITextField!
    @IBOutlet weak var Descripcion: UITextField!
    @IBOutlet weak var ButtonOultet: UIButton!
    
    var idProducto : Int? = nil
    
    let productoViewmodel = ProductoViewModel()
    var productoModel : Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validar()
        // Do any additional setup after loading the view.
        
        //productoViewmodel.GetAll()
//        productoViewmodel.GetById(idProducto: 6)
        
    }
    
    func validar(){
        if idProducto != nil {
            
            let productoModel = (productoViewmodel.GetById(idProducto: idProducto!).Object as! Producto)
//            productoModel = (result.Object as! Producto)
            
            self.NombreProducto.text = productoModel.Nombre
            self.PrecioUnitario.text = String(describing: productoModel.PrecioUnitario)
            self.Stock.text = String(describing: productoModel.Stock)
            self.IdProveedor.text = String(describing: productoModel.Proveedor.IdProveedor)
            self.IdDepartamento.text = String(describing: productoModel.Departamento.IdDepartamento)
            self.Descripcion.text = productoModel.Descripcion
            
            ButtonOultet.setTitle("Actualizar", for: .normal)
            ButtonOultet.titleLabel?.text = "Actualizar"
        } else {
            idProducto = 0
            ButtonOultet.setTitle("Agregar", for: .normal)
            ButtonOultet.titleLabel?.text = "Agregar"
        }
    }


    @IBAction func Action(_ sender: UIButton) {

        guard NombreProducto.text != "" else {
            NombreProducto.layer.borderWidth = 1.0
            NombreProducto.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        guard PrecioUnitario.text != "" else {
            PrecioUnitario.layer.borderWidth = 1.0
            PrecioUnitario.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        guard Stock.text != "" else {
            Stock.layer.borderWidth = 1.0
            Stock.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        guard IdProveedor.text != "" else {
            IdProveedor.layer.borderWidth = 1.0
            IdProveedor.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        guard IdDepartamento.text != "" else {
            IdDepartamento.layer.borderWidth = 1.0
            IdDepartamento.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        productoModel = Producto(
            IdProducto: idProducto!,
            Nombre: NombreProducto.text!,
            PrecioUnitario: Double(PrecioUnitario.text!)!,
            Stock: Int(Stock.text!)!,
            Proveedor: Proveedor.init(IdProveedor: Int(self.IdProveedor.text!)!, Nombre: "", Telefono: ""),
            Departamento: Departamento.init(IdDepartamento: Int(self.IdDepartamento.text!)!,Nombre: "", Area: Area.init(IdArea: 0, Nombre: "")),
            Descripcion: Descripcion.text!,
            Imagen: nil)
        
        var result = Result()
        
        print(sender.titleLabel!.text!)
        print(sender.currentTitle!)
        
        if sender.currentTitle! == "Agregar"{
            result = productoViewmodel.Add(producto: productoModel!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Producto insertado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreProducto.text = ""
                    self.PrecioUnitario.text = ""
                    self.Stock.text = ""
                    self.IdProveedor.text = ""
                    self.IdDepartamento.text = ""
                    self.Descripcion.text = ""
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Producto no insertado!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreProducto.text = ""
                    self.PrecioUnitario.text = ""
                    self.Stock.text = ""
                    self.IdProveedor.text = ""
                    self.IdDepartamento.text = ""
                    self.Descripcion.text = ""
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else if sender.currentTitle! == "Actualizar" {
            print("voy a actualizar")
            result = productoViewmodel.Update(producto: productoModel!, idProducto: idProducto!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Producto actualizado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreProducto.text = ""
                    self.PrecioUnitario.text = ""
                    self.Stock.text = ""
                    self.IdProveedor.text = ""
                    self.IdDepartamento.text = ""
                    self.Descripcion.text = ""
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Producto no modificado!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "¡Sin acceso!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
   
//
//
//    @IBAction func Update(_ sender: UIButton) {
//        guard NombreProducto.text != "" else {
//            NombreProducto.layer.borderWidth = 1.0
//            NombreProducto.layer.borderColor = UIColor.systemRed.cgColor
//            return
//        }
//
//        guard PrecioUnitario.text != "" else {
//            PrecioUnitario.layer.borderWidth = 1.0
//            PrecioUnitario.layer.borderColor = UIColor.systemRed.cgColor
//            return
//        }
//
//        guard Stock.text != "" else {
//            Stock.layer.borderWidth = 1.0
//            Stock.layer.borderColor = UIColor.systemRed.cgColor
//            return
//        }
//
//        guard IdProveedor.text != "" else {
//            IdProveedor.layer.borderWidth = 1.0
//            IdProveedor.layer.borderColor = UIColor.systemRed.cgColor
//            return
//        }
//
//        guard IdDepartamento.text != "" else {
//            IdDepartamento.layer.borderWidth = 1.0
//            IdDepartamento.layer.borderColor = UIColor.systemRed.cgColor
//            return
//        }
//
//
//
//
//
//        productoModel = Producto(
//            IdProducto: 0,
//            Nombre: NombreProducto.text!,
//            PrecioUnitario: Double(PrecioUnitario.text!)!,
//            Stock: Int(Stock.text!)!,
//            Proveedor: Proveedor.init(IdProveedor: Int(self.IdProveedor.text!)!, Nombre: "", Telefono: ""),
//            Departamento: Departamento.init(IdDepartamento: Int(self.IdDepartamento.text!)!,Nombre: "", Area: Area.init(IdArea: 0, Nombre: "")),
//            Descripcion: Descripcion.text!,
//            Imagen: nil)
//
//        let result = productoViewmodel.Update(producto: productoModel!, idProducto: Int32(IdProducto.text!)!)
//
//        if result.Correct {
//            let alert = UIAlertController(title: "Confirmación", message: "Producto modificado.", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
//                self.NombreProducto.text = ""
//                self.PrecioUnitario.text = ""
//                self.Stock.text = ""
//                self.IdProveedor.text = ""
//                self.IdDepartamento.text = ""
//                self.Descripcion.text = ""
//            })
//            alert.addAction(ok)
//            self.present(alert, animated: true)
//        } else {
//            printContent("Something is wrong")
//        }
//    }
//
    
}


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
    @IBOutlet weak var IdProducto: UITextField!
    
    let productoViewmodel = ProductoViewModel()
    var prodcutoModel : Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //productoViewmodel.GetAll()
//        productoViewmodel.GetById(idProducto: 6)
    }


    @IBAction func Add(_ sender: UIButton) {
        
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
        
        
        
        prodcutoModel = Producto(
            IdProducto: 0,
            Nombre: NombreProducto.text!,
            PrecioUnitario: Double(PrecioUnitario.text!)!,
            Stock: Int(Stock.text!)!,
            Proveedor: Proveedor.init(IdProveedor: Int(self.IdProveedor.text!)!, Nombre: "", Telefono: ""),
            Departamento: Departamento.init(IdDepartamento: Int(self.IdDepartamento.text!)!,Nombre: "", Area: Area.init(IdArea: 0, Nombre: "")),
            Descripcion: Descripcion.text!,
            Imagen: nil)
        
        let result = productoViewmodel.Add(producto: prodcutoModel!)
        
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
            printContent("Something is wrong")
        }
    }
    
    
    @IBAction func Update(_ sender: UIButton) {
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
        
        guard IdProducto.text != "" else {
            IdProducto.layer.borderWidth = 1.0
            IdProducto.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        
        
        prodcutoModel = Producto(
            IdProducto: 0,
            Nombre: NombreProducto.text!,
            PrecioUnitario: Double(PrecioUnitario.text!)!,
            Stock: Int(Stock.text!)!,
            Proveedor: Proveedor.init(IdProveedor: Int(self.IdProveedor.text!)!, Nombre: "", Telefono: ""),
            Departamento: Departamento.init(IdDepartamento: Int(self.IdDepartamento.text!)!,Nombre: "", Area: Area.init(IdArea: 0, Nombre: "")),
            Descripcion: Descripcion.text!,
            Imagen: nil)
        
        let result = productoViewmodel.Update(producto: prodcutoModel!, idProducto: Int32(IdProducto.text!)!)
        
        if result.Correct {
            let alert = UIAlertController(title: "Confirmación", message: "Producto modificado.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.NombreProducto.text = ""
                self.PrecioUnitario.text = ""
                self.Stock.text = ""
                self.IdProveedor.text = ""
                self.IdDepartamento.text = ""
                self.Descripcion.text = ""
                self.IdProducto.text = ""
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        } else {
            printContent("Something is wrong")
        }
    }
    
    @IBAction func Delete(_ sender: UIButton) {
        
        guard IdProducto.text != "" else {
            IdProducto.layer.borderWidth = 1.0
            IdProducto.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        let result = productoViewmodel.Delete(idProducto: Int32(IdProducto.text!)!)
        
        if result.Correct {
            let alert = UIAlertController(title: "Confirmación", message: "Producto eliminado.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.IdProducto.text = ""
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        } else {
            printContent("Something is wrong")
        }
    }
    
    
}


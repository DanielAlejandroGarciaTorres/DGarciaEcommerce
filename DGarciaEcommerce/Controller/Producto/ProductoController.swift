//
//  ViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 27/12/22.
//

import UIKit
import iOSDropDown

class ProductoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var NombreProducto: UITextField!
    @IBOutlet weak var PrecioUnitario: UITextField!
    @IBOutlet weak var Stock: UITextField!
    @IBOutlet weak var IdProveedor: DropDown!
    @IBOutlet weak var IdArea: DropDown!
    @IBOutlet weak var IdDepartamento: DropDown!
    @IBOutlet weak var Descripcion: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ButtonOultet: UIButton!
    
    var idProducto : Int? = nil
    
    var idProveedorSelected : Int? = nil
//    var idAreaSelected : Int? = nil
    var idDepartamentoSelected: Int? = nil
    
    let imagePicker = UIImagePickerController()
    let productoViewmodel = ProductoViewModel()
    let proveedorViewModel = ProveedorViewModel()
    let departamentoViewModel = DepartamentoViewModel()
    let areaViewModel = AreaViewModel()
    var productoModel : Producto? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        // Do any additional setup after loading the view.
        
        //productoViewmodel.GetAll()
        //        productoViewmodel.GetById(idProducto: 6)
        ConfiguraDropDown()
        LoadData()
        
        IdProveedor.didSelect { selectedText, index, id  in
            self.idProveedorSelected = id
        }
        
        IdArea.didSelect { selectedText, index, id in
            self.LoadDepartamento(idArea: id)
        }
        
        IdDepartamento.didSelect{ selectedText, index, id in
            self.idDepartamentoSelected = id
        }
        
        
        validar()
        
    }
    
    func ConfiguraDropDown() {
        IdProveedor.optionArray = [String]()
        IdProveedor.optionIds = [Int]()
        IdProveedor.isSearchEnable = false
        IdArea.optionArray = [String]()
        IdArea.optionIds = [Int]()
        IdArea.isSearchEnable = false
        IdDepartamento.isSearchEnable = false
        
//        IdProveedor.selectedRowColor = .systemBlue
//        IdProveedor.arrowSize = 15
//        IdProveedor.arrowColor = .systemGray2
//
    }
    
    func LoadDepartamento(idArea : Int){
        let result = departamentoViewModel.GetByIdDepartamentos(idArea: idArea)
        
        if result.Correct {
            
            IdDepartamento.optionArray = [String]()
            IdDepartamento.optionIds = [Int]()
            
            for departamento in result.Objects as! [Departamento]{
                
                IdDepartamento.optionArray.append(departamento.Nombre)
                IdDepartamento.optionIds?.append(departamento.IdDepartamento)
                
            }
        }
    }
    
    func LoadData() {
        
        let resultProveedor = proveedorViewModel.GetAll()
        
        if resultProveedor.Correct {
            
            for proveedor in resultProveedor.Objects as! [Proveedor]{
                
                IdProveedor.optionArray.append(proveedor.Nombre)
                IdProveedor.optionIds?.append(proveedor.IdProveedor)
                
            }
        }
        
        let resultArea = areaViewModel.GetAll()
        
        if resultArea.Correct {
            
            for area in resultArea.Objects as! [Area] {
                IdArea.optionArray.append(area.Nombre)
                IdArea.optionIds?.append(area.IdArea)
            }
        }
              
    }
    
    func validar(){
        if idProducto != nil {
            
            let productoModel = productoViewmodel.GetById(idProducto: idProducto!).Object as! Producto
            
            self.NombreProducto.text = productoModel.Nombre
            self.PrecioUnitario.text = String(describing: productoModel.PrecioUnitario)
            self.Stock.text = String(describing: productoModel.Stock)
           
            self.IdProveedor.text = self.IdProveedor.optionArray[(self.IdProveedor.optionIds?.firstIndex(of: productoModel.Proveedor.IdProveedor))!]
            self.IdProveedor.selectedIndex = (self.IdProveedor.optionIds?.firstIndex(of: productoModel.Proveedor.IdProveedor))!
            self.idProveedorSelected = self.IdProveedor.optionIds![(self.IdProveedor.optionIds?.firstIndex(of: productoModel.Proveedor.IdProveedor))!]
            
            self.IdArea.text = self.IdArea.optionArray[(self.IdArea.optionIds?.firstIndex(of: productoModel.Departamento.Area.IdArea))!]
            self.IdArea.selectedIndex = (self.IdArea.optionIds?.firstIndex(of: productoModel.Departamento.Area.IdArea))!
            self.idDepartamentoSelected = self.IdArea.optionIds![(self.IdArea.optionIds?.firstIndex(of: productoModel.Departamento.Area.IdArea))!]
            self.LoadDepartamento(idArea: self.idDepartamentoSelected!)
            self.IdDepartamento.text = self.IdDepartamento.optionArray[(self.IdDepartamento.optionIds?.firstIndex(of: productoModel.Departamento.IdDepartamento))!]
            self.IdDepartamento.selectedIndex = self.IdDepartamento.optionIds?.firstIndex(of: productoModel.Departamento.IdDepartamento)!
            
            self.Descripcion.text = productoModel.Descripcion
            if productoModel.Imagen == "" || productoModel.Imagen == nil {
                self.imageView.image = UIImage(systemName: "photo")
            } else {
                let dataDecoded: Data = Data(base64Encoded: productoModel.Imagen! , options: .ignoreUnknownCharacters)!
                self.imageView.image = UIImage(data: dataDecoded)
            }
            
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
        
        let imageString : String
        
        print(imageView.restorationIdentifier == "photo")
        if imageView.restorationIdentifier == "photo" {
            imageString = ""
        } else {
            let imageData: NSData = imageView.image!.pngData()! as NSData
            imageString = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        productoModel = Producto(
            IdProducto: idProducto!,
            Nombre: NombreProducto.text!,
            PrecioUnitario: Double(PrecioUnitario.text!)!,
            Stock: Int(Stock.text!)!,
            Proveedor: Proveedor.init(IdProveedor: self.idProveedorSelected!, Nombre: "", Telefono: ""),
            Departamento: Departamento.init(IdDepartamento: self.idDepartamentoSelected!,Nombre: "", Area: Area.init(IdArea: 0, Nombre: "")),
            Descripcion: Descripcion.text!,
            Imagen: imageString)
        
        var result = Result()
        
        if sender.currentTitle! == "Agregar"{
            result = productoViewmodel.Add(producto: productoModel!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Producto insertado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreProducto.text = ""
                    self.PrecioUnitario.text = ""
                    self.Stock.text = ""
                    self.IdProveedor.text = ""
                    self.IdArea.text = ""
                    self.IdDepartamento.text = ""
                    self.Descripcion.text = ""
                    self.imageView.image = UIImage(systemName: "photo")
                    self.IdDepartamento.optionArray = [String]()
                    self.IdDepartamento.optionIds = [Int]()
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Producto no insertado! Intentalo más tarde.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else if sender.currentTitle! == "Actualizar" {
            
            result = productoViewmodel.Update(producto: productoModel!, idProducto: idProducto!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Producto actualizado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreProducto.text = ""
                    self.PrecioUnitario.text = ""
                    self.Stock.text = ""
                    self.IdProveedor.text = ""
                    self.IdArea.text = ""
                    self.IdDepartamento.text = ""
                    self.Descripcion.text = ""
                    self.imageView.image = UIImage(systemName: "photo")
                    self.IdDepartamento.optionArray = [String]()
                    self.IdDepartamento.optionIds = [Int]()
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Producto no actualizado! Intenalo más tarde.", preferredStyle: .alert)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ImageButton() {
        self.present(imagePicker, animated: true)
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


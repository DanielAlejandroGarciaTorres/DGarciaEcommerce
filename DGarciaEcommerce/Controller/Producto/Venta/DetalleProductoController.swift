//
//  DetalleProductoController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 23/01/23.
//

import UIKit

class DetalleProductoController: UIViewController {

    @IBOutlet weak var NombreProductoLabel: UILabel!
    @IBOutlet weak var ProductoImage: UIImageView!
    @IBOutlet weak var PrecioLabel: UILabel!
    @IBOutlet weak var DescripcionLabel: UILabel!
    @IBOutlet weak var ProveedorLabel: UILabel!
    @IBOutlet weak var CatidadProductoField: UITextField!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var anadirCarritoOutlet: UIButton!
    
    var producto: Producto? = nil
    var cantidad: Int? = nil
    let ventaProductoViewModel = VentaProductoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    func LoadData() {
        if cantidad != nil {
            productQuantityLabel.text = "Cantidad: \(cantidad!)"
            CatidadProductoField.isHidden = true
            anadirCarritoOutlet.isHidden = true
        }
            
        NombreProductoLabel.text = producto!.Nombre
        if producto?.Imagen != "" && producto?.Imagen != nil{
            let imageData = Data(base64Encoded: producto!.Imagen!, options: .ignoreUnknownCharacters)
            ProductoImage.image = UIImage(data: imageData!)
        }
        PrecioLabel.text = "$ \(producto!.PrecioUnitario)"
        ProveedorLabel.text = "test"
        if producto?.Descripcion != "" && producto?.Descripcion != nil {
            DescripcionLabel.text = producto!.Descripcion
        }
        let result = ProveedorViewModel().GetById(idProveedor: producto!.Proveedor.IdProveedor)
        if (result.Correct) {
            ProveedorLabel.text = (result.Object as! Proveedor).Nombre
        }
    }

    @IBAction func AddCarrito(_ sender: Any) {
            
        guard let cantidadProducto = CatidadProductoField.text else {
            print("Seleccione una cantidad a añadir")
            return
        }
        
        if VentaProductoViewModel().Add(idProducto: producto!.IdProducto,cantidad: Int(cantidadProducto) ?? 1).Correct {
            let alert = UIAlertController(title: "Confirmación", message: "Producto añadido al carrito.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.CatidadProductoField.text = "1"
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "No fue posible añadir el producto, intente más tarde.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    @IBAction func Comprar(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

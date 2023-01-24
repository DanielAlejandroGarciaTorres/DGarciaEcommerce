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
    
    var producto: Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    func LoadData() {
        NombreProductoLabel.text = producto!.Nombre
        if producto?.Imagen != "" && producto?.Imagen != nil{
            let imageData = Data(base64Encoded: producto!.Imagen!, options: .ignoreUnknownCharacters)
            ProductoImage.image = UIImage(data: imageData!)
        }
        PrecioLabel.text = String(producto!.PrecioUnitario)
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

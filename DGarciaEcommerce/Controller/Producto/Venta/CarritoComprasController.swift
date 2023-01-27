//
//  CarritoComprasController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 25/01/23.
//

import UIKit
import SwipeCellKit

class CarritoComprasController: UIViewController {

    @IBOutlet weak var tableProductos: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var productosVenta = [VentaProducto]()
    var total : Double = 0.00
    var posicionProducto : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableProductos.delegate = self
        tableProductos.dataSource = self
        tableProductos.register(UINib(nibName: "CarritoComprasTableViewCell", bundle: nil), forCellReuseIdentifier: "CarritoComprasCell")
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    func LoadData(){
        let result = VentaProductoViewModel().GetAll()
        
        if result.Correct {
            productosVenta = result.Objects! as! [VentaProducto]
            tableProductos.reloadData()
            DispatchQueue.main.async {
                self.totalLabel.text = "$ \(String(self.total))"
            }
        }
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

extension CarritoComprasController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.00
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productosVenta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoComprasCell", for: indexPath) as! CarritoComprasTableViewCell
        cell.delegate = self
        
        cell.productName.text = productosVenta[indexPath.row].producto.Nombre
        cell.productQuntity.text = "Cantidad: \(String(productosVenta[indexPath.row].cantidad))"
        let subTotal = Double(productosVenta[indexPath.row].cantidad) * productosVenta[indexPath.row].producto.PrecioUnitario
        total += subTotal
        cell.productPrice.text = String(subTotal)
        if productosVenta[indexPath.row].producto.Imagen == "" || productosVenta[indexPath.row].producto.Imagen == nil{
            cell.productImage.image = UIImage(named: "Image-not-found")
        } else {
            let imageData = Data(base64Encoded: productosVenta[indexPath.row].producto.Imagen!, options: .ignoreUnknownCharacters)
            cell.productImage.image = UIImage(data: imageData!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.posicionProducto = indexPath.row
        self.performSegue(withIdentifier: "ShowDetailProducto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailProducto" {
            let detalleProductoController = segue.destination as! DetalleProductoController
            detalleProductoController.cantidad = productosVenta[posicionProducto].cantidad
            detalleProductoController.producto = productosVenta[posicionProducto].producto
        } else if segue.identifier == "pagoSegue" {
            let pagoViewController = segue.destination as! PagoViewController
            pagoViewController.total = total
        }
    }
}

extension CarritoComprasController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()

        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {

        guard orientation == .right else { return nil }
        self.posicionProducto = indexPath.row

        let deleteAction = SwipeAction(style: .destructive, title: "Delete"){ [self] action, indexPath in
//            self.totalLabel.text = String(Double(self.totalLabel.text!) - (Double(self.productosVenta[indexPath.row].cantidad) * self.productosVenta[indexPath.row].producto.PrecioUnitario))
            total = total - (Double(self.productosVenta[indexPath.row].cantidad) * self.productosVenta[indexPath.row].producto.PrecioUnitario)
            self.totalLabel.text = "$ \(String(total))"
            self.productosVenta.remove(at: indexPath.row)
            if VentaProductoViewModel().Delete(posicionProducto: indexPath.row).Correct {
                print("Eliminado")
            } else {
                print("Algo salio mal")
            }
        }

        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor.systemRed
        return [deleteAction]
    }
    
    
}
    


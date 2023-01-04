//
//  GetAllTableViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 29/12/22.
//

import UIKit
import SwipeCellKit

class GetAllTableViewController: UITableViewController{
    
    var idProducto : Int = 0
    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductoCell")
        LoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LoadData()
    }
    
    // MARK: - Table view data source
    
    func LoadData(){
        let result = productoViewModel.GetAll()
        if result.Correct {
            productos = result.Objects! as! [Producto]
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cofiguring the cell ...
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoTableViewCell
        
        cell.delegate = self
        cell.NombreProducto.text = productos[indexPath.row].Nombre
        cell.ProveedorProducto.text = productos[indexPath.row].Proveedor.Nombre
        cell.PrecioProducto.text = String(productos[indexPath.row].PrecioUnitario)
        cell.StockProducto.text = String(productos[indexPath.row].Stock)
        cell.ImagenProducto.image = UIImage(named: "Image-not-found")
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension GetAllTableViewController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        self.idProducto = self.productos[indexPath.row].IdProducto
        
        let updateAction = SwipeAction(style: .destructive, title: "Update") {action, indexPath in
            print("Hola soy el update en: \(self.productos[indexPath.row].Nombre)")
            
            self.performSegue(withIdentifier: "UpdateSegue", sender: self)
        }
        
        let deleteAction =  SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
            print("Hola soy el delete en: \(indexPath.row)")
            
            let result = self.productoViewModel.Delete(idProducto: self.idProducto)
            
            if result.Correct {
                self.LoadData()
                let alert = UIAlertController(title: "Confirmación", message: "Producto eliminado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Producto no eliminado!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
        
        updateAction.image = UIImage(named: "update")
        updateAction.backgroundColor = UIColor.systemOrange
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor.systemRed
        
        return [deleteAction, updateAction]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSegue" {
            let productoController = segue.destination as! ProductoController
            productoController.idProducto = self.idProducto
        }
    }
}


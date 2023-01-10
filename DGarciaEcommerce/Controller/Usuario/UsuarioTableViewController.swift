//
//  UsuarioTableViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 05/01/23.
//

import UIKit
import SwipeCellKit

class UsuarioTableViewController: UITableViewController {
    
    var posicionUsuario : Int = 0
    let usuarioViewModel = UsuarioViewModel()
    var usuarios = [Usuario]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        tableView.register(UINib(nibName: "UsuarioTableViewCell", bundle: nil), forCellReuseIdentifier: "UsuarioCell")
        LoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        LoadData()
    }
    
    func LoadData() {
        let result = usuarioViewModel.GetAll()
        if result.Correct {
            usuarios = result.Objects! as! [Usuario]
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioTableViewCell
        cell.delegate = self
        // Configure the cell...

        cell.Nombre.text = "\(usuarios[indexPath.row].Nombre) \(usuarios[indexPath.row].ApelldioPaterno)"
        cell.UserName.text = usuarios[indexPath.row].UserName
        cell.Correo.text = usuarios[indexPath.row].Email
        if usuarios[indexPath.row].Imagen == "" || usuarios[indexPath.row].Imagen == nil{
            cell.userImage.image = UIImage(systemName: "person.fill.xmark")
        } else {
            let imageData = Data(base64Encoded: usuarios[indexPath.row].Imagen!, options: .ignoreUnknownCharacters)
            cell.userImage.image = UIImage(data: imageData!)
        }
        
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

extension UsuarioTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        self.posicionUsuario = indexPath.row
      
        let updateAction = SwipeAction(style: .destructive, title: "Update") {action, indexPath in
            
            self.performSegue(withIdentifier: "UpdateSegueUsuario", sender: self)
        }
        
        let deleteAction =  SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
            let result = self.usuarioViewModel.Delete(posicionUsuario: self.posicionUsuario)

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
        if segue.identifier == "UpdateSegueUsuario" {
            let usuarioController = segue.destination as! UsuarioController
            usuarioController.posicionUsuario = self.posicionUsuario
        }
    }
}

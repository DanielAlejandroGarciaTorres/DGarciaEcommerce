//
//  ProgrammaticallyUserViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 07/03/23.
//

import UIKit
import SwipeCellKit

class ProgrammaticallyUserViewController: UIViewController {
    
    var posicionUsuario : Int = 0
    let usuarioViewModel = UsuarioViewModel()
    var usuarios = [Usuario]()
    
    var userTable = UITableView()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        userTable = UITableView()
        view.addSubview(userTable)
        userTable.translatesAutoresizingMaskIntoConstraints = false
        userTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        userTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        userTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        userTable.register(UINib(nibName: "UsuarioTableViewCell", bundle: nil), forCellReuseIdentifier: "UsuarioCell")
//        userTable.backgroundColor = UIColor.systemRed
        userTable.dataSource = self
        userTable.delegate = self
        
        LoadData()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        LoadData()
    }
    
    func LoadData() {
        let result = usuarioViewModel.GetAll()
        if result.Correct {
            usuarios = result.Objects! as! [Usuario]
            userTable.reloadData()
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

extension ProgrammaticallyUserViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    
}


extension ProgrammaticallyUserViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        self.posicionUsuario = indexPath.row
      
        let updateAction = SwipeAction(style: .destructive, title: "Update") {action, indexPath in
            print("Update")
            self.performSegue(withIdentifier: "UpdateSegueUser", sender: self)
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
        
        updateAction.image = UIImage(systemName: "pencil")
        updateAction.backgroundColor = UIColor.systemOrange
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor.systemRed
        
        return [deleteAction, updateAction]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSegueUser" {
            let usuarioController = segue.destination as! ProgramaticallyUpdateViewController
            usuarioController.posicionUsuario = self.posicionUsuario
        }
    }
}

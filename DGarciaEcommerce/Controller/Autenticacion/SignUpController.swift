//
//  SignUpController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 10/01/23.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    @IBOutlet weak var CorreoField: UITextField!
    @IBOutlet weak var Contrasenia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CorreoField.text = "dgarciatorres@gmail.com"
        Contrasenia.text = "pass@word1"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func LogIn(_ sender: Any) {
        
        guard CorreoField.text != "" else {
            CorreoField.placeholder = "Ingresa tu correo"
            return
        }
        
        guard Contrasenia.text != "" else {
            Contrasenia.placeholder = "Ingresa tu contraseña"
            return
        }
        
        
        Auth.auth().signIn(withEmail: CorreoField.text!, password: Contrasenia.text!) { authResult, error in
          if let error = error as? NSError {
            
              let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
              let ok = UIAlertAction(title: "OK", style: .default)
              alert.addAction(ok)
              self.present(alert, animated: true)
            
          } else {
              
              self.performSegue(withIdentifier: "LogInSegue", sender: self)
//            print("User signs up successfully")
//            let newUserInfo = Auth.auth().currentUser
//            let email = newUserInfo?.email
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

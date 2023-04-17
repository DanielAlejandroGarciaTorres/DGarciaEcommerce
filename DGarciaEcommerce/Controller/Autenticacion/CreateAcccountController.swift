//
//  CreateAcccountController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 11/01/23.
//

import UIKit

class CreateAcccountController: UIViewController {

    @IBOutlet weak var CorreoField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    

    @IBAction func RegisterButton(_ sender: UIButton) {
        print("Correo: \(CorreoField.text!) Contraseña \(PasswordField.text!) Confirmaion contraseña: \(ConfirmPasswordField.text!)")
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

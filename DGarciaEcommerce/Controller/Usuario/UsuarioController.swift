//
//  UsuarioViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 05/01/23.
//

import UIKit

class UsuarioController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var ApellidoPaternoField: UITextField!
    @IBOutlet weak var ApellidoMaternoField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var SexoField: UITextField!
    @IBOutlet weak var TelefonoField: UITextField!
    @IBOutlet weak var CelularField: UITextField!
    @IBOutlet weak var CURPField: UITextField!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var ButtonOulet: UIButton!
    var posicionUsuario : Int? = nil
    let imagePicker = UIImagePickerController()
    let usuarioViewModel = UsuarioViewModel()
    var usuarioModel : Usuario? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        
        // Do any additional setup after loading the view.
    }
    
    func Validar(){
        if posicionUsuario != nil {
            let usuarioModel = usuarioViewModel.GetById(posisicionUsuario: posicionUsuario!).Object as! Usuario
            
            self.UserNameField.text = usuarioModel.UserName
            self.NombreField.text = usuarioModel.Nombre
            self.ApellidoPaternoField.text = usuarioModel.ApelldioPaterno
            self.ApellidoMaternoField.text = usuarioModel.ApelldioMaterno
            self.EmailField.text = usuarioModel.Email
            self.PasswordField.text = usuarioModel.password
            self.DatePicker.date = usuarioModel.FechaNacimiento
            self.SexoField.text = usuarioModel.Sexo
            self.TelefonoField.text = usuarioModel.Telefono
            self.CelularField.text = usuarioModel.Celular
            self.CURPField.text = usuarioModel.CURP
            
            if usuarioModel.Imagen == "" || usuarioModel.Imagen == nil {
                self.imageOutlet.image = UIImage(systemName: "person.fill")
            } else {
                let dataDecoded: Data = Data(base64Encoded: usuarioModel.Imagen! , options: .ignoreUnknownCharacters)!
                self.imageOutlet.image = UIImage(data: dataDecoded)
            }
            
            ButtonOulet.setTitle("Actualizar", for: .normal)
            ButtonOulet.titleLabel?.text = "Actualizar"
        } else {
            posicionUsuario = 0
            ButtonOulet.setTitle("Agregar", for: .normal)
            ButtonOulet.titleLabel?.text = "Agregar"
        }
    }
    
    @IBAction func Action(_ sender: UIButton) {
        guard UserNameField.text != "" else {
            UserNameField.placeholder = "Ingresa un User name para el usuario"
            return
        }
        
        guard NombreField.text != "" else {
            NombreField.placeholder = "Ingresa un Nombre para el usuario"
            return
        }
        
        guard ApellidoPaternoField.text != "" else {
            ApellidoPaternoField.placeholder = "Ingresa un Apellido paterno para el usuario"
            return
        }
        
        guard EmailField.text != "" else {
            EmailField.placeholder = "Ingresa un Email para el usuario"
            return
        }
        
        guard PasswordField.text != "" else {
            PasswordField.placeholder = "Ingresa un Password para el usuario"
            return
        }
        
        guard SexoField.text != "" else {
            SexoField.placeholder = "Ingresa un Sexo para el usuario"
            return
        }
        
        guard TelefonoField.text != "" else {
            TelefonoField.placeholder = "Ingresa un Sexo para el usuario"
            return
        }
        
        let imagenString : String?
        print(imageOutlet.restorationIdentifier)
        if imageOutlet.restorationIdentifier == "person.fill" {
            imagenString = ""
        } else {
            imagenString = (imageOutlet.image!.pngData()! as NSData).base64EncodedString(options: .lineLength64Characters)

        }
        
        usuarioModel = Usuario(
                            IdUsuario: 0,
                            UserName: UserNameField.text!,
                            Nombre: NombreField.text!,
                            ApelldioPaterno: ApellidoPaternoField.text!,
                            ApelldioMaterno: ApellidoMaternoField.text,
                            Email: EmailField.text!,
                            password: PasswordField.text!,
                            FechaNacimiento: DatePicker.date,
                            Sexo: SexoField.text!,
                            Telefono: TelefonoField.text!,
                            Celular: CelularField.text!,
                            CURP: CURPField.text!,
                            Imagen: imagenString
        )
        
        var result = Result()
        
        if sender.currentTitle! == "Agregar"{
            result = usuarioViewModel.Add(usuario: usuarioModel!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Usuario insertado.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.UserNameField.text = ""
                    self.NombreField.text = ""
                    self.ApellidoPaternoField.text = ""
                    self.ApellidoMaternoField.text = ""
                    self.EmailField.text = ""
                    self.PasswordField.text = ""
                    self.SexoField.text = ""
                    self.TelefonoField.text = ""
                    self.CelularField.text = ""
                    self.CURPField.text = ""
                    self.imageOutlet.image = UIImage(systemName: "person.fill")
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Usuario no insertado! Intenalo más tarde.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else if sender.currentTitle! == "Actualizar" {
            result = usuarioViewModel.Update(usuario: usuarioModel!, posicionUsuario: posicionUsuario!)
            if result.Correct == true {
                let alert = UIAlertController(title: "Confirmación", message: "Usuario actualizado", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.UserNameField.text = ""
                    self.NombreField.text = ""
                    self.ApellidoPaternoField.text = ""
                    self.ApellidoMaternoField.text = ""
                    self.EmailField.text = ""
                    self.PasswordField.text = ""
                    self.SexoField.text = ""
                    self.TelefonoField.text = ""
                    self.CelularField.text = ""
                    self.CURPField.text = ""
                    self.imageOutlet.image = UIImage(systemName: "person.fill")
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Usuario no actualizado! Intentalo más tarde", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Sin acceso", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOutlet.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ImageButton(_ sender: Any) {
        self.present(imagePicker, animated: true)
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

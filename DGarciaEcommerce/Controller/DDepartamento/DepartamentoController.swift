//
//  DepartamentoController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 04/01/23.
//

import UIKit

class DepartamentoController: UIViewController {

    @IBOutlet weak var NombreDepartamento: UITextField!
    @IBOutlet weak var IdArea: UITextField!
    @IBOutlet weak var buttonDepartamento: UIButton!
    
    var idDepartamento : Int? = nil
    let departamentoViewModel = DepartamentoViewModel()
    var departamentoModel : Departamento? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validar()
        // Do any additional setup after loading the view.
    }
    
    func validar(){
        print(idDepartamento)
        if idDepartamento != nil {
            
            let departamentoModel = departamentoViewModel.GetById(idDepartamento: idDepartamento!).Object as! Departamento
            
            self.NombreDepartamento.text = departamentoModel.Nombre
            self.IdArea.text = String(describing: departamentoModel.Area.IdArea)
            
            buttonDepartamento.setTitle("Actualizar", for: .normal)
            buttonDepartamento.titleLabel?.text = "Actualizar"
        } else {
            idDepartamento = 0
            buttonDepartamento.setTitle("Agregar", for: .normal)
            buttonDepartamento.titleLabel?.text = "Agregar"
        }
    }
    

    @IBAction func Action(_ sender: UIButton) {
        
        guard NombreDepartamento.text != "" else {
            NombreDepartamento.placeholder = "Ingresa el nombre del departamento"
            return
        }
        
        guard IdArea.text != "" else {
            IdArea.placeholder = "Ingresa el Id del Area deseada"
            return
        }
        
        departamentoModel = Departamento(
                                    IdDepartamento: idDepartamento!,
                                    Nombre: NombreDepartamento.text!,
                                    Area: Area(
                                            IdArea: Int(IdArea.text!)!,
                                            Nombre: ""))
        
        var result = Result()
        
        if sender.currentTitle! == "Agregar" {
            
            result = departamentoViewModel.Add(departamento: departamentoModel!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Departamento insertado", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreDepartamento.text = ""
                    self.IdArea.text = ""
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Departamento no insertado! Intentalo más tarde.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else if sender.currentTitle! == "Actualizar" {
            
            result = departamentoViewModel.Update(departamento: departamentoModel!, idDepartamento: idDepartamento!)
            
            if result.Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Departamento actualizado", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.NombreDepartamento.text = ""
                    self.IdArea.text = ""
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "¡Departamento no insertado! Intentalo más tarde", preferredStyle: .alert)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

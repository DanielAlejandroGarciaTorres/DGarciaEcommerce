//
//  PagoViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 26/01/23.
//

import UIKit
import iOSDropDown

class PagoViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var MetodoPago: DropDown!
    
    var total : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguraDropDown()
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    func ConfiguraDropDown() {
        MetodoPago.optionArray = [String]()
        MetodoPago.optionIds = [Int]()
        MetodoPago.isSearchEnable = false
        
//        IdProveedor.selectedRowColor = .systemBlue
//        IdProveedor.arrowSize = 15
//        IdProveedor.arrowColor = .systemGray2
//
    }

    func LoadData() {
        totalLabel.text = "$ \(total)"
        
        let result = VentaProductoViewModel().GetAllMetodoPago()
        
        for metodoPago in result.Objects as! [MetodoPago]{
            MetodoPago.optionArray.append(metodoPago.Metodo)
            MetodoPago.optionIds?.append(metodoPago.idMetodoPago)
        }
    }
    @IBAction func ConfirmacionPago(_ sender: Any) {
        if MetodoPago.text == "" {
            let alert = UIAlertController(title: "Rechazado", message: "Selecciona tui método de pago.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                return
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        
        }
        
        if (VentaProductoViewModel().AddVentaRealizada(total: total, metodoPago: MetodoPago.optionIds![MetodoPago.selectedIndex!])).Correct {
            if VentaProductoViewModel().DeleteAll().Correct {
                let alert = UIAlertController(title: "Confirmación", message: "Compra terminada.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
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

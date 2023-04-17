//
//  ProgrammaticallyPagoViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 10/03/23.
//

import UIKit
import iOSDropDown

class ProgrammaticallyPagoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let safeG = view.safeAreaLayoutGuide
        
        let total = UILabel()
        total.translatesAutoresizingMaskIntoConstraints = false
        total.text = "Total:"
        total.font = UIFont.systemFont(ofSize: 30.0)
        
        let monto = UILabel()
        monto.translatesAutoresizingMaskIntoConstraints = false
        monto.text = "$12000.00"
        monto.font = UIFont.systemFont(ofSize: 30.0)
        
        let metodo = UILabel()
        metodo.translatesAutoresizingMaskIntoConstraints = false
        metodo.text = "Método de pago:"
        
        let tarjeta = DropDown()
        tarjeta.translatesAutoresizingMaskIntoConstraints = false
        tarjeta.optionArray = ["Debito", "Credito"]
        tarjeta.optionIds = [0,1]
        tarjeta.isSearchEnable = false
        tarjeta.borderStyle = .roundedRect
        tarjeta.selectedRowColor = .systemCyan
        tarjeta.arrowSize = 15
        tarjeta.arrowColor = .systemGray
        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.cornerStyle = .capsule
        button.setTitle("PAGAR", for: .normal)
        
        
        
        view.addSubview(total)
        view.addSubview(monto)
        view.addSubview(metodo)
        view.addSubview(tarjeta)
        view.addSubview(button)

        
        NSLayoutConstraint.activate([
            total.heightAnchor.constraint(equalToConstant: 50.0),
            total.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 20.0),
            total.bottomAnchor.constraint(equalTo: metodo.topAnchor),

            monto.heightAnchor.constraint(equalToConstant: 50.0),
            monto.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -20.0),
            monto.bottomAnchor.constraint(equalTo: metodo.topAnchor),
            
            metodo.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 20),
            metodo.bottomAnchor.constraint(equalTo: tarjeta.topAnchor),
            
            tarjeta.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 20.0),
            tarjeta.heightAnchor.constraint(equalToConstant: 50.0),
            tarjeta.widthAnchor.constraint(equalToConstant: 230.0),
            tarjeta.centerYAnchor.constraint(equalTo: safeG.centerYAnchor, constant: 25.0),
            
            button.topAnchor.constraint(equalTo: tarjeta.bottomAnchor, constant: 10.0),
            button.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 20.0),
            button.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -20.0),
            button.heightAnchor.constraint(equalToConstant: 50.0)
            
        ])
        
        // Do any additional setup after loading the view.
        
        
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

//
//  ProgrmmaticallyVentaViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 09/03/23.
//

import UIKit

class ProgrammaticallyVentaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Carrito de compras"
        
        let safeG = view.safeAreaLayoutGuide

        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.blue
        tableView.register(UINib(nibName: "CarritoComprasTableViewCell", bundle: nil), forCellReuseIdentifier: "CarritoComprasCell")
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total $12,000"
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("COMPRAR", for: .normal)
//        button.titleLabel?.text = "COMPRAR"
        button.configuration = configuration
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {incoming in
            var outgoing = incoming
            outgoing.font = UIFont.boldSystemFont(ofSize: 30)
            return outgoing
        }
        
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 20.0),
            tableView.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 30.0),
            tableView.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -30.0),
            tableView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20.0),
            
            label.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 30.0),
            label.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -30.0),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10.0),
            
            button.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 30.0),
            button.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -30.0),
            button.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -20.0),
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

extension ProgrammaticallyVentaViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.00
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoComprasCell", for: indexPath) as! CarritoComprasTableViewCell
//        cell.delegate = self
//
//        cell.productName.text = productosVenta[indexPath.row].producto.Nombre
//        cell.productQuntity.text = "Cantidad: \(String(productosVenta[indexPath.row].cantidad))"
//        let subTotal = Double(productosVenta[indexPath.row].cantidad) * productosVenta[indexPath.row].producto.PrecioUnitario
//        total += subTotal
//        cell.productPrice.text = String(subTotal)
//        if productosVenta[indexPath.row].producto.Imagen == "" || productosVenta[indexPath.row].producto.Imagen == nil{
//            cell.productImage.image = UIImage(named: "Image-not-found")
//        } else {
//            let imageData = Data(base64Encoded: productosVenta[indexPath.row].producto.Imagen!, options: .ignoreUnknownCharacters)
//            cell.productImage.image = UIImage(data: imageData!)
//        }
//        cell.StepperRow.value = Double(productosVenta[indexPath.row].cantidad)
//
//        cell.StepperRow.tag = indexPath.row
//        cell.StepperRow.addTarget(self, action: #selector(StepperAction), for: .touchUpInside)
        
        return cell
    }
//
//    @objc func StepperAction(sender: UIStepper) {
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        print("sender ---> \(sender.value)")
//        if sender.value >= 1{
//            if VentaProductoViewModel().Update(idProducto: productosVenta[indexPath.row].producto.IdProducto, cantidad: Int(sender.value)).Correct {
//                total = 0.0
//                LoadData()
//                print("Actualzo")
//            } else {
//                print("No pude actualizar")
//            }
//        } else {
//            sender.value = 1
//            print("No hago nada")
//        }
//
//    }
//
}

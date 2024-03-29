//
//  ProductoCollectionViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 12/01/23.
//

import UIKit


class ProductoCollectionViewController: UICollectionViewController {
    
    var idDepartamento : Int? = nil
    var nombreProducto : String? = nil
    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var producto : Producto? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        navigationController?.isNavigationBarHidden = false
        collectionView.register(UINib(nibName: "ProductoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductoCell")
        
        LoadData()

        // Do any additional setup after loading the view.
    }

    func LoadData() {
        
        var result = Result()
        
        if nombreProducto != nil {
            result = productoViewModel.GetByProducto(producto: self.nombreProducto!)
            
            if result.Correct {
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }
            
        } else if idDepartamento != nil{
            result = productoViewModel.GetByIdDepartamento(idDepartamento: self.idDepartamento!)
                    
            if result.Correct {
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCell", for: indexPath) as! ProductoCollectionViewCell
        
        cell.NombreProductoLabel.text = productos[indexPath.row].Nombre
        cell.PrecioProductoLabel.text = "$\(productos[indexPath.row].PrecioUnitario) "
        if productos[indexPath.row].Imagen != "" && productos[indexPath.row].Imagen != nil{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen!, options: .ignoreUnknownCharacters)
            cell.imagenProducto.image = UIImage(data: imageData!)
        }
        
        cell.celdaButton.tag = indexPath.row
        cell.celdaButton.addTarget(self, action: #selector(anadirButton), for: .touchUpInside)
        // Configure the cell
    
        return cell
    }
    
    @objc func anadirButton(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        if VentaProductoViewModel().Add(idProducto: productos[indexPath.row].IdProducto, cantidad: 1).Correct {
            let alert = UIAlertController(title: "Confirmación", message: "Producto añadido al carrito.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "No fue posible añadir el producto, intente más tarde.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
//        self.performSegue(withIdentifier: "DetalleProductoSegue", sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.producto = productos[indexPath.row]
        self.performSegue(withIdentifier: "DetalleProductoSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleProductoSegue" {
            let detalleProdcutoController = segue.destination as! DetalleProductoController
            detalleProdcutoController.producto = self.producto
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

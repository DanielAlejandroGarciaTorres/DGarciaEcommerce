//
//  AreaController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 13/01/23.
//

import UIKit

class AreaController: UIViewController {

    @IBOutlet weak var ProductoSearch: UITextField!
    @IBOutlet weak var CollectionArea: UICollectionView!
    
    var idArea : Int = 0
    let areaViewModel = AreaViewModel()
    var areas = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.CollectionArea.delegate = self
        self.CollectionArea.dataSource = self
        self.CollectionArea.register(UINib(nibName: "GeneralCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GeneralCell")
        
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    func LoadData(){
        let result = areaViewModel.GetAll()
        
        if result.Correct {
            areas = result.Objects! as! [Area]
            self.CollectionArea.reloadData()
            
            self.CollectionArea.layoutMargins = centerItemsInCollectionView(cellWidth: 160, numberOfItems: 2, spaceBetweenCell: 15, collectionView: self.CollectionArea)
        }
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }

    @IBAction func BuscarProducto(_ sender: Any) {
        self.performSegue(withIdentifier: "AreaProductoSegue", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreaProductoSegue" {
            let productoCollection = segue.destination as! ProductoCollectionViewController
            productoCollection.nombreProducto = self.ProductoSearch.text
        } else if segue.identifier == "AreaDepartamentoSegue" {
            let departamentoCollectionViewController = segue.destination as! DepartamentoCollectionViewController
            departamentoCollectionViewController.idArea = self.idArea
//            departamentoCollectionViewController.idArea = self.idArea
        }
    }
}

extension AreaController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralCollectionViewCell
        
        cell.titleLabel.text = areas[indexPath.row].Nombre
        cell.imageOutlet.image = UIImage(named: areas[indexPath.row].Nombre)
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idArea = areas[indexPath.row].IdArea
        self.performSegue(withIdentifier: "AreaDepartamentoSegue", sender: self)
        
    }
}

//
//  DepartamentoCollectionViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 12/01/23.
//

import UIKit

class DepartamentoCollectionViewController: UICollectionViewController {

    
    var idArea : Int? = nil
    var idDepartamento : Int? = nil
    let departamentoViewModel = DepartamentoViewModel()
    var departamentos = [Departamento]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        navigationController?.isNavigationBarHidden = false
        collectionView.register(UINib(nibName: "GeneralCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GeneralCell")
        
        LoadData()
        // Do any additional setup after loading the view.
    }

    func LoadData(){
        let result = departamentoViewModel.GetByIdDepartamentos(idArea: self.idArea!)
        
        if result.Correct {
            departamentos = result.Objects! as! [Departamento]
            collectionView.reloadData()
            
            collectionView.layoutMargins = centerItemsInCollectionView(cellWidth: 160, numberOfItems: 2, spaceBetweenCell: 15, collectionView: collectionView)
        }
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
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
        return departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralCollectionViewCell
        
        cell.titleLabel.text = departamentos[indexPath.row].Nombre
        cell.imageOutlet.image = UIImage(named: departamentos[indexPath.row].Nombre)
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.systemGray6
        self.idDepartamento = departamentos[indexPath.row].IdDepartamento
        self.performSegue(withIdentifier: "DepartamentoProductoSegue", sender: self)
        //        print(areas[indexPath.row].Nombre)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartamentoProductoSegue" {
            let productoCollectionViewController = segue.destination as! ProductoCollectionViewController
            productoCollectionViewController.idDepartamento = self.idDepartamento
        }
    }

}

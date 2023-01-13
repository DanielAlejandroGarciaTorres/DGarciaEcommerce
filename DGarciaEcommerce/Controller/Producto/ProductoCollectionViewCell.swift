//
//  ProductoCollectionViewCell.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 12/01/23.
//

import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var NombreProductoLabel: UILabel!
    @IBOutlet weak var PrecioProductoLabel: UILabel!
    @IBOutlet weak var imagenProducto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func Action(_ sender: UIButton) {
        print("Soy la celda")
    }
}

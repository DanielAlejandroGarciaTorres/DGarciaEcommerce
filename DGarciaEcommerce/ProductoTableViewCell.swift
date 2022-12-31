//
//  ProductoTableViewCell.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 29/12/22.
//

import UIKit

class ProductoTableViewCell: UITableViewCell {

    @IBOutlet weak var NombreProducto: UILabel!
    @IBOutlet weak var PrecioProducto: UILabel!
    @IBOutlet weak var StockProducto: UILabel!
    @IBOutlet weak var ProveedorProducto: UILabel!
    @IBOutlet weak var ImagenProducto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

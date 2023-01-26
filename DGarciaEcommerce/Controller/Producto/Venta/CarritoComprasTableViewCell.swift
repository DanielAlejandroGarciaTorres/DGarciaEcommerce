//
//  CarritoComprasTableViewCell.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 25/01/23.
//

import UIKit
import SwipeCellKit

class CarritoComprasTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuntity: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  DepartamentoTableViewCell.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 04/01/23.
//

import UIKit
import SwipeCellKit

class DepartamentoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var NombreDepartamento: UILabel!
    @IBOutlet weak var Area: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

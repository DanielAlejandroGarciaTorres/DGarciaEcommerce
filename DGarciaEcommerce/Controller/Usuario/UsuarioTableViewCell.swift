//
//  UsuarioTableViewCell.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 05/01/23.
//

import UIKit
import SwipeCellKit

class UsuarioTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Correo: UILabel!
    @IBOutlet weak var FechaNacimiento: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  StripeController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 29/03/23.
//

import UIKit
import StripeApplePay

class StripeController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        StripeAPI.defaultPublishableKey = "pk_test_51Mr3hFHNowIaoD42VPkhiiZp7YvjXpTBJ9OcqbN4bI8Lhk0Z0VqNe2q555yGP0EBfjQePyBznvurGLP2EBSDY6nz00hFumBU68"
        
        
        
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

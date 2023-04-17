//
//  PDFPreviewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 28/03/23.
//

import UIKit
import PDFKit

class PDFPreviewController: UIViewController {

    public var documentData : Data?
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var sharedButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = documentData {
            pdfView.translatesAutoresizingMaskIntoConstraints = false
            
            pdfView.autoScales = true
            pdfView.pageBreakMargins = UIEdgeInsets.init(top: 20, left: 8, bottom: 32, right: 8)
            pdfView.document = PDFDocument(data: data)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Share(_ sender: Any) {
        
        if let dt = documentData {
            let vc = UIActivityViewController(activityItems: [dt], applicationActivities: [])
            if UIDevice.current.userInterfaceIdiom == .pad {
                vc.popoverPresentationController?.barButtonItem = sharedButton
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        
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

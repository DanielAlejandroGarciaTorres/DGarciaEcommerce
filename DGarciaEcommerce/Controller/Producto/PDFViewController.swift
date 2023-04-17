//
//  PDFViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 29/03/23.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    
    @IBOutlet weak var pdfViewer: PDFView!
    
    
    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LoadData()
        pdfViewer.translatesAutoresizingMaskIntoConstraints = false
        
        pdfViewer.autoScales = true
        pdfViewer.pageBreakMargins = UIEdgeInsets.init(top: 20, left: 8, bottom: 32, right: 8)
        pdfViewer.document = PDFDocument(data: generatePdfData())
        // Do any additional setup after loading the view.
        
    }
    
    
    func generatePdfData() -> Data {


        let format = UIGraphicsPDFRendererFormat()
        
        let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8) //página de tamaño A4
        let graphicRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = graphicRenderer.pdfData { context in
            context.beginPage() // inicia una nueva página para el PDF
            
            let initialCursor : CGFloat = 32 //Indicamos donde comenara el cursor
            
            var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: "Productos", cursor: initialCursor, pdfSize: pageRect.size)
            
            for producto in productos {
                cursor  = context.addSingleLineText(fontSize: 14, weight: .bold, text: producto.Nombre, indent: 74, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)
                
                cursor += 10
                
                cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "\(producto.Descripcion == nil ? "Sin descripción" : producto.Descripcion!)", indent: 74, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: nil)
                
                
                
            }
        }
        
        return data
        
    }
    

    func LoadData() {
        let result = productoViewModel.GetAll()
        
        if result.Correct {
            productos = result.Objects! as! [Producto]
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
    @IBAction func Share(_ sender: Any) {
        
    }
    
}

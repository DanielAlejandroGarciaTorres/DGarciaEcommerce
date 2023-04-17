//
//  PDFController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 28/03/23.
//

import UIKit
import PDFKit

class PDFController: UIViewController {

    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var pdfData : Data?
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadData()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate PDF", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(generatePDF), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50)
        ])
        
        // Do any additional setup after loading the view.
    }
    
    func LoadData() {
        let result = productoViewModel.GetAll()
        if result.Correct {
            productos = result.Objects! as! [Producto]
        }
    }
    
    @objc func generatePDF() {
        DispatchQueue.main.async { [self] in
            let pdfData = generatePdfData(productos: productos)
            self.pdfData = pdfData
            self.performSegue(withIdentifier: "pdfViewer", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pdfPreviewer = segue.destination as? PDFPreviewController {
            pdfPreviewer.documentData = pdfData
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
    
    func generatePdfData(productos : [Producto]) -> Data {
//        let pdfMetaData = [
//            kCGPDFContextCreator: "Dgis01",
//            kCGPDFContextAuthor: "Digis",
//            kCGPDFContextTitle: "Productos"
//        ]
        
        let format = UIGraphicsPDFRendererFormat()
//        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8) // Page size is set to A4
        let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format) // Renderer that allows us to configure context
        
        let data = graphicsRenderer.pdfData { (context) in
            context.beginPage() // start a new page for the PDF
            
            let initialCursor: CGFloat = 32 // cursor is used to track the max y coordinate of our PDF to know where to append new text
            
            // Adding a title
            var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: "💻 Produtos e commerce 💻", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor+=42
            
            for producto in productos {
                cursor = generateProductText(producto: producto, context: context, cursorY: cursor, pdfSize: pageRect.size)
            }
        }
        return data
    }
    
    func generateProductText(producto: Producto, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text: producto.Nombre, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: .underline, annotationColor: .black)
        cursor += 6
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "\(producto.Descripcion ?? "Sin descripción")", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor = addProductDetails(producto: producto, context: context, cursorY: cursor, pdfSize: pdfSize)
        
        cursor+=8
        
        return cursor
    }

    func addProductDetails(producto: Producto, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Precio unitario: \(producto.PrecioUnitario)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Stock: \(producto.Stock)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Proveedor: \(producto.Proveedor.Nombre)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Departamento: \(producto.Departamento.Nombre)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Area: \(producto.Departamento.Area.Nombre)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Departamento: \(producto.Departamento.Nombre)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor += 2
        
        cursor += 8
        
        return cursor
    }
}
//
//extension UIGraphicsPDFRendererContext {
//
//    // 1
//    func addCenteredText(fontSize: CGFloat,
//                         weight: UIFont.Weight,
//                         text: String,
//                         cursor: CGFloat,
//                         pdfSize: CGSize) -> CGFloat {
//
//        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
//        let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: textFont])
//
//        let rect = CGRect(x: pdfSize.width/2 - pdfText.size().width/2, y: cursor, width: pdfText.size().width, height: pdfText.size().height)
//        pdfText.draw(in: rect)
//
//        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
//    }
//
//    // 2
//    func addSingleLineText(fontSize: CGFloat,
//                           weight: UIFont.Weight,
//                           text: String,
//                           indent: CGFloat,
//                           cursor: CGFloat,
//                           pdfSize: CGSize,
//                           annotation: PDFAnnotationSubtype?,
//                           annotationColor: UIColor?) -> CGFloat {
//
//        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
//        let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: textFont])
//
//        let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfText.size().height)
//        pdfText.draw(in: rect)
//
//        if let annotation = annotation {
//            let annotation = PDFAnnotation(
//                bounds: CGRect.init(x: indent, y: rect.origin.y + rect.size.height, width: pdfText.size().width, height: 10),
//                forType: annotation,
//                withProperties: nil)
//            annotation.color = annotationColor ?? .black
//            annotation.draw(with: PDFDisplayBox.artBox, in: self.cgContext)
//        }
//
//        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
//    }
//
//    // 3
//    func addMultiLineText(fontSize: CGFloat,
//                          weight: UIFont.Weight,
//                          text: String,
//                          indent: CGFloat,
//                          cursor: CGFloat,
//                          pdfSize: CGSize) -> CGFloat {
//
//        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .natural
//        paragraphStyle.lineBreakMode = .byWordWrapping
//
//        let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: textFont])
//        let pdfTextHeight = pdfText.height(withConstrainedWidth: pdfSize.width - 2*indent)
//
//        let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfTextHeight)
//        pdfText.draw(in: rect)
//
//        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
//    }
//
//    // 4
//    func checkContext(cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
//        if cursor > pdfSize.height - 100 {
//            self.beginPage()
//            return 40
//        }
//        return cursor
//    }
//}
//
//extension NSAttributedString {
//
//    // 5
//    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//
//        return ceil(boundingBox.height)
//    }
//}

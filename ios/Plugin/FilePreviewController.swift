import Foundation
import UIKit
import PDFKit

@objc public class FilePreviewController: UIViewController {
    
    var url: URL?
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // ...
        
        let myButton = UIButton(type: .close)
        
        // Position Button
        myButton.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        
        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)
        
        // Fit content in PDFView.
        pdfView.autoScales = true
        
        // Load Sample.pdf file from app bundle.
        // let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf")
        pdfView.document = PDFDocument(url: url!)
        
        self.view.addSubview(myButton)
        
        myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        

    }
    
    @objc func buttonAction(_ sender:UIButton!) {
        self.dismiss(animated: true)
    }
    

}

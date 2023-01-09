import Foundation
import UIKit
import PDFKit
import SwiftUI

@objc public class FilePreviewController: UIViewController {
    
    var url: URL?
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let myButton = UIButton(type: .close)
        // Position Button
        myButton.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        
        // Add PDFView to view controller.
//        let pdfView = PDFView(frame: self.view.bounds)
//        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.view.addSubview(pdfView)
//        pdfView.autoScales = true
//        pdfView.document = PDFDocument(url: url!)
        
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            let imageView = UIImageView(image: image!)
            self.view.addSubview(imageView)
                        
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            ])
        }catch{
            return
        }
        
        self.view.addSubview(myButton)
        myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        

    }
    
    @objc func buttonAction(_ sender:UIButton!) {
        self.dismiss(animated: true)
    }

}

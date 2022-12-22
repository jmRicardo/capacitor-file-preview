import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FilePreviewPlugin)
public class FilePreviewPlugin: CAPPlugin {
    private let implementation = FilePreview()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func openFile(_ call: CAPPluginCall) {
        // validate the URL
        guard let urlString = call.getString("path"), let url = URL(string: urlString) else {
            call.reject("Must provide a valid URL to open")
            return
        }
        Task(priority: .background) {
            do {
                let fileUrl = try await implementation.downloadFile(url)
                
                //let data = try implementation.urlToData(fileUrl)
              
                DispatchQueue.main.async {
                    var controller = FilePreviewController()
                    controller.url = fileUrl
                    self.bridge?.viewController?.present(controller, animated: true, completion: nil)
                }
                
                call.resolve([
                    "path": implementation.echo(fileUrl.description),
                    //"mimeType": implementation.echo(data.description)
                ])
            }catch{
                call.resolve([
                    "path": implementation.echo("ERROR")
                ])
            }
        }

    }
}

import PDFKit
import SwiftUI

struct PDFKitRepresentedView: UIViewRepresentable {
    typealias UIViewType = PDFView
    
    let data: Data
    let singlePage: Bool
    
    init(_ data: Data, singlePage: Bool = false) {
        self.data = data
        self.singlePage = singlePage
    }
    
    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }
    
    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
        pdfView.document = PDFDocument(data: data)
    }
}

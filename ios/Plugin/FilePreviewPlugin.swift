import Foundation
import Capacitor
import SwiftUI

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
        Task {
            do {
                let fileUrl = try await implementation.downloadFile(url)
                
                //let data = try implementation.urlToData(fileUrl)
              
                DispatchQueue.main.async {
                    // var controller = FilePreviewController()
                    // controller.url = fileUrl
                    // self.bridge?.viewController?.present(controller, animated: true, completion: nil)
                    
                    let swiftUIViewController = UIHostingController(rootView: PreView(url: url, dismissAction: self.dismissAction))
                    self.bridge?.viewController?.present(swiftUIViewController, animated: true)
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
    
    @objc func dismissAction() {
        self.bridge?.viewController?.dismiss(animated: true)
    }
}


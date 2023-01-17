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
  
    @objc func openFile(_ call: CAPPluginCall) {
        
        // validate the URL
        guard let urlString = call.getString("path"), let url = URL(string: urlString) else {
            call.reject("Must provide a valid URL to open")
            return
        }
        
        Task {
            do {
                DispatchQueue.main.async {
                    let swiftUIViewController = UIHostingController(rootView: PreviewWithPDFKit(url: url, dismissAction: self.dismissAction))
                    self.bridge?.viewController?.present(swiftUIViewController, animated: true)
                }
                call.resolve([
                    "path": implementation.echo(urlString.description),
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


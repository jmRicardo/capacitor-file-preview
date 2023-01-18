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
    private let validFormats = ["pdf","jpg","png","gif"]

    @objc func openFile(_ call: CAPPluginCall) {
        
        // validate the URL
        guard let urlString = call.getString("path"), let url = URL(string: urlString) else {
            call.reject("Must provide a valid URL to open")
            return
        }
        
        // validate the format
        guard validFormats.contains(url.pathExtension) else {
            call.reject("\(url.pathExtension) format not supported.")
            return
        }
        
        Task {

                DispatchQueue.main.async {
                    let swiftUIViewController = UIHostingController(rootView: PreviewWithPDFKit(url: url, dismissAction: self.dismissAction))
                    self.bridge?.viewController?.present(swiftUIViewController, animated: false)
                }
                call.resolve([
                    "path": urlString.description,
                    //"mimeType": implementation.echo(data.description)
                ])
        }

    }
    
    @objc func dismissAction() {
        self.bridge?.viewController?.dismiss(animated: true)
    }
}


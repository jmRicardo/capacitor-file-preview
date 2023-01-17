import Foundation
import PDFKit

@objc public class FilePreview: NSObject {
    
    func download(_ url: URL,completion: @escaping (_ success: Bool,_ fileLocation: URL? , _ callback : NSError?) -> Void){
        let downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            guard let fileURL = location else { return }
            do {
                let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                completion(true, savedURL,nil)
            } catch let error as NSError{
                print ("file error: \(error)")
                completion(false, nil , error)
            }
        });
        downloadTask.resume();
    }
    
    @objc public func downloadFile(_ url: URL) async throws -> URL{
        var previewFile: URL?
        if #available(iOS 15.0, *) {
            let urlRequest = URLRequest(url: url)
            let (urlResponse,_) = try await URLSession.shared.download(for: urlRequest)
            previewFile = urlResponse
        } else {
            download(url, completion: {(success, fileLocationURL, callback) in
                if success {
                    guard let fileURL = fileLocationURL else { return }
                    previewFile = fileURL
                }else{
                    
                }
            })
        }
        return previewFile!

    }
    
    @objc public func urlToData(_ url: URL) throws -> Data {
        return try Data(contentsOf: url)
    }
    
    @objc public func pdfToImage(url: URL) -> UIImage {
        
        // Instantiate a `CGPDFDocument` from the PDF file's URL.
        guard let document = PDFDocument(url: url) else { return UIImage()}
        
        // Get the first page of the PDF document.
        guard let page = document.page(at: 0) else { return UIImage()}
        
        // Fetch the page rect for the page we want to render.
        let pageRect = page.bounds(for: .mediaBox)
        
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            // Set and fill the background color.
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))
            
            // Translate the context so that we only draw the `cropRect`.
            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)
            
            // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            // Draw the PDF page.
            page.draw(with: .mediaBox, to: ctx.cgContext)
        }
        
        return img
    }
    

}

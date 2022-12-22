import Foundation

@objc public class FilePreview: NSObject {

    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
      
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
    

}

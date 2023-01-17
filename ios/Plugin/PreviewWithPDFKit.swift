import SwiftUI

struct PreviewWithPDFKit: View {
    @Environment(\.dismiss) private var dismiss
    @State private var presented = true
    @State var url: URL?
    @State var image: UIImage?
    @State private var scale: CGFloat = 1
    var dismissAction: ()->Void
    func isPDF() -> Bool {
        return false
    }
    var body: some View {
        VStack {
        }
        .fullScreenCover(isPresented: $presented) {
            NavigationView {
                HStack {
                    if let urlPDF = url {
                        if (urlPDF.pathExtension == "pdf") {
                           PDFKitRepresentedView(urlPDF)
                                // .zoomable(scale: $scale)
                        }else {
                            ImagePreview(url: urlPDF)
                                .zoomable(scale: $scale)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Aceptar") {
                            presented.toggle()
                            dismissAction()
                        }
                    }
                }
            }
        }
    }
}

struct PreviewWithPDFKit_Previews: PreviewProvider {
    
    var pdf = URL(string:"https://devdocs.blob.core.windows.net/alegramed-desa-documents/consultas/1012/recetas/receta_10000000325.pdf")
    
    var png = URL(string: "https://devdocs.blob.core.windows.net/alegramed-desa-documents/1_9IqfzMRjG5hVp48REfvMRw.png")
    
    static var previews: some View {
        PreView(url: URL(string:"https://devdocs.blob.core.windows.net/alegramed-desa-documents/1_9IqfzMRjG5hVp48REfvMRw.png"), dismissAction: {})
    }
}




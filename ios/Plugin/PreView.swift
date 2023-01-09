//
//  PreView.swift
//  Plugin
//
//  Created by juan manuel ricardo on 26/12/2022.
//  Copyright © 2022 Max Lynch. All rights reserved.
//

import SwiftUI

struct PreView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var presented = true
    @State var url: URL?
    @State var image: UIImage?
    @State private var scale: CGFloat = 1
    var dismissAction: ()->Void
    func isPDF() -> Bool {
        // complex condition goes here, like "if let" or "switch"
        return false
    }
    var body: some View {
        VStack {
        }
        .fullScreenCover(isPresented: $presented) {
            NavigationView {
                HStack {
                    if let imageSrc = image {
                        Image(uiImage: imageSrc)
                            .resizable()
                            .scaledToFit()
                            .zoomable(scale: $scale)
                    } else {
                        ImagePreview(url: url)
                    }
                }
                // padding()
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
        .onAppear() {
            Task {
                if let urlPDF = url {
                    if (urlPDF.description.contains(".pdf")) {
                        let file = try await FilePreview().downloadFile(urlPDF)
                        image = FilePreview().pdfToImage(url: file)
                    }
                }
            }
        }
    }
}

struct PreView_Previews: PreviewProvider {
    
    var pdf = URL(string:"https://devdocs.blob.core.windows.net/alegramed-desa-documents/consultas/1012/recetas/receta_10000000325.pdf")
                  
    var png = URL(string: "https://devdocs.blob.core.windows.net/alegramed-desa-documents/1_9IqfzMRjG5hVp48REfvMRw.png")
    
    static var previews: some View {
        PreView(url: URL(string:"https://devdocs.blob.core.windows.net/alegramed-desa-documents/consultas/1012/recetas/receta_10000000325.pdf"), dismissAction: {})
    }
}



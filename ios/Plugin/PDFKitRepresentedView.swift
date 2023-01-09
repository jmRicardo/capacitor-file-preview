//
//  PDFView.swift
//  Plugin
//
//  Created by juan manuel ricardo on 26/12/2022.
//  Copyright © 2022 Max Lynch. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    func updateUIView(_ uiView: PDFView, context: Context) {
        //
    }
    
    typealias UIViewType = PDFView
    
    let url: URL
    let singlePage: Bool
    
    init(_ url: URL, singlePage: Bool = true) {
        self.url = url
        self.singlePage = singlePage
    }
    
    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }
}

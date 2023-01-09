//
//  ImagePreview.swift
//  Plugin
//
//  Created by juan manuel ricardo on 26/12/2022.
//  Copyright © 2022 Max Lynch. All rights reserved.
//

import SwiftUI

struct ImagePreview: View {
    var url: URL?
    var body: some View {
        VStack(alignment: .center){
            AsyncImage(url: url) { image in
                image.scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .padding()
        }
        
    }
}

struct ImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreview(url: URL(string: "https://devdocs.blob.core.windows.net/alegramed-desa-documents/1_9IqfzMRjG5hVp48REfvMRw.png")!)
    }
}

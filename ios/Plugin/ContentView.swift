//
//  ContentView.swift
//  test
//
//  Created by juan manuel ricardo on 23/12/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var presented = true
    var url: URL?
    var dismissAction: ()->Void
    var body: some View {
            VStack {
            }
            .fullScreenCover(isPresented: $presented) {
                NavigationView {
                    VStack {
                        AsyncImage(url: url) { image in
                            image.resizable(resizingMode: .stretch)
                            image.scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .padding()
                    }
                .padding()
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(url: URL(string: "https://devdocs.blob.core.windows.net/alegramed-desa-documents/1_9IqfzMRjG5hVp48REfvMRw.png"), dismissAction: {})
    }
}

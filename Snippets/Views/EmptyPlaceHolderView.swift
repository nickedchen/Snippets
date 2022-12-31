//
//  EmptyPlaceHolderView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

struct EmptyPlaceHolderView: View {
    let text: String
    let image: Image?

    var body: some View {
        VStack {
            Spacer()
            if let image = self.image {
                image
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 50))

            }
            Text(text)
                .font(.system(size: 20))
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct EmptyPlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceHolderView(text: "No Articles", image: Image(systemName: "newspaper"))
    }
}

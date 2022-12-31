//
//  RetryView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

struct RetryView: View {
    let text: String
    let retryAction: () -> Void
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.title)
                .foregroundColor(.secondary)
            Button(action: retryAction) {
                Text("Reload")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "No Articles") {
        }
    }
}

//
//  SafariView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL


    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url,entersReaderIfAvailable: true)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

//
//  SnippetsApp.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-29.
//

import SwiftUI

@main
struct SnippetsApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}

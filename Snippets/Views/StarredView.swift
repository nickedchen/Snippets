//
//  StarredView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

struct StarredView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    @State private var searchText = ""

    var body: some View {
        let articles = self.articles
        NavigationStack {
            ArticleListView(article: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Starred")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search starred articles")
    }

    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkVM.bookmarks
        } else {
            return articleBookmarkVM.bookmarks.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                    $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
        }
    }

    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceHolderView(text: "No starred article", image: Image(systemName: "star.square.fill"))
        }
    }
}

struct StarredView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared

    static var previews: some View {
        StarredView()
            .environmentObject(articleBookmarkVM)
    }
}

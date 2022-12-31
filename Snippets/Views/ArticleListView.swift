//
//  ArticleListView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import BetterSafariView
import SwiftUI

struct ArticleListView: View {
    let article: [Article]
    @State private var selectedArticle: Article?
    @State private var presentingSafariView = false

    var body: some View {
        List {
            ForEach(article) { article in

                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .sheet(item: $selectedArticle) { article in
            SafariView(url: article.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared

    static var previews: some View {
        NavigationStack {
            ArticleListView(article: Article.previewData)
                .environmentObject(articleBookmarkVM)
                .navigationTitle("Headlines")
        }
    }
}

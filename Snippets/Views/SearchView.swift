//
//  SearchView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-31.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = ArticleSearchViewModel.shared

    var body: some View {
        NavigationStack {
            ArticleListView(article: articles)
                .overlay(overlayView)
                .navigationTitle("Search")
                .searchable(text: $searchVM.searchQuery, placement: .navigationBarDrawer, prompt: "Search for articles")
                .onChange(of: searchVM.searchQuery) { newValue in
                    if newValue.isEmpty {
                        searchVM.phase = .empty
                    }
                }
                .onSubmit(of: .search, search)
        }
    }

    private var articles: [Article] {
        if case let .success(articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }

    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if searchVM.searchQuery.isEmpty {
                EmptyPlaceHolderView(text: "Search to browse articles", image: Image(systemName: "magnifyingglass.circle.fill"))
            } else if !searchVM.history.isEmpty {
                HistoryView(searchVM: searchVM) { newValue in
                    // Need to be handled manually as it doesn't trigger default onSubmit modifier
                    searchVM.searchQuery = newValue
                    search()
                }
            } else {
                ProgressView()
            }
        case let .success(articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No articles found ", image: Image(systemName: "newspaper"))
        case let .failure(error):
            RetryView(text: error.localizedDescription, retryAction: search)
        default:
            EmptyView()
        }
    }

    @ViewBuilder
    private func suggestionsView() -> some View {
        ForEach(["Swift", "Covid-19"], id: \.self) { suggestion in
            Button {
                searchVM.searchQuery = suggestion
            } label: {
                Text(suggestion)
            }
        }
    }

    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }

        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared

    static var previews: some View {
        SearchView()
            .environmentObject(bookmarkVM)
    }
}

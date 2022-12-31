//
//  ArticleBookmarkViewModel.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks = [Article]()
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmarks")

    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task {
            await loadBookmarks()
        }
    }

    private func loadBookmarks() async {
        bookmarks = await bookmarkStore.load() ?? []
    }

    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first(where: { $0.id == article.id }) != nil
    }

    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else { return }
        bookmarks.insert(article, at: 0)
    }

    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }

    private func bookmarkUpdated() {
        let bookmark = bookmarks
        Task {
            await bookmarkStore.save(bookmark)
        }
    }
}

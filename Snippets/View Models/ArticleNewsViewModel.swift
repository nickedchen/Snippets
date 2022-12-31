//
//  ArticleNewsViewModel.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = NewsAPI.shared

    init(article: [Article]? = nil, selectedCategory: Category = .general) {
        if let article = article {
            phase = .success(article)
        } else {
            phase = .empty
        }
        fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }

    func loadArticles() async {
//        phase = .success(Article.previewData)
        if Task.isCancelled {
            return
        }
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled {
                return
            }

            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}

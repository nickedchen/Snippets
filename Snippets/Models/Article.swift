//
//  Article.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-29.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    let source: Source
    let author: String?
    let description: String?
    let title: String
    let url: String
    let publishedAt: Date
    let content: String?
    let urlToImage: String?

    var authorText: String {
        author ?? ""
    }

    var descriptionText: String {
        description ?? ""
    }

    var captionText: String {
        "\(source.name) - \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }

    var articleURL: URL {
        URL(string: url)!
    }

    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {
    var id: String {
        url
    }
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "News", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let apiResponse = try!
            decoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

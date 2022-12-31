//
//  NewsAPIResponse.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]

    let code: String?
    let message: String?
}

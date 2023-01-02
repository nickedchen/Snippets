//
//  Category.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology

    var text: String {
        if self == .general {
            return "Headlines"
        }
        return rawValue.capitalized
    }
}

extension Category: Identifiable {
    var id: Self { self }
}

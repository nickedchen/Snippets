//
//  HistoryView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-31.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var searchVM: ArticleSearchViewModel
    let onSubmit: (String) -> Void

    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button("Clear") {
                    searchVM.clearHistory()
                }
                .foregroundColor(.accentColor)
            }
            .listRowSeparator(.hidden)

            ForEach(searchVM.history, id: \.self) { history in
                Button(history) {
                    onSubmit(history)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        searchVM.removeHistory(history)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(searchVM: ArticleSearchViewModel.shared) { _ in
        }
    }
}

//
//  ArticleRowView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

struct ArticleRowView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel

    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) {
                phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case let .success(image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .clipped()
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Spacer()

                    Button(action: {
                        toggleBookmark(article)
                    }, label: {
                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "star.fill" : "star")
                    })
                    .buttonStyle(.bordered)

                    Button(action: {
                        presentShareSheet(url: article.articleURL)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                    })
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
    }

    private func toggleBookmark(_ article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
}

extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController?.present(activityVC, animated: true)
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared

    static var previews: some View {
        NavigationStack {
            List {
                ArticleRowView(article: Article.previewData[0])
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookmarkVM)
    }
}

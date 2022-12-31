//
//  SnippetsView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-30.
//

import SwiftUI

struct SnippetsView: View {

    @StateObject var articleNewsVM = ArticleNewsViewModel()

    var body: some View {
        NavigationStack{
            ArticleListView(article: articles)
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        menu
                    }
                }
        }
        
    }
    @ ViewBuilder
    private var overlayView: some View{

        switch articleNewsVM.phase{
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No Articles", image: Image(systemName: "newspaper"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article]{
        switch articleNewsVM.phase{
        case .empty:
            return []
        case .success(let articles):
            return articles
        case .failure:
            return []
        }
    }

    @Sendable
    private func loadTask() async{
            await articleNewsVM.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }

    private var menu: some View{
        Menu{
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category){
                ForEach(Category.allCases){ category in
                    Text(category.text).tag(category)
                }
            }
        }label: {
            Image(systemName: "ellipsis.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.accentColor)
        }
    }
}


struct SnippetsView_Previews: PreviewProvider {

     @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared

    static var previews: some View {
        SnippetsView(articleNewsVM: ArticleNewsViewModel(article: Article.previewData))
            .environmentObject(articleBookmarkVM)
    }
}

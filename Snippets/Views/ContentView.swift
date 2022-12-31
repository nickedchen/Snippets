//
//  ContentView.swift
//  Snippets
//
//  Created by Nick Chen on 2022-12-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SnippetsView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Feeds")
                }
            StarredView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Starred")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

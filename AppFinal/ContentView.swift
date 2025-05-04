//
//  ContentView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var favorites: Set<Int> = []
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(favorites: $favorites)
            }
            .tabItem {
                Label("Browse", systemImage: "house")
            }

            NavigationStack {
                FavoritesView(favorites: $favorites)
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
    }
}

#Preview {
    ContentView()
}

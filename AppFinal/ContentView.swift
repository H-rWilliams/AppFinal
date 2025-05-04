//
//  ContentView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Browse", systemImage: "house")
            }

            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}

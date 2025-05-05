//
//  ContentView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct ContentView: View {
//    StateObject is like @State, but for reference types. It's ideal for shared data across views.
//    This line creates and owns a single instance of AppState. This var is tied to the lifecycle of ContentView
    @StateObject var appState = AppState()
    
    var body: some View {
//        TabView creates tabs for different views
        TabView {
//            NavigationStack allows us to navigate between views
            NavigationStack {
                HomeView()
            }
//            tabItem creates labels and icons for each tab
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
//        environmentObject is important to share data between views
//        environmentObject injects appState into the SwiftUI environment, making it accessible to any child view that declares @EnvironmentObject var appState: AppState
//        This allows us to manipulate favorited images throughout multiple different views
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}

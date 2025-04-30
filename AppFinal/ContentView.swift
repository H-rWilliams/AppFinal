//
//  ContentView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
//            Home View, initial call
//            Display basic info, include a button to favorite
            NavigationStack {
                
                
                VStack {
                    
                }
                
            }
            
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
//            Detail view, inspect specific element
            NavigationStack {
//                Pass values for an API req, return new view with response
//                Picture, label, stats, bio, etc.
                DetailView()
            }
            
            .tabItem {
                Label("Detailed", systemImage:"magnifyingglass")
            }
            
//            Favorites, view a collection and nav to Detailed
            NavigationStack {
//                Pass/View collection of favorited items
//                Picture and Label
//                Nav to detailview based on clicked favorite
                Favorites()
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

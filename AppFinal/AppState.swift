//
//  AppState.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import Foundation

// ObservableObject marks this class as being able to be observed by SwiftUI views
class AppState: ObservableObject {
//    Anything marked with @Published triggers a flag
//    When changes are made to @Published variables, any SwiftUI updates any views using it
//    In this instance, we are publishing a list which will hold favorited images
    @Published var favorites: [String] = []
}

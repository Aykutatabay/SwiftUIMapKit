//
//  SwiftUIMapKitApp.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import SwiftUI

@main
struct SwiftUIMapKitApp: App {
    @StateObject var locationSearchVM: LocationSearchViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationSearchVM)
        }
    }
}

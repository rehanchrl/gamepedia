//
//  gamepediaApp.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI

@main
struct gamepediaApp: App {
    
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}

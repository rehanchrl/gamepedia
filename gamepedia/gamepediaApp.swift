//
//  gamepediaApp.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI

@main
struct gamepediaApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                FavoriteListView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Favorite", systemImage: "heart")
                    }
            }
            
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}

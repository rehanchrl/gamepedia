//
//  gamepediaApp.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI

@main
struct gamepediaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

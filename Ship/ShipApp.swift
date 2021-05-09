//
//  ShipApp.swift
//  Ship
//
//  Created by Olivier Van hamme on 09/05/2021.
//

import SwiftUI

@main
struct ShipApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

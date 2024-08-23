//
//  Habit_TrackerApp.swift
//  Habit Tracker
//
//  Created by Moody on 2024-08-23.
//

import SwiftUI

@main
struct Habit_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

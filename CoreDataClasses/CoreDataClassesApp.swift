//
//  CoreDataClassesApp.swift
//  CoreDataClasses
//
//  Created by Jérémy Perez on 28/12/2021.
//

import SwiftUI

@main
struct CoreDataClassesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

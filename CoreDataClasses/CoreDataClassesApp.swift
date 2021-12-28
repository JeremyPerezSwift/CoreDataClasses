//
//  CoreDataClassesApp.swift
//  CoreDataClasses
//
//  Created by Jérémy Perez on 28/12/2021.
//

import SwiftUI

@main
struct CoreDataClassesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}

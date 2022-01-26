//
//  final_projectApp.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import SwiftUI

@main
struct final_projectApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

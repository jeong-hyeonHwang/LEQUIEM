//
//  SqupieceApp.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

@main
struct SqupieceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

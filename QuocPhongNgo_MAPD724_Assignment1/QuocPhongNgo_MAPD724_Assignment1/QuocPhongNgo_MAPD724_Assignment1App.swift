//
//  QuocPhongNgo_MAPD724_Assignment1App.swift
//  QuocPhongNgo_MAPD724_Assignment1
//
//  Created by Phong on 17/01/2022.
//

import SwiftUI

@main
struct QuocPhongNgo_MAPD724_Assignment1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

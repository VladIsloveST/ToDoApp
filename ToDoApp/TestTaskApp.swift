//
//  TestTaskApp.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI


@main
struct TestTaskApp: App {
    // MARK: - Private Properties
    @StateObject private var networkManager = NetworkManager()
    @StateObject private var realmManager = RealmManager()
    @StateObject private var coordinator = AppCoordinator()
    
    //MARK: - Body Scene
    var body: some Scene {
        WindowGroup {
            TabView {
                StackView(realmManager: realmManager)
                    .environmentObject(coordinator)
                    .tabItem {
                        Image(systemName: "doc.plaintext")
                        Text("List")
                    }
                SourceView(networkManager: networkManager)
                    .tabItem {
                        Image(systemName: "archivebox")
                        Text("Source")
                    }
            }
        }
    }
}

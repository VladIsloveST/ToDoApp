//
//  ContainerView.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI

struct StackView: View {
    // MARK: - Public Properties
    @EnvironmentObject private var coordinator: AppCoordinator
    private var realmManager: RealmManagerProtocol
    
    // MARK: - Initialization
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    //MARK: - UI Content
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildScreen(.list, realmManager: realmManager)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.buildScreen(screen, realmManager: realmManager)
                }
        }
    }
}

#Preview {
    StackView(realmManager: RealmManager())
}

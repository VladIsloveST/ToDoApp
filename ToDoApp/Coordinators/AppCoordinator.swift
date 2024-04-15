//
//  Coordinator.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI

enum Screen: Hashable, Equatable {
    case list
    case task(detail: ToDoModel?)
}

class AppCoordinator: ObservableObject {
    // MARK: - Properties
    @Published var path = NavigationPath()
    
    // MARK: - Methods
    func push(screen: Screen) {
        path.append(screen)
    }
    
    func popToRoot() {
        path.removeLast()
    }
    
    @ViewBuilder
    func buildScreen(_ screen: Screen, realmManager: RealmManagerProtocol) -> some View {
        switch screen {
        case .list:
            ListView(realmManager: realmManager)
        case .task(let detail):
            TaskView(realmManager: realmManager, task: detail)
        }
    }
}

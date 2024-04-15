//
//  ListViewModel.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import Foundation
import RealmSwift

class ListViewModel: ObservableObject {
    // MARK: - Properties
    @Published var tasks = List<ToDoModel>()
    private let realmManager: RealmManagerProtocol
    
    // MARK: - Initialization
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
        realmManager.observeChanges(ToDoModel.self) {
            self.fetchTasks()
        }
    }
    
    // MARK: - Methods
    func fetchTasks() {
        tasks = realmManager.read(ToDoModel.self)
    }
    
    func removeTask(_ indexSet: IndexSet) {
        guard let index = indexSet.first, !tasks[index].isInvalidated else { return }
        let task = tasks[index]
        realmManager.delete(task)
    }
    
    func toggleCompleted(for task: ToDoModel) {
        realmManager.update(task, with: ["isReady" : !task.isReady])
        fetchTasks()
    }
}


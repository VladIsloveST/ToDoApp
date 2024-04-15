//
//  TaskViewModel.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import Foundation

class TaskListViewModel: ObservableObject {
    // MARK: - Properties
    private let realmManager: RealmManagerProtocol
    
    // MARK: - Initialization
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    // MARK: - Methods
    func createTask(title: String, explanation: String) {
        let task = ToDoModel()
        task.title = title
        task.explanation = explanation
        realmManager.create(task, with: task.title, ToDoModel.self)
    }
    
    func update(_ task: ToDoModel?, with title: String, _ explanation: String) {
        guard let existingTask = task else { return }
        realmManager.update(existingTask, with: ["title" : title])
        realmManager.update(existingTask, with: ["explanation" : explanation])
    }
}

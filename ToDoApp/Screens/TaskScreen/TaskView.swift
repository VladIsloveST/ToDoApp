//
//  DetailView.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI
import RealmSwift

struct TaskView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel: TaskListViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var title: String = ""
    @State private var explanation: String = ""
    private var task: ToDoModel?
    
    // MARK: - Initialization
    init(realmManager: RealmManagerProtocol, task: ToDoModel?) {
        _viewModel = StateObject(wrappedValue: TaskListViewModel(realmManager: realmManager) )
        self.task = task
    }
    
    //MARK: - UI Content
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Task", text: $title)
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(Color("GRAY"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Description")
                .font(.system(size: 14, weight: .black))
                .padding(.top, 25)
                .padding(.leading, 25)
            
            HStack {
                TextEditor(text: $explanation)
                    .frame(height: 90)
                    .colorMultiply(Color("GRAY"))
            }.padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(Color("GRAY"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            Button(action: {
                action()
            }) {
                Text("Save")
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.navigationBarBackButtonHidden(true)
            .padding(.vertical, 25)
            .padding(.horizontal, 15)
            .onAppear {
                guard let existingTask = task else { return }
                title = existingTask.title
                explanation = existingTask.explanation
            }
    }
    
    // MARK: - Private Methods
    private func action() {
        task != nil ? viewModel.update(task, with: title, explanation) :
        viewModel.createTask(title: title, explanation: explanation)
        coordinator.popToRoot()
    }
}

#Preview {
    TaskView(realmManager: RealmManager(), task: ToDoModel())
}

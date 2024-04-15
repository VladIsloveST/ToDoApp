//
//  ListRow.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import SwiftUI

struct ListRow: View {
    // MARK: -  Properties
    private var task: ToDoModel
    @EnvironmentObject private var viewModel: ListViewModel
    
    // MARK: - Initialization
    init(task: ToDoModel) {
        self.task = task
    }
    
    //MARK: - UI Content
    var body: some View {
        if task.isInvalidated == false {
            HStack {
                Text(task.title)
                    .strikethrough(task.isReady)
                    .font(.headline)
                    .fontWeight(.medium)
                Spacer()
                Button(action: {
                    viewModel.toggleCompleted(for: task)
                }) {
                    Image(systemName: task.isReady ? "checkmark.square.fill" : "square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }.buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    ListRow(task: ToDoModel() )
}


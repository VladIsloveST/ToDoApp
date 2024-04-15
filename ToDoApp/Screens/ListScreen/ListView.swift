//
//  ContentView.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    // MARK: - Properties
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: ListViewModel
    private let emptyTasks = "Сurrently no tasks..."
    
    // MARK: - Initialization
    init(realmManager: RealmManagerProtocol) {
        _viewModel = StateObject(wrappedValue: ListViewModel(realmManager: realmManager) )
    }
    
    //MARK: - UI Content
    var body: some View {
        NavigationStack {
            VStack {
                viewModel.tasks.isEmpty ? AnyView(Text(emptyTasks)) : AnyView(createList())
            }.navigationTitle("List")
                .toolbar { createNavBarItem() }
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    // MARK: - Private Methods
    private func createList() -> some View {
        List {
            ForEach(viewModel.tasks, id: \.id) { task in
                ListRow(task: task)
                    .environmentObject(viewModel)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.push(screen: .task(detail: task))
                    }
            }.onDelete { indexSet in
                viewModel.removeTask(indexSet)
            }
        }
    }
    
    private func createNavBarItem() -> some View {
        Button(action: {
            coordinator.push(screen: .task(detail: nil))
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    ListView(realmManager: RealmManager())
}

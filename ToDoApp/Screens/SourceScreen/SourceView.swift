//
//  SourceView.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI

struct SourceView: View {
    // MARK: - Properties
    @StateObject private var viewModel: SourceViewModel
    
    // MARK: - Initialization
    init(networkManager: NetworkProtocol) {
        _viewModel = StateObject(wrappedValue: SourceViewModel(networkManager: networkManager) )
    }
    
    //MARK: - UI Content
    var body: some View {
        NavigationStack {
            VStack {
                viewModel.isLoading ? AnyView(createList()) : AnyView(ProgressView("Loading..."))
            }.navigationTitle("Apple News")
        }.onAppear {
            viewModel.fetchArticles()
        }.refreshable {
            viewModel.refresh()
        }.alert(isPresented: $viewModel.showAlert, message: viewModel.alertMessage)
    }
    
    // MARK: - Private Methods
    private func createList() -> some View {
        List() {
            ForEach(viewModel.articles, id: \.self) { article in
                ArticleRow(article: article)
                    .alignmentGuide(.listRowSeparatorLeading) { dimension in
                        dimension[.leading]
                           }
                    .onAppear {
                        guard article == viewModel.articles.last else { return }
                        viewModel.prefetch()
                    }
            }
        }
    }
}

#Preview {
    SourceView(networkManager: NetworkManager())
}

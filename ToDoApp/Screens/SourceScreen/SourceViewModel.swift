//
//  SourceViewViewModel.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import Foundation

class SourceViewModel: ObservableObject {
    // MARK: - Properties
    @Published var articles: [ArticleData] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage: String?
    private let networkManager: NetworkProtocol
    private var page: Int
    
    // MARK: - Initialization
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        self.page = 1
    }
    
    // MARK: - Methods
   func fetchArticles() {
        loadArticles()
    }
    
    func refresh() {
        articles.removeAll()
        loadArticles()
    }
    
    func prefetch() {
        page += 1
        loadArticles(page: page)
    }
    
    private func loadArticles(page: Int = 1) {
        self.networkManager.fetchData(from: .wallStreet, with: page, method: .get) { result in
            self.isLoading = true
            switch result {
            case .success(let fetchedArticles):
                let filteredArticles = fetchedArticles.articles.filter { $0.title != "[Removed]" }
                self.articles.append(contentsOf: filteredArticles)
            case .failure(let networkError):
                let processedNetworkError = (networkError as? NetworkError) ?? .internetConnectionError
                self.alertMessage = processedNetworkError.rawValue
                self.showAlert = true
            }
        }
    }
}

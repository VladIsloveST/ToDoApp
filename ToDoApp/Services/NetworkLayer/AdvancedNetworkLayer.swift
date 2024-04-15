//
//  Network.swift
//  ToDoApp
//
//  Created by Mac on 13.04.2024.
//

import Foundation

enum AdvancedError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case undefinedStatusСode
}

class Network {
    private let apiKey = "977e4b83946b42a1aba422dc52cefbb1"
    private let baseURL = "https://newsapi.org"
    
    func fetchData(from path: PathArticles,
                   with page: Int) async throws -> Articles {
        
        
        var urlComponents = URLComponents(string: baseURL + path.rawValue)
        urlComponents?.queryItems = [
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "page", value: page.description),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = urlComponents?.url else {
            throw AdvancedError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = (response as? HTTPURLResponse),
              response.statusCode == 200 else {
           throw handleNetwork(response as? HTTPURLResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Articles.self, from: data)
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    private func handleNetwork(_ response: HTTPURLResponse?) -> Error {
        guard let statusCode = response?.statusCode else {
            return NetworkError.serverResponseError }
        switch statusCode {
        case 300...399:
            return NetworkError.statusCodeError
        case 400...499:
            return NetworkError.clientError
        case 500...599:
            return NetworkError.serverError
        default:
            return AdvancedError.undefinedStatusСode
        }
    }
}

//
//  ServerModel.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import Foundation

struct Articles: Codable {
    let articles: [ArticleData]
}

struct ArticleData: Codable, Hashable {
    var title: String
    let author: String?
    let url: String
    var urlToImage: String?
}

extension ArticleData: Identifiable {
    var id: UUID {
            return UUID()
        }
}

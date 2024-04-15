//
//  ArticleRow.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import SwiftUI

struct ArticleRow: View {
    // MARK: - Public Properties
    var article: ArticleData
    
    //MARK: - UI Content
    var body: some View {
        HStack {
            ArticleImageView(optionalUrl: article.urlToImage)
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.medium)
                Text(article.author ?? "author unknown")
                    .font(.custom("Arial", size: 14))
                    .foregroundColor(.gray)
            }
        }.onTapGesture {
            guard let url = URL(string: article.url) else { return }
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ArticleRow(article: ArticleData(title: "", author: "", url: ""))
}

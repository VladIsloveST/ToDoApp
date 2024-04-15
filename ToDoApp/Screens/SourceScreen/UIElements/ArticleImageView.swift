//
//  ImageView.swift
//  TestTask
//
//  Created by Mac on 29.03.2024.
//

import SwiftUI
import Kingfisher

struct ArticleImageView: View {
    // MARK: - Properties
    var optionalUrl: String?
    
    //MARK: - UI Content
    var body: some View {
        if let unwrappedUrl = optionalUrl {
            KFImage(URL(string: unwrappedUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        }
    }
}

#Preview {
    ArticleImageView(optionalUrl: "")
}

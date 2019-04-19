//
//  HeadlineDetailsViewModel.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

class HeadlineDetailsViewModel: NSObject {
    private let model: Article

    init(model: Article) {
        self.model = model
    }
}

extension HeadlineDetailsViewModel {
    var title: String {
        return model.title
    }
    
    var desc: String {
        if let desc = model.description {
            return desc
        } else { return "" }
    }
    
    var content: String {
        if let content = model.content {
            return content
        } else { return "" }
    }
    
    var publisher: String {
       return model.source.name
    }
    
    var publishedAt: String {
        let date = model.publishedAt.toDate()
        if let timeAgo = date?.timeAgoSinceDate() {
            return timeAgo
        }
        return ""
    }
    
    var imageURL: URL? {
        if let imageUrlString = model.urlToImage,
            let imageUrl = URL(string: imageUrlString) {
            return imageUrl
        }
        return nil
    }
    
    var url: URL? {
        if let url = URL(string: model.url) {
            return url
        }
        return nil
    }
    
}

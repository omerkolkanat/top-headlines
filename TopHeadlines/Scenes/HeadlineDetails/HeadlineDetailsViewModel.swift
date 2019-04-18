//
//  HeadlineDetailsViewModel.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

class HeadlineDetailsViewModel: NSObject {
    private let model: ArticleModel

    init(model: ArticleModel) {
        self.model = model
    }
    
}

extension HeadlineDetailsViewModel {
    var imageURL: URL? {
        if let imageUrl = model.urlToImage {
             return imageUrl
        }
        return nil
    }
    
    var title: String {
        if let title = model.title {
            return title
        } else { return "" }
    }
    
    var desc: String {
        if let desc = model.desc {
            return desc
        } else { return "" }
    }
    
    var content: String {
        if let content = model.content {
            return content
        } else { return "" }
    }
    
    var publisher: String {
       return "From : \(model.sourceName ?? "")"
    }
    
    var publishedAt: String {
        if let publishedDate = model.publishedAt {
            let date = publishedDate.toDate()
            if let timeAgo = date?.timeAgoSinceDate() {
                return timeAgo
            }
        }
        return ""
    }
    
    var url: URL? {
        if let url = model.url {
            return url
        } else { return nil }
    }
    
}

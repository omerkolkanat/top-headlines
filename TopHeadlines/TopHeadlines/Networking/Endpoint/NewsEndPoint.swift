//
//  MovieEndPoint.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 16.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case development
    case production
}

public enum NewsAPI {
    case topHeadlines(page: Int)
}

extension NewsAPI: EndPointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .development: return "https://newsapi.org/v2/"
        case .production: return "https://newsapi.org/v2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .topHeadlines(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["country": NetworkManager.country,
                                                      "page": page,
                                                      "pageSize": NetworkManager.pageSize,
                                                      "apiKey": NetworkManager.newsAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

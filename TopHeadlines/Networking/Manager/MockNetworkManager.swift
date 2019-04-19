//
//  MockApiClient.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 19.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

class MockNetworkManager: NetworkManager {
    enum JsonFileName: String {
        case headlineResponseCorrect = "Headlines"
        case headlineResponseEmpty = "Headlines_empty"
        case headlineResponseIncorrect = "Headlines_incorrect"
    }
    
    var jsonFileName: JsonFileName = .headlineResponseCorrect
    var isNetworkRequestCalled = false
    
    override func getTopHeadlines(page: Int, completion: @escaping (_ headline: Headline?, _ error: String?) -> Void) {
        isNetworkRequestCalled = true
        guard let jsonData = JsonFileLoader.loadJson(fileName: jsonFileName.rawValue) else {
            completion(nil, "json file loading error")
            return
        }
        let headline = try? JSONDecoder().decode(Headline.self, from: jsonData)
        completion(headline, nil)
    }
    
}

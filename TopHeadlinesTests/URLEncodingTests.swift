//
//  URLEncodingTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 19.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class URLEncodingTests: XCTestCase {

    func testURLEncoding() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
            XCTAssertTrue(false, "Could not instantiate news api url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "country": "de",
            "page": 1,
            "pageSize": 21,
            "apiKey": "e6fc195b15a34e6197e296f18eef0b4e"
        ]
        
        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            
            let expectedURL = "https://newsapi.org/v2/top-headlines?pageSize=21&apiKey=e6fc195b15a34e6197e296f18eef0b4e&page=1&country=de"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        } catch {
            
        }
    }

}

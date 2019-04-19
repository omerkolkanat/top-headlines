//
//  NetworkManagerTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 19.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class NetworkManagerTests: XCTestCase {

    var networkManager: MockNetworkManager!
    
    override func setUp() {
        networkManager = MockNetworkManager()
    }

    override func tearDown() {
        networkManager = nil
    }
    
    func testRealNetworkManager() {
        let networkManager = NetworkManager()
        networkManager.getTopHeadlines(page: 1) { (headline, error) in
            XCTAssert(error == nil, "Network request got error.")
            XCTAssert(headline != nil, "The API service doesn't response correct data back.")
            XCTAssertTrue(headline?.articles.count == 21, "The mock data has 21 initial articles.")
        }
    }
    
    func testRealNetworkManagerForPageTwo() {
        let networkManager = NetworkManager()
        networkManager.getTopHeadlines(page: 2) { (headline, error) in
            XCTAssert(error == nil, "Network request got error.")
            XCTAssert(headline != nil, "The API service doesn't response correct data back.")
        }
    }
    
    func testMockNetworkManagerWithCorrectData() {
        networkManager.jsonFileName = .headlineResponseCorrect
        networkManager.getTopHeadlines(page: 1) { (headline, error) in
            XCTAssertTrue(self.networkManager.isNetworkRequestCalled)
            XCTAssert(error == nil, "Network request got error.")
            XCTAssert(headline != nil, "The API service doesn't response correct data back.")
            XCTAssertTrue(headline?.articles.count == 21, "The mock data has 21 articles.")
        }
    }
    
    func testMockNetworkManagerWithEmptyData() {
        networkManager.jsonFileName = .headlineResponseEmpty
        networkManager.getTopHeadlines(page: 1) { (headline, error) in
            XCTAssertTrue(self.networkManager.isNetworkRequestCalled)
            XCTAssert(error != nil, "Error shouldn't be nil because response is empty")
            XCTAssert(headline == nil, "Headline should be nil because response is empty")
        }
    }
    
    func testMockNetworkManagerWithIncorrectData() {
        networkManager.jsonFileName = .headlineResponseIncorrect
        networkManager.getTopHeadlines(page: 1) { (headline, error) in
            XCTAssertTrue(self.networkManager.isNetworkRequestCalled)
            XCTAssert(error != nil, "Error shouldn't be nil because response is incorrect")
            XCTAssert(headline == nil, "Headline should be nil because response is incorrect")
        }
    }
    
}

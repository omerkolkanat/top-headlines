//
//  TopHeadlinesViewModelTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class TopHeadlinesViewModelTests: XCTestCase {
    
    var viewModel: TopHeadlineViewModel!
    var networkManager: MockNetworkManager!
    var testDelegate: TestTopHeadlinesViewModelDelegate!
    
    override func setUp() {
        networkManager = MockNetworkManager()
        viewModel = TopHeadlineViewModel(networkManager: networkManager)
        testDelegate = TestTopHeadlinesViewModelDelegate()
    }
    
    override func tearDown() {
        viewModel = nil
        networkManager = nil
        testDelegate = nil
    }
    
    func testLoadInitialHeadlines() {
        networkManager.jsonFileName = .headlineResponseCorrect
        viewModel.delegate = testDelegate
        viewModel.loadInitialHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didLoadHeadlines)
        XCTAssertFalse(testDelegate.didFailed)
    }
    
    func testLoadInitialHeadlinesWithEmptyData() {
        networkManager.jsonFileName = .headlineResponseEmpty
        viewModel.delegate = testDelegate
        viewModel.loadInitialHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didFailed)
        XCTAssertFalse(testDelegate.didLoadHeadlines)
    }
    
    func testLoadInitialHeadlinesWithIncorrectData() {
        networkManager.jsonFileName = .headlineResponseIncorrect
        viewModel.delegate = testDelegate
        viewModel.loadInitialHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didFailed)
        XCTAssertFalse(testDelegate.didLoadHeadlines)
    }
    
    func testLoadMoreHeadlines() {
        networkManager.jsonFileName = .headlineResponseCorrect
        viewModel.delegate = testDelegate
        viewModel.loadMoreHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didLoadHeadlines)
        XCTAssertFalse(testDelegate.didFailed)
    }
    
    func testLoadMoreHeadlinesWithEmptyData() {
        networkManager.jsonFileName = .headlineResponseEmpty
        viewModel.delegate = testDelegate
        viewModel.loadMoreHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didFailed)
        XCTAssertFalse(testDelegate.didLoadHeadlines)
    }
    
    func testLoadMoreHeadlinesWithIncorrectData() {
        networkManager.jsonFileName = .headlineResponseIncorrect
        viewModel.delegate = testDelegate
        viewModel.loadMoreHeadlines()
        XCTAssert(networkManager.isNetworkRequestCalled,
                  "TopHeadlineViewModel.loadInitialHeadlines should call NetworkManager.getTopHeadlines method")
        XCTAssertTrue(testDelegate.didFailed)
        XCTAssertFalse(testDelegate.didLoadHeadlines)
    }
    
}

class TestTopHeadlinesViewModelDelegate: TopHeadlineViewModelProtocol {
    var didLoadHeadlines = false
    var didFailed = false
    
    func didUpdateTopHeadlines() {
        didLoadHeadlines = true
    }

    func didFail(errorMessage: String) {
        didFailed = true
    }
    
    func showLoading(shouldShow: Bool) {
    }
}

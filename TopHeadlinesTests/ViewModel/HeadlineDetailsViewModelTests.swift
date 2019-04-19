//
//  HeadlineDetailsViewModelTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class HeadlineDetailsViewModelTests: XCTestCase {
    
    var viewModel: HeadlineDetailsViewModel!
    override func setUp() {
        let article = Article(source: Source(id: nil, name: "Netzwelt.de"),
                              author: "Media",
                              title: "Outdoor-Navigation: Die besten Wander-Apps",
                              description: "W die ganze Welt noch",
                              url: "https://www.netzwelt.de/news/163671-outdoor-navigation-besten-wander-apps-android-ios-test.html",
                              urlToImage: "https://img.netzwelt.de/dw1600_dh900_sw2000_sh1125_sx436_sy0_sr16x9_nu0/picture/original/2018/02/smartphone-viel-mehr-klassiker-karte-kompass-bild-empfehlenswerte-app-3d-outdoor-guides-225391.jpeg",
                              publishedAt: "2019-04-19T04:33:11Z",
                              content: "xyz")
        viewModel = HeadlineDetailsViewModel(model: article)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testTitle() {
       XCTAssertEqual(viewModel.title, "Outdoor-Navigation: Die besten Wander-Apps")
    }
    
    func testDescription() {
        XCTAssertEqual(viewModel.desc, "W die ganze Welt noch")
    }
    
    func testContent() {
        XCTAssertEqual(viewModel.content, "xyz")
    }
    
    func testPublisher() {
        XCTAssertEqual(viewModel.publisher, "Netzwelt.de")
    }
    
    func testPublishedAt() {
        XCTAssertNotNil(viewModel.publishedAt)
    }
    
    func testImageUrl() {
        XCTAssertEqual(viewModel.imageURL, URL(string: "https://img.netzwelt.de/dw1600_dh900_sw2000_sh1125_sx436_sy0_sr16x9_nu0/picture/original/2018/02/smartphone-viel-mehr-klassiker-karte-kompass-bild-empfehlenswerte-app-3d-outdoor-guides-225391.jpeg"))
    }
    
    func testUrl() {
        XCTAssertEqual(viewModel.url, URL(string: "https://www.netzwelt.de/news/163671-outdoor-navigation-besten-wander-apps-android-ios-test.html"))
    }
    
}

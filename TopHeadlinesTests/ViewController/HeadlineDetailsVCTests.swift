//
//  HeadlineDetailsVCTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 20.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class HeadlineDetailsVCTests: XCTestCase {

    var headlineDetailsVC: HeadlineDetailsVC!
    
    override func setUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HeadlineDetailsVC") as? HeadlineDetailsVC {
            let article = Article(source: Source(id: nil, name: "Netzwelt.de"),
                                  author: "Media",
                                  title: "Outdoor-Navigation: Die besten Wander-Apps",
                                  description: "W die ganze Welt noch",
                                  url: "https://www.netzwelt.de/news/163671-outdoor-navigation-besten-wander-apps-android-ios-test.html",
                                  urlToImage: "https://img.netzwelt.de/dw1600_dh900_sw2000_sh1125_sx436_sy0_sr16x9_nu0/picture/original/2018/02/smartphone-viel-mehr-klassiker-karte-kompass-bild-empfehlenswerte-app-3d-outdoor-guides-225391.jpeg",
                                  publishedAt: "2019-04-19T04:33:11Z",
                                  content: "xyz")
            let viewModel = HeadlineDetailsViewModel(model: article)
            headlineDetailsVC = vc
            headlineDetailsVC.viewModel = viewModel
            headlineDetailsVC.loadView()
            headlineDetailsVC.viewDidLoad()
        }
    }
    
    override func tearDown() {
        headlineDetailsVC.viewWillDisappear(true)
    }
    
    func testDetailTitleLabel() {
        XCTAssertEqual(headlineDetailsVC.detailTitleLabel.text, "Outdoor-Navigation: Die besten Wander-Apps")
    }
    
    func testDetailPublisherLabel() {
        XCTAssertEqual(headlineDetailsVC.detailPublisherLabel.text, "From : Netzwelt.de")
    }
    
    func testDetailDescLabel() {
        XCTAssertEqual(headlineDetailsVC.detailDescLabel.text, "W die ganze Welt noch")
    }
    
    func testDetailContentLabel() {
        XCTAssertEqual(headlineDetailsVC.detailContentLabel.text, "xyz")
    }
    
}

//
//  TopHeadlinesVCTests.swift
//  TopHeadlinesTests
//
//  Created by Omer Kolkanat on 20.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import TopHeadlines

class TopHeadlinesVCTests: XCTestCase {

    var topHeadlinesVC: TopHeadlinesVC!
    
    override func setUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TopHeadlinesVC") as? TopHeadlinesVC {
            topHeadlinesVC = vc
            topHeadlinesVC.loadView()
            topHeadlinesVC.viewDidLoad()
        }
    }
    
    func testCollectionViewDelegateIsSet() {
        XCTAssertNotNil(topHeadlinesVC.collectionView.delegate)
    }
    
    func testCollectionViewDataSourceIsSet() {
        XCTAssertNotNil(topHeadlinesVC.collectionView.dataSource)
    }

    override func tearDown() {
        topHeadlinesVC.viewWillDisappear(true)
    }
    
}

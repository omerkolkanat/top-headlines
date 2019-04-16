//
//  TopHeadlinesVC.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 16.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class TopHeadlinesVC: UIViewController {

    fileprivate let model = TopHeadlineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self
        model.fetchTopHeadlines()
    }

}

extension TopHeadlinesVC: TopHeadlineViewModelProtocol {
    func didUpdateTopHeadlines() {
        print(model.headlines?.articles.count ?? 0)
    }
}

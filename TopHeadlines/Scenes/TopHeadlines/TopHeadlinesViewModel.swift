//
//  TopHeadlinesViewModel.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 16.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

protocol TopHeadlineViewModelProtocol: class {
    func didUpdateTopHeadlines()
}

class TopHeadlineViewModel: NSObject {
    weak var delegate: TopHeadlineViewModelProtocol?
    fileprivate(set) var articles: [Article] = []
    let networkManager = NetworkManager()

    func fetchTopHeadlines() {
        networkManager.getTopHeadlines(page: 1) { (news, error) in
            if error == nil {
                guard let articles = news?.articles else { return }
                self.articles = articles
                self.delegate?.didUpdateTopHeadlines()
            }
        }
    }
}

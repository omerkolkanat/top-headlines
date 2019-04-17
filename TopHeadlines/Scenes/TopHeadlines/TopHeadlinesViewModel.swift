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
    private let networkManager = NetworkManager()
    private var totalNewsCount = 0
    private var pageCounter = 1

    func fetchTopHeadlines() {
        if totalNewsCount != 0 && totalNewsCount == articles.count { return }
        networkManager.getTopHeadlines(page: pageCounter) { [weak self] (news, error) in
            guard let totalNewsCount = news?.totalResults else { return }
            self?.totalNewsCount = totalNewsCount
            
            guard let articles = news?.articles else { return }
            self?.articles += articles
            self?.pageCounter += 1
            self?.delegate?.didUpdateTopHeadlines()
        }
    }
}

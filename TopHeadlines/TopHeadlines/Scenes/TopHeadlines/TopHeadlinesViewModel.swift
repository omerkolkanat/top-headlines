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
    fileprivate(set) var headlines: Headline?
    let networkManager = NetworkManager()

    func fetchTopHeadlines() {
        networkManager.getTopHeadlines(page: 1) { (news, error) in
            if error == nil {
                self.headlines = news
                self.delegate?.didUpdateTopHeadlines()
            }
        }
    }
}

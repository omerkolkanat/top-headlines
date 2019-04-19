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
    func didFail()
}

class TopHeadlineViewModel: NSObject {
    weak var delegate: TopHeadlineViewModelProtocol?
    fileprivate(set) var articles: [ArticleModel] = []
    private let networkManager: NetworkManager
    private var totalNewsCount = 0 //using for pagination to prevent sending new request.
    private var pageCounter = 2 //start from 2
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadInitialHeadlines() {
        networkManager.getTopHeadlines(page: 1) { [weak self] (news, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.delegate?.didFail()
            }
            //Fetch data from db if there is no connection
            if !Reachability.isConnectedToNetwork() {
                if let articles = CoreDataManager.sharedManager.fetchAllArticles(),
                    articles.count != 0 {
                    strongSelf.articles = articles
                    strongSelf.totalNewsCount = articles.count
                    print("Articles loaded from db")
                    strongSelf.delegate?.didUpdateTopHeadlines()
                } else {
                    print("DB is empty")
                    strongSelf.delegate?.didFail()
                }
                return
            }
            guard let articles = news?.articles else { return }
            guard let totalNewsCount = news?.totalResults else { return }
            strongSelf.totalNewsCount = totalNewsCount
            
            CoreDataManager.sharedManager.deleteAllArticles()
            articles.forEach({ (article) in
                strongSelf.insertArticleToDB(article: article)
            })
            print("Articles loaded from service")
            self?.delegate?.didUpdateTopHeadlines()
        }
    }
    
    func loadMoreHeadlines() {
        if totalNewsCount != 0 && totalNewsCount == articles.count { return }
        networkManager.getTopHeadlines(page: pageCounter) { [weak self] (news, error) in
            if error != nil {
                self?.delegate?.didFail()
            }
            guard let articles = news?.articles else { return }
            articles.forEach({ (article) in
                self?.insertArticleToDB(article: article)
            })
            self?.pageCounter += 1
            self?.delegate?.didUpdateTopHeadlines()
        }
    }
    
    private func insertArticleToDB(article: Article) {
        DispatchQueue.main.async { [weak self] in
            let insertedArticle = CoreDataManager.sharedManager.insertArticle(article: article)
            if let insertedArticle = insertedArticle {
                self?.articles.append(insertedArticle)
            }
        }
    }
}

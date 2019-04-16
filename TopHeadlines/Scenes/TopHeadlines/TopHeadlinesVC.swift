//
//  TopHeadlinesVC.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 16.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class TopHeadlinesVC: UIViewController {

    enum Const {
        static let cellHeight: CGFloat = 270
        static let minLineSpacing: CGFloat = 2
        static let minItemSpacing: CGFloat = 2
        static let safeAreaSize: CGFloat = 27
        static let itemPerRowInPortrait: CGFloat = 2
        static let itemPerRowInLandscape: CGFloat = 3
        static let fullWidthItemRepeatCount: Int = 7
    }
    
    fileprivate let model = TopHeadlineViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        model.delegate = self
        model.fetchTopHeadlines()
    }
    
    func setupUI() {
        title = "Top Headlines"
        collectionView.contentInsetAdjustmentBehavior = .always

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}

extension TopHeadlinesVC: UICollectionViewDelegate {
    
}

extension TopHeadlinesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineCollectionViewCell",
                                                            for: indexPath) as? HeadlineCollectionViewCell else {
            fatalError("Cell is not found")
        }
        cell.configure(with: model.articles[indexPath.row])
        return cell
    }
    
}
extension TopHeadlinesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % Const.fullWidthItemRepeatCount == 0 {
            if UIDevice.current.orientation.isLandscape {
                let safeAreaSize: CGFloat = UIDevice.current.hasNotch ? Const.safeAreaSize * 4 : 0
                return CGSize(width: self.view.frame.width - safeAreaSize, height: Const.cellHeight)
            } else {
                return CGSize(width: self.view.frame.width, height: Const.cellHeight)
            }
        } else {
            if UIDevice.current.orientation.isLandscape {
                let safeAreaSize: CGFloat = UIDevice.current.hasNotch ? Const.safeAreaSize : 0
                let widthPerItem = view.frame.width / Const.itemPerRowInLandscape - ((collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0) - safeAreaSize
                return CGSize(width: widthPerItem, height: Const.cellHeight)
            } else {
                let widthPerItem = view.frame.width / Const.itemPerRowInPortrait - ((collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0)
                return CGSize(width: widthPerItem, height: Const.cellHeight)
            }
        }
    }
}

extension TopHeadlinesVC: TopHeadlineViewModelProtocol {
    func didUpdateTopHeadlines() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

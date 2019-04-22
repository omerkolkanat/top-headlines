//
//  HeadlineCollectionViewCell.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 16.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit
import Kingfisher

class HeadlineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsFromLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsTitleLabel.text = nil
        newsDescriptionLabel.text = nil
        newsFromLabel.text = nil
        newsTimeLabel.text = nil
    }
    
    func configure(with article: ArticleModel) {
        if let imageURL = article.urlToImage {
            newsImageView.kf.setImage(with: imageURL) { [weak self] result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error.errorDescription ?? "image download error")
                    self?.newsImageView.image = UIImage(named: "placeholder")
                }
            }
        } else {
            self.newsImageView.image = UIImage(named: "placeholder")
        }
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.desc
        newsFromLabel.text = "From : \(article.sourceName ?? "")"

        if let publishedAtString = article.publishedAt {
            let date = publishedAtString.toDate()
            newsTimeLabel.text = date?.timeAgoSinceDate()
        }
    }
}

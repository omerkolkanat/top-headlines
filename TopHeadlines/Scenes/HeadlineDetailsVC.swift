//
//  HeadlineDetailsVC.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 17.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import UIKit

class HeadlineDetailsVC: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPublishTimeLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    @IBOutlet weak var detailContentLabel: UILabel!
    @IBOutlet weak var detailPublisherLabel: UILabel!
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df
    }()
    
    var model: ArticleModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = model else { return }
        if let imageURL = model.urlToImage {
            detailImageView.kf.setImage(with: imageURL) { [weak self] result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error.errorDescription ?? "image download error")
                    self?.detailImageView.image = UIImage(named: "placeholder")
                }
            }
        } else {
            self.detailImageView.image = UIImage(named: "placeholder")
        }
        detailTitleLabel.text = model.title
        detailDescLabel.text = model.desc
        detailContentLabel.text = model.content
        detailPublisherLabel.text = "From : \(model.sourceName!)"
        
        let date = dateFormatter.date(from: model.publishedAt!)
        detailPublishTimeLabel.text = date?.timeAgoSinceDate()
    }
    @IBAction func detailButtonTapped(_ sender: Any) {
        guard let model = model else { return }
        UIApplication.shared.open(model.url!)
    }
}

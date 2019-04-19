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
    
    var viewModel: HeadlineDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        if let imageURL = viewModel.imageURL {
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
        detailTitleLabel.text = viewModel.title
        detailDescLabel.text = viewModel.desc
        detailContentLabel.text = viewModel.content
        detailPublisherLabel.text = "From : \(viewModel.publisher)"
        detailPublishTimeLabel.text = viewModel.publishedAt
    }
    @IBAction func detailButtonTapped(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        if let url = viewModel.url {
            UIApplication.shared.open(url)
        }
    }
}

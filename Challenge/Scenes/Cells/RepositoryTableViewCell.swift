//
//  RepositoryTableViewCell.swift
//  Challenge
//
//  Created by Thiago on 17/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var repositoryImageView: UIImageView! {
        didSet {
            self.repositoryImageView.layer.maskToCircle()
        }
    }
    @IBOutlet var repositoryNameLabel: UILabel! {
        didSet {
            self.repositoryNameLabel.text = ""
        }
    }
    @IBOutlet var authorNameLabel: UILabel! {
        didSet {
            self.authorNameLabel.text = ""
        }
    }
    @IBOutlet var starsNumberLabel: UILabel! {
        didSet {
            self.starsNumberLabel.text = ""
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        self.repositoryImageView.image = nil
        self.repositoryNameLabel.text = ""
        self.authorNameLabel.text = ""
        self.starsNumberLabel.text = ""
    }
    
    // MARK: - MISC
    func setup(item: RepositoryItensResponse) {
        if let profileEstablishment = item.owner?.avatar_url {
            if let url = URL(string:profileEstablishment) {
                let resources = ImageResource(downloadURL: url, cacheKey: item.name ?? "")
                self.repositoryImageView.kf.setImage(with: resources)
            }
        }
        self.repositoryNameLabel.text = item.name ?? ""
        self.authorNameLabel.text = item.owner?.login ?? ""
        self.starsNumberLabel.text = (item.stargazers_count?.description ?? "") + " Stars"
    }
}

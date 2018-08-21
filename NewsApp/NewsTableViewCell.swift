//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Neha Tripathi on 04/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.orange.cgColor
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.borderColor = UIColor.orange.cgColor
        newsImageView.layer.borderWidth = 2
        newsImageView.clipsToBounds = true
        newsDetailsLabel.textColor = UIColor.orange
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    /// Method for configuring the table view cell
    ///
    /// - Parameter news: The NewsObject using which the cell will be configured
    func configureCell(news : NewsObject) {
        newsDetailsLabel.text = news.author + " | " + news.publishedAt
        newsTitleLabel.text = news.title
        if let url = URL(string: news.imageUrl){
            newsImageView.imageFromURL(url: url)
        }
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = UIImage(named: "defaultPhoto")
    }
}

//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Neha Tripathi on 04/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import UIKit
import os.log

class NewsViewController: UIViewController {
    
    var news : NewsObject?
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let news = news{
            if let url = URL(string: news.imageUrl){
                newsImageView.imageFromURL(url: url)
            }
            newsImageView.layoutSubviews()
        }
        detailsLabel.textColor = UIColor.orange
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let news = news else {
            fatalError("No news object!")
        }
        descriptionTextView.text = news.newsDescription
        detailsLabel.text = news.author + " | " + news.publishedAt
        titleLabel.text = news.title
        sourceLabel.text = news.source.name
    }
}



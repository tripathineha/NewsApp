//
//  NewsObject.swift
//  NewsApp
//
//  Created by Neha Tripathi on 04/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import Foundation

class NewsObject : NSObject {
    var title : String
    var newsDescription : String
    var url : URL
    var imageUrl : String
    var author : String
    var publishedAt :  String
    var source : (id:String,name:String)
    
    init(title : String, description : String, url : URL, imageUrl : String, author : String, publishedAt :  String, source : (id:String , name:String)) {
        self.title = title
        self.newsDescription = description
        self.url = url
        self.imageUrl = imageUrl
        self.author = author
        self.publishedAt = publishedAt
        self.source = source
    }
    
    convenience init?(json : Dictionary<String, Any>) {
        
        guard let title = json[ Json.title] as? String,
            let author = json[ Json.author] as? String,
            let url1 = json[ Json.url] as? String,
            let imageUrl  = json[ Json.imageUrl] as? String,
            let url = URL(string: url1) ,
            let description = json[ Json.newsDescription] as? String,
            let publishedAt = json[ Json.publishedAt] as? String,
            let sourceDictionary = json[ Json.source] as? Dictionary<String,String>,
            let id  = sourceDictionary[ Json.sourceId],
            let name = sourceDictionary[ Json.sourceName]
            else{
            return nil
        }
        let source = (id,name)
        self.init(title : title, description : description, url : url, imageUrl : imageUrl, author : author, publishedAt :  publishedAt,source : source)
    }
}

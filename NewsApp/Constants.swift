//
//  Constants.swift
//  NewsApp
//
//  Created by Neha Tripathi on 10/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

enum APIData : String {
    case APIKey = "6f1f9812f9994150b521dd734c4662b2"
    case APISource = "https://newsapi.org/v2/top-headlines"
}

enum URLString : String {
    case techcrunch = "TechCrunch"
    case cnn = "CNN"
    case dailyMail = "DailyMail"
}

enum Source : String {
    case TechCrunch = "techcrunch"
    case DailyMail = "daily-mail"
    case CNN = "cnn"
}

/// Structure containing various keys of the json data received
struct Json {
    static let articles = "articles"
    static let title = "title"
    static let newsDescription = "description"
    static let url = "url"
    static let imageUrl = "urlToImage"
    static let author = "author"
    static let publishedAt = "publishedAt"
    static let source = "source"
    static let sourceId = "id"
    static let sourceName = "name"
}

enum JsonKeys : String {
    case articles = "articles"
    case title = "title"
    case newsDescription = "description"
    case url = "url"
    case imageUrl = "urlToImage"
    case author = "author"
    case publishedAt = "publishedAt"
    case source = "source"
    case sourceId = "id"
    case sourceName = "name"
    case apiKey = "apiKey"
    case sourcesKey = "sources"
}


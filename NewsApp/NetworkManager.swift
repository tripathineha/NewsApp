//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Neha Tripathi on 09/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import Foundation
import UIKit

private let sharedManager = NetworkManager()

class NetworkManager {
    class var sharedInstance: NetworkManager {
            return sharedManager
        }
    
    /// Method for getting the data from the URL using URLSession
    ///
    /// - Parameters:
    ///   - urlString: the URL of the news
    ///   - handler: handler called after the completion of the URL Session Task
    func getData(urlString : String,handler: @escaping (Data?, URLResponse?, Error?)->()) {
        
        guard let url = URL(string: urlString) else {
            let err = NSError(domain: "Improper URL", code: 2, userInfo: nil)
            handler(nil, nil, err)
            return
        }
        
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
       
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            handler(data, response, error)
        }
        task.resume()
        return
    }
    
    
    /// method to create an alert whenever any error occurs
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: Message of the alert
    ///   - hasCancelAction: true if the alert has a cancel action along with ok action, otherwise false
    /// - Returns: alert with the above properties
    func createAlert(title: String? , message: String?, hasCancelAction : Bool) -> UIAlertController{
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        if hasCancelAction {
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            errorAlert.addAction(cancelAction)
        }
        errorAlert.addAction(okAction)
        return errorAlert
    }
}


extension NetworkManager{
    func sendRequest(source : String, completion: @escaping ([String: Any]?, Error?) -> Void) {
       
        guard var components = URLComponents(string: APIData.APISource.rawValue) else {
            let err = NSError(domain: "Improper URL", code: 2, userInfo: nil)
            completion(nil, err)
            return
        }
        var key : String?
        var value : String?
        switch (source){
        case  URLString.cnn.rawValue :
            key =  JsonKeys.sourcesKey.rawValue
            value =  Source.CNN.rawValue
        case  URLString.techcrunch.rawValue :
            key =  JsonKeys.sourcesKey.rawValue
            value =  Source.TechCrunch.rawValue
        case  URLString.dailyMail.rawValue :
            key =  JsonKeys.sourcesKey.rawValue
            value =  Source.DailyMail.rawValue
        default:
            print("Default")
            key =  JsonKeys.sourcesKey.rawValue
            value =  Source.TechCrunch.rawValue
        }
        if let key = key,
            let value = value {
            components.queryItems = [URLQueryItem(name: key, value: value), URLQueryItem(name:  JsonKeys.apiKey.rawValue ,value :  APIData.APIKey.rawValue)]
        }
       
        guard let url = components.url else {
                let err = NSError(domain: "Improper URLRequest", code: 3, userInfo: nil)
                print("ab")
                completion(nil, err)
                return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }
            
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject, nil)
        }
        task.resume()
    }
}

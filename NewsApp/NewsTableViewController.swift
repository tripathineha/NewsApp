//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Neha Tripathi on 13/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import UIKit

class NewsTableViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var newsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Constants
    private let cellIdentifier = "News"
    private let segueIdentifier = "Show News Details"
    
    private var newsList = [NewsObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start loading the news details from URL
        loadNews()
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - Table View Data Source
extension NewsTableViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Unexpected indexPath")
        }
        
        let news = newsList[indexPath.row]
        cell.configureCell(news: news)
        cell.newsImageView.layoutSubviews()
        
        return cell
    }
}

//MARK: - Table View Delegate
extension NewsTableViewController : UITableViewDelegate{
    
}

// MARK: - Navigation
extension NewsTableViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let cell = sender as? NewsTableViewCell else {
            return
        }
        let identifier = segue.identifier ?? ""
        switch identifier{
        case segueIdentifier:
            guard let destinationViewController = segue.destination as? NewsViewController else{
                return
            }
            if let indexPath = newsTableView.indexPath(for: cell){
                destinationViewController.news = newsList[indexPath.row]
            }
        default:
            print("default")
        }
    }
}

//Class extension for fetching News
extension NewsTableViewController {
    
    
    /// Method for loading the news from Web
    func loadNews(){
        
        // Hide the table View
        newsTableView.isHidden = true
        activityIndicator.startAnimating()
        
        if let segmentName = newsSegmentedControl.titleForSegment(at: newsSegmentedControl.selectedSegmentIndex) {
            NetworkManager.sharedInstance.sendRequest(source: segmentName, completion: self.handler(response:error:))
        }
    }
}


//Class extension for handlers
extension NewsTableViewController {
    
    @objc func handler(response: [String : Any]?,error:  Error?) {
        if let error = error {
            print(error)
            let errorAlert = NetworkManager.sharedInstance.createAlert(title: "Error", message: error.localizedDescription, hasCancelAction: false)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        if let response = response{
            guard let newsArticles = response[Json.articles] as? [[String:Any]] else {
                print(response)
                let errorAlert = NetworkManager.sharedInstance.createAlert(title:"Error" , message: String(describing : response), hasCancelAction: false)
                self.present(errorAlert, animated: true, completion: nil)
                updateViews()
                return
            }
            newsList = [NewsObject]()
            for newsDetails in newsArticles {
                if let news = NewsObject(json : newsDetails){
                    self.newsList.append(news)
                    updateViews()
                }
            }
        } else {
            let errorAlert = NetworkManager.sharedInstance.createAlert(title: "Error", message: "Invalid Data received!", hasCancelAction: false)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
    }
    
    private func updateViews(){
        DispatchQueue.main.async {
            self.newsTableView.isHidden = false
            self.newsTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    /// JsonHandler is used for parsing the data received from the URL
    ///
    /// - Parameters:
    ///   - data: data returned by the URL
    ///   - response: response code from the server
    ///   - error: any error that occured due to the device
    
}

// MARK: - IBAction methods
extension NewsTableViewController{
    @IBAction func onSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        loadNews()
        newsTableView.reloadData()
    }
    
    @IBAction func onRefreshButtonTapped(_ sender: UIBarButtonItem) {
        loadNews()
        newsTableView.reloadData()
    }
}

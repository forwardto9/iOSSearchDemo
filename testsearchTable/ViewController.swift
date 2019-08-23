//
//  ViewController.swift
//  testsearchTable
//
//  Created by uwei on 2019/8/23.
//  Copyright © 2019 TEG of Tencent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [String]!
    
    var dataTable:UITableView!
    var searchbar:UISearchBar!
    var searchController: UISearchDisplayController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        searchbar.sizeToFit()
        searchbar.backgroundColor = .yellow
        searchbar.delegate = self
        self.navigationItem.titleView = searchbar
        
        
        if #available(iOS 8, *) {
            /* iOS13 not support
                   searchController = UISearchDisplayController(searchBar: self.searchbar, contentsController: self)
                   searchController.delegate = self;
                   searchController.searchResultsDataSource = self;
                   searchController.searchResultsDelegate = self;
                   searchController.displaysSearchBarInNavigationBar = true
            */
        }
        
        
        
        
        dataTable = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        self.dataTable.register(UITableViewCell.self, forCellReuseIdentifier: "kid")
        dataTable.dataSource = self
        dataTable.delegate = self
        filteredData = data
        
        
//        self.view.addSubview(searchbar)
        self.view.addSubview(dataTable)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(svc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kid", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        dataTable.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchbar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
}


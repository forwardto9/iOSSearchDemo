//
//  SearchViewController.swift
//  testsearchTable
//
//  Created by uwei on 2019/8/23.
//  Copyright © 2019 TEG of Tencent. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })

            dataTable.reloadData()
        }
    }
    
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [String]!
    
    var dataTable:UITableView!
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        dataTable = UITableView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        self.dataTable.register(UITableViewCell.self, forCellReuseIdentifier: "kid")
        dataTable.dataSource = self
        dataTable.delegate = self
        filteredData = data
        
        self.view.addSubview(dataTable)
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.sizeToFit()
        dataTable.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
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
            searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }

}

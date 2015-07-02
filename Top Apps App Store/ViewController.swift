//
//  ViewController.swift
//  Top Apps App Store
//
//  Created by Robert Ignasiak on 30.06.2015.
//  Copyright © 2015 Torianin Solutions Robert Ignasiak. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UISearchResultsUpdating , UITableViewDataSource, UITableViewDelegate, AppsListShouldRefreshDelegate  {
    @IBOutlet weak var appsTableView: UITableView!
    
    private lazy var appsList: AppsList = AppsList(aDelegate: self)

    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.appsTableView.tableHeaderView = searchController.searchBar
        appsTableView.addSubview(self.refreshControl)
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        appsList.getDataFromURL()
        appsTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.active) {
            return self.appsList.filteredApps.count
        }
        else {
            return self.appsList.apps.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if (self.searchController.active) {
            cell.textLabel?.text = String(indexPath.row + 1) + ". " + self.appsList.filteredApps[indexPath.row].name!
            Alamofire.request(.GET,URLString: self.appsList.apps[indexPath.row].imageUrl!)
                .response { (_, _, data, _) in
                    cell.imageView!.image = UIImage(data: data as! NSData)
                    cell.setNeedsLayout()
            }
        }
        else {
            cell.textLabel?.text = String(indexPath.row + 1) + ". " + self.appsList.apps[indexPath.row].name!
            Alamofire.request(.GET,URLString: self.appsList.apps[indexPath.row].imageUrl!)
                .response { (_, _, data, _) in
                    cell.imageView!.image = UIImage(data: data as! NSData)
                    cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    func shouldRefresh() {
        appsTableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.appsList.filteredApps.removeAll(keepCapacity: false)
        for app in self.appsList.apps {
            if (app.name!.rangeOfString(searchController.searchBar.text!) != nil){
                self.appsList.filteredApps.append(app)
            }
        }
        self.appsTableView.reloadData()
    }
}


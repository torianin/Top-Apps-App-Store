//
//  ViewController.swift
//  Top Apps App Store
//
//  Created by Robert Ignasiak on 30.06.2015.
//  Copyright © 2015 Torianin Solutions Robert Ignasiak. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    let AppsURL = NSURL(string: "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json") ;

    @IBOutlet weak var tableView: UITableView!

    var apps: [App] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.getDataFromURL()
        self.tableView.addSubview(self.refreshControl)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.getDataFromURL()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + apps[indexPath.row].name!
        Alamofire.request(.GET,URLString: apps[indexPath.row].imageUrl!)
            .response { (_, _, data, _) in
                let image = UIImage(data: data as! NSData)
                cell.imageView!.image = image
        }
        return cell
    }
    
    func getDataFromURL() {
        Alamofire.request(.GET, URLString: AppsURL!)
            .responseJSON {(request,response,data,error) in
                let json = JSON(data!)
                if let topApps = json["feed"]["entry"].array {
                    for app in topApps {
                        let appName: String? = app["im:name"]["label"].string
                        let appImageUrl: String? = app["im:image"][0]["label"].string
                        self.apps.append(App(name: appName, imageUrl: appImageUrl))
                }
            }
            self.tableView.reloadData()
        }
    }
}


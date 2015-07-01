//
//  AppsList.swift
//  Top Apps App Store
//
//  Created by Robert Ignasiak on 01.07.2015.
//  Copyright © 2015 Torianin Solutions Robert Ignasiak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AppsList {
    let AppsURL = NSURL(string: "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json")
    
    private var delegate: AppsListShouldRefreshDelegate
    private(set) var apps: [App] = []
    
    init(aDelegate: AppsListShouldRefreshDelegate) {
        delegate = aDelegate
        getDataFromURL()
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
                self.delegate.shouldRefresh()
        }
    }
}
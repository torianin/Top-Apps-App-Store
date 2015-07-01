//
//  Repository.swift
//  Top Apps App Store
//
//  Created by Robert Ignasiak on 30.06.2015.
//  Copyright © 2015 Torianin Solutions Robert Ignasiak. All rights reserved.
//

import Foundation

class App {
    var name: String?
    var imageUrl: String?
    
    init(name: String?, imageUrl: String?) {
        self.name = name ?? ""
        self.imageUrl = imageUrl ?? ""
    }
}
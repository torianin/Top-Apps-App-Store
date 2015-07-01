//
//  Example_Tests.swift
//  Example Tests
//
//  Created by Robert Ignasiak on 01.07.2015.
//  Copyright © 2015 Torianin Solutions Robert Ignasiak. All rights reserved.
//

import XCTest

class Example_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateAppModel() {
        let app = App(name: "Test App", imageUrl: "http://robert-i.com")
        XCTAssertNotNil(app)
    }
    
    func testCreateMoreApps() {
        var apps: [App] = []
        apps.append(App(name: "Test App", imageUrl: "http://robert-i.com"))
        apps.append(App(name: "Test App2", imageUrl: "http://robert-i.com"))
        XCTAssertGreaterThan(apps.count, 0)
    }
    
    func testPerformanceExample() {
        var apps: [App] = []
        self.measureBlock() {
            for index in 1...10 {
                apps.append(App(name: "Test App\(index)", imageUrl: "http://robert-i.com"))
            }
        }
        // measureBlock uruchamia blok kodu wiele razy i bierze średnią wartość
        XCTAssertTrue(apps[99].name == "Test App10")
    }
    
}

//
//  AboutCanadaUITests.swift
//  AboutCanadaUITests
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import XCTest

class AboutCanadaUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testHomeScreen() {
        
        let app = XCUIApplication()
        app.launch()
        let label = app.navigationBars["About Canada"].staticTexts["About Canada"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testNavigationTODetailScreen() {
        
        let app = XCUIApplication()
        app.launch()
        let myTable = app.tables.matching(identifier: "canadaFactsListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "myCell")
        cell.tap()
    }

    func testLaunchPerformance() {
                if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

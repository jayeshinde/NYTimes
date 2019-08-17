//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import XCTest

class NYTimesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation
        // of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state
        //  - such as interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTap() {
      let app = XCUIApplication()
      app.tables/*@START_MENU_TOKEN@*/.staticTexts["The Day Jeffrey Epstein Told Me He Had Dirt on Powerful People"]/*[[".cells.staticTexts[\"The Day Jeffrey Epstein Told Me He Had Dirt on Powerful People\"]",".staticTexts[\"The Day Jeffrey Epstein Told Me He Had Dirt on Powerful People\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app.navigationBars["NYTimes.ArticleDetailVC"].buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

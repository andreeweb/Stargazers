//
//  StargazersUITests.swift
//  StargazersUITests
//
//  Created by MacOS on 10/31/20.
//

import XCTest

class StargazersUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let goSearchButton = app.buttons["search_bar_button"]
        XCTAssert(goSearchButton.exists)
        goSearchButton.tap()
        
        let textOwner = app.textFields["search_owner_text"]
        XCTAssert(textOwner.exists)
        textOwner.tap()
        textOwner.typeText("octocat")

        let textRepository = app.textFields["search_repository_text"]
        XCTAssert(textRepository.exists)
        textRepository.tap()
        textRepository.typeText("hello-world")
        
        let searchSearchButton = app.buttons["search_search_button"]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        sleep(5)
        
        // count elements in list
        XCTAssert(app.tables.staticTexts.count > 0)
    }
    
    func testSearchInputNotValid() throws {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let goSearchButton = app.buttons["search_bar_button"]
        XCTAssert(goSearchButton.exists)
        goSearchButton.tap()
        
        let textOwner = app.textFields["search_owner_text"]
        XCTAssert(textOwner.exists)
        textOwner.tap()
        textOwner.typeText("octocat")
        
        let searchSearchButton = app.buttons["search_search_button"]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        addUIInterruptionMonitor(withDescription: "Input Alert") { (alert) -> Bool in
          alert.buttons["Ok"].tap()
          return true
        }
    }
}

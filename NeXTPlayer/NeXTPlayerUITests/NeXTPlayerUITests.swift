//
//  NeXTPlayerUITests.swift
//  NeXTPlayerUITests
//
//  Created by marcelo bianchi on 03/10/23.
//

import XCTest

final class NeXTPlayerUITests: XCTestCase {
   
    override class func setUp() {
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.


        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLocalMedia() throws {
        let app = XCUIApplication()
        app.launch()
        
//        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Local media"].tap()
        
        let element = app.scrollViews.containing(.other, identifier:"Vertical scroll bar, 1 page").children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .scrollView).element(boundBy: 0).swipeDown()
        element.children(matching: .button).matching(identifier: "See all").element(boundBy: 0).tap()
        
        let backStaticText = app.navigationBars["_TtGC7SwiftUI19UIHosting"]/*@START_MENU_TOKEN@*/.staticTexts["back"]/*[[".otherElements[\"back\"]",".buttons[\"back\"].staticTexts[\"back\"]",".staticTexts[\"back\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        backStaticText.tap()
        element.children(matching: .button).matching(identifier: "See all").element(boundBy: 1).staticTexts["See all"].tap()
        backStaticText.tap()
                
    }
}

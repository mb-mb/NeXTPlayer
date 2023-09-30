//
//  NeXTPlayerUITests.swift
//  NeXTPlayerUITests
//
//  Created by marcelo bianchi on 12/10/21.
//

import XCTest

class NeXTPlayerUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
        
    }

    func testExample() throws {
        let button = self.app.buttons["buttonMenuChange"]
        button.tap()
        let artistName = self.app.staticTexts["artistName"]
        XCTAssert(artistName.exists)
    }

}

//
//  NumberFactsUITests.swift
//  NumberFactsUITests
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import XCTest

final class NumberFactsUITests: XCTestCase {

    func testInvalidInput() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["NumberFactsViewController-numberTextField"].tap()
        app.keys["r"].tap()
        app.buttons["NumberFactsViewController-getInfoButton"].tap()
        
        
        let errorText = app.staticTexts["NumberFactsViewController-errorLabel"].label
        
        XCTAssertEqual(errorText, "The input is not a number")
    }
}

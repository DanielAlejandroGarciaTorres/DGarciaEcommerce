//
//  DGarciaEcommerceUITests.swift
//  DGarciaEcommerceUITests
//
//  Created by MacBookMBA3 on 18/01/23.
//

import XCTest

final class DGarciaEcommerceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testLogin() throws {
                // UI tests must launch the application that they test.
            
        
        let app = XCUIApplication()
        app.launch()
        let correo = app.textFields["Correo"]
        XCTAssertTrue(correo.exists)
        correo.tap()
        correo.typeText("dgarciatorres97@gmail.com")
        
        let contrasena = app.secureTextFields["Contraseña"]
        XCTAssertTrue(correo.exists)
        contrasena.tap()
        contrasena.typeText("pass@word1")
        
        
        let button = app.buttons["Login"]
        XCTAssertTrue(button.exists)
        button.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.alerts["Error"].scrollViews.otherElements.buttons["OK"].tap()
    
         
        }
    

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

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
}

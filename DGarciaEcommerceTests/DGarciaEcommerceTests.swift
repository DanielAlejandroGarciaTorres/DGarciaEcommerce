//
//  DGarciaEcommerceTests.swift
//  DGarciaEcommerceTests
//
//  Created by MacBookMBA3 on 18/01/23.
//

import XCTest
@testable import DGarciaEcommerce

final class DGarciaEcommerceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    func testAddIncorrectDepartament() throws {
        let departamiendoViewModel = DepartamentoViewModel()
        let result = departamiendoViewModel.Add(departamento: Departamento(IdDepartamento: 0, Nombre: "Testing", Area: Area(IdArea: 500, Nombre: "")))
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testAddCorrectDepartament() throws {
        let departamiendoViewModel = DepartamentoViewModel()
        let result = departamiendoViewModel.Add(departamento: Departamento(IdDepartamento: 0, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "")))
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testUpdateDepartamentIncorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Update(departamento: Departamento(IdDepartamento: 0, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "")), idDepartamento: 500)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testUpdateDepartamentCorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Update(departamento: Departamento(IdDepartamento: 0, Nombre: "TestingQueDebereiaSalirCorrecto", Area: Area(IdArea: 1, Nombre: "")), idDepartamento: 5)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDeleteDepartamentoIncorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Delete(idDepartamento: 500)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDeleteDepartamentoCorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Delete(idDepartamento: 5)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testGetByIdDepartamentIncorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.GetById(idDepartamento: 500)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testGetByIdDepartamentCorrect() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.GetById(idDepartamento: 4)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
}

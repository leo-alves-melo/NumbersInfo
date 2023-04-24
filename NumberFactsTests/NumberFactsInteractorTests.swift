//
//  NumberFactsInteractorTests.swift
//  NumberFactsTests
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import Foundation
import XCTest
@testable import NumberFacts

class NumberFactsInteractorTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var currentExpectation: XCTestExpectation?
    
    // MARK: - Test Methods
    
    func testNormalInput() {
        
        let expectation = self.expectation(description: "didTapRequestInfo normalInput")
        self.currentExpectation = expectation
        
        expectation.expectedFulfillmentCount = 2
        
        let interactor = NumberFactsInteractor(presenter: self, worker: self)
        
        interactor.didTapRequestInfo(text: "5")
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testInvalidText() {
        
        let expectation = self.expectation(description: "didTapRequestInfo invalidText")
        self.currentExpectation = expectation
        
        expectation.expectedFulfillmentCount = 2
        
        let interactor = NumberFactsInteractor(presenter: self, worker: self)
        
        interactor.didTapRequestInfo(text: "Soma do quadrado dos catetos igual ao quadrado da hipotenusa")
        
        wait(for: [expectation], timeout: 5)
    }
}

extension NumberFactsInteractorTests: NumberFactsWorkerLogic, NumberFactsPresentationLogic {
    func requestInfo(number: Int) async throws -> Data {
        return "11 is the number of players in a soccer field".data(using: .utf8) ?? Data()
    }
    
    func present(state: NumberFacts.NumberFactsModels.ScreenState) {
        
        switch state {
        case .loading:
            break
        case .presenting(let info):
            XCTAssertEqual(currentExpectation?.description, "didTapRequestInfo normalInput")
            XCTAssertEqual(info, "11 is the number of players in a soccer field")
        case .error(let error):
            XCTAssertEqual(currentExpectation?.description, "didTapRequestInfo invalidText")
            XCTAssertEqual(error.description, "The input is not a number")
        }
        
        currentExpectation?.fulfill()
    }
}

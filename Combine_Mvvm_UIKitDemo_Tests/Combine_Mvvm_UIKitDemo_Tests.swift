//
//  Combine_Mvvm_UIKitDemo_Tests.swift
//  Combine_Mvvm_UIKitDemo_Tests
//
//  Created by Medhat Mebed on 1/22/24.
//

import XCTest
import Combine
@testable import CombineMvvmUIKitDemo

final class Combine_Mvvm_UIKitDemo_Tests: XCTestCase {
    
    var sut: QuoteViewModel!
    var quoteService: MockQuoteServiceType!
    
    override func setUpWithError() throws {
        quoteService = MockQuoteServiceType()
        sut = QuoteViewModel(quoteServiceType: quoteService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



}

class MockQuoteServiceType: QuoteServiceType {
  
  var value: AnyPublisher<Quote, Error>?
  func getRandomQuote() -> AnyPublisher<Quote, Error> {
    return value ?? Empty().eraseToAnyPublisher()
  }
  
  
}


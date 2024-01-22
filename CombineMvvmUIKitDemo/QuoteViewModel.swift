//
//  QuoteViewModel.swift
//  CombineMvvmUIKitDemo
//
//  Created by Medhat Mebed on 1/22/24.
//

import Foundation
import Combine

class QuoteViewModel {
  /// input is the events that the viewmodel will receive from the view controller
  enum Input {
    case viewDidAppear
    case refreshButtonDidTap
  }
  /// output is the results from the viewmodel to the view controller
  enum Output {
    case fetchQuoteDidFail(error: Error)
    case fetchQuoteDidSucceed(quote: Quote)
    case toggleButton(isEnabled: Bool)
  }
  
  private let quoteServiceType: QuoteServiceType
  private let output: PassthroughSubject<Output, Never> = .init()
  private var cancellables = Set<AnyCancellable>()
  /// dependency injection for the quoteService because we can swap it with the mockService in the unit testing
  init(quoteServiceType: QuoteServiceType = QuoteService()) {
    self.quoteServiceType = quoteServiceType
  }
  /// in this function we transform the events from the view controller into actions and return the results
  func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input.sink { [weak self] event in
      switch event {
      case .viewDidAppear, .refreshButtonDidTap:
        self?.handleGetRandomQuote()
      }
    }.store(in: &cancellables)
    return output.eraseToAnyPublisher()
  }
  /// making the api call
  private func handleGetRandomQuote() {
    output.send(.toggleButton(isEnabled: false))
    quoteServiceType.getRandomQuote()
          .sink { [weak self] completion in
      self?.output.send(.toggleButton(isEnabled: true))
      if case .failure(let error) = completion {
        self?.output.send(.fetchQuoteDidFail(error: error))
      }
    } receiveValue: { [weak self] quote in
      self?.output.send(.fetchQuoteDidSucceed(quote: quote))
    }.store(in: &cancellables)
  }
}


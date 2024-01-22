//
//  ViewController.swift
//  CombineMvvmUIKitDemo
//
//  Created by Medhat Mebed on 1/22/24.
//

import UIKit
import Combine


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    private let vm = QuoteViewModel()
    private let input: PassthroughSubject<QuoteViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      input.send(.viewDidAppear)
    }
    
    private func bind() {
      let output = vm.transform(input: input.eraseToAnyPublisher())
      output
        .receive(on: DispatchQueue.main)
        .sink { [weak self] event in
        switch event {
        case .fetchQuoteDidSucceed(let quote):
          self?.label.text = quote.content
        case .fetchQuoteDidFail(let error):
          self?.label.text = error.localizedDescription
        case .toggleButton(let isEnabled):
          self?.refreshButton.isEnabled = isEnabled
        }
      }.store(in: &cancellables)
      
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        input.send(.refreshButtonDidTap)
    }
}


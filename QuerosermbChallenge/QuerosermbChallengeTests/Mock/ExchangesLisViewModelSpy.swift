//
//  ExchangesLisViewModelSpy.swift
//  QuerosermbChallengeTests
//
//  Created by Lazaro on 19/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

@testable import QuerosermbChallenge

final class ExchangesLisViewModelSpy {

    private let viewModel: ExchangesLisViewModel
    
    init(viewModel: ExchangesLisViewModel) {
        self.viewModel = viewModel
        
        spyExchanges()
        spyLoading()
        spyError()
    }
    
    private(set) var invokedShowExchanges = false
    private(set) var invokedShowExchangesCount = 0
    private(set) var invokedShowExchangesParameters: (exchanges: [ExchangeItemAdapter], Void)?
    
    func spyExchanges() {
        viewModel.exchangeItemAdapters.bind({ exchanges in
            self.invokedShowExchanges = true
            self.invokedShowExchangesCount += 1
            self.invokedShowExchangesParameters = (exchanges, ())
        })
    }
    
    private(set) var invokedShowLoading = false
    private(set) var invokedShowLoadingCount = 0
    private(set) var invokedRemoveLoading = false
    private(set) var invokedRemoveLoadingCount = 0
    
    func spyLoading() {
        viewModel.isLoading.bind({ isOn in
            if isOn {
                self.invokedShowLoading = true
                self.invokedShowLoadingCount += 1
            } else {
                self.invokedRemoveLoading = true
                self.invokedRemoveLoadingCount += 1
            }
        })
    }
    
    private(set) var invokedShowError = false
    private(set) var invokedShowErrorCount = 0
    private(set) var invokedShowErrorParameters: (message: String, Void)?
    
    func spyError() {
        viewModel.onError.bind({ message in
            self.invokedShowError = true
            self.invokedShowErrorCount += 1
            self.invokedShowErrorParameters = (message, ())
        })
    }
    
}

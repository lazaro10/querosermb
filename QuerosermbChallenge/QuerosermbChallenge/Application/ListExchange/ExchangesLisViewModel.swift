//
//  ExchangesLisViewModel.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 13/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

import UIKit

final class ExchangesLisViewModel {
    
    var exchangeItemAdapters = Dynamic([ExchangeItemAdapter]())
    var isLoading = Dynamic(Bool())
    var onError = Dynamic(String())
    
    private let exchangeGateway: ExchangeGateway
    
    init(exchangeGatway: ExchangeGateway) {
        self.exchangeGateway = exchangeGatway
    }
    
    func loadExchanges() {
        isLoading.value = true
        
        exchangeGateway.exchanges(onSuccess: { [weak self] exchanges in
            let adpters = exchanges.map(ExchangeItemAdapter.init)
            self?.exchangeItemAdapters.value = adpters
            self?.loadExchangeIcons()
            self?.isLoading.value = false
        }) { [weak self] error in
            self?.onError.value = error.localizedDescription
            self?.isLoading.value = false
        }
    }
    
    private func loadExchangeIcons() {
        exchangeGateway.icons { [weak self] (icons) in
            guard let exchangeItemAdapters = self?.exchangeItemAdapters.value else { return }
            
            self?.exchangeItemAdapters.value = exchangeItemAdapters.map { exchangeAdapter in
                let exchangeIcon = icons.first { exchangeIcon -> Bool in
                    exchangeAdapter.exchangeId == exchangeIcon.exchangeId
                }
                return ExchangeItemAdapter(entity: exchangeIcon, adapter: exchangeAdapter)
            }
        }
    }
    
}



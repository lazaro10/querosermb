//
//  ExchangesLisViewModelSpec.swift
//  QuerosermbChallengeTests
//
//  Created by Lazaro on 19/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

import Quick
import Nimble

@testable import QuerosermbChallenge

final class ExchangesLisViewModelSpec: QuickSpec {
    var gateway: ExchangeGatewayMock!
    var spy: ExchangesLisViewModelSpy!
    var sut: ExchangesLisViewModel!
    
    var exchanges: [Exchange] {
        let result = gateway.stubbedExchangesOnSuccessResult?.0
        
        return result!
    }
    
    var exchangesAdapters: [ExchangeItemAdapter] {
        return self.spy.invokedShowExchangesParameters!.exchanges
    }
    
    func setupExchanges() {
        gateway = ExchangeGatewayMock(exchanges: ExchangesMock.exchanges!,
                                      exchangesIcon: ExchangesMock.icons!)
        sut = ExchangesLisViewModel(exchangeGatway: gateway)
        spy = ExchangesLisViewModelSpy(viewModel: sut)
    }
    
    func setupEmptyExchanges() {
        gateway = ExchangeGatewayMock(exchanges: [], exchangesIcon: [])
        sut = ExchangesLisViewModel(exchangeGatway: gateway)
        spy = ExchangesLisViewModelSpy(viewModel: sut)
    }
    
    func setupErrorExchanges() {
        gateway = ExchangeGatewayMock(error: .offline)
        sut = ExchangesLisViewModel(exchangeGatway: gateway)
        spy = ExchangesLisViewModelSpy(viewModel: sut)
    }
    
    override func spec() {
        describe("loadExchanges") {
            context("When exchanges are loaded successfully") {
                beforeEach {
                    self.setupExchanges()
                    self.sut.loadExchanges()
                }
                
                it("should display loading") {
                    expect(self.spy.invokedShowLoading).to(equal(true))
                }
                
                it("should display loading only once") {
                    expect(self.spy.invokedShowLoadingCount).to(equal(1))
                }
                
                it("should call the gateway method that loads the exchange list") {
                    expect(self.spy.invokedShowExchanges).to(equal(true))
                }
                
                it("should have twenty-eight exchanges on the list") {
                    expect(self.exchanges.count).to(equal(28))
                }
                
                it("twenty-eight exchanges should be shown in the list") {
                    expect(self.exchangesAdapters.count).to(equal(28))
                }
                
                it("The loading should be removed from the screen") {
                    expect(self.spy.invokedRemoveLoading).to(equal(true))
                }
                
                it("The loading should be removed from the screen only once") {
                    expect(self.spy.invokedRemoveLoadingCount).to(equal(1))
                }
            }
            
            context("When exchanges are loaded with an empty list") {
                beforeEach {
                    self.setupEmptyExchanges()
                    self.sut.loadExchanges()
                }
                
                it("should display loading") {
                    expect(self.spy.invokedShowLoading).to(equal(true))
                }
                
                it("should display loading only once") {
                    expect(self.spy.invokedShowLoadingCount).to(equal(1))
                }
                
                it("should call the gateway method that loads the exchange list") {
                    expect(self.spy.invokedShowExchanges).to(equal(true))
                }
                
                it("should call the gateway method that loads the exchange list only once") {
                    expect(self.spy.invokedShowLoadingCount).to(equal(1))
                }
                
                it("There should be no exchange") {
                    expect(self.exchanges.count).to(equal(0))
                }
                
                it("None exchanges should be shown in the list") {
                    expect(self.exchangesAdapters.count).to(equal(0))
                }
                
                it("The loading should be removed from the screen") {
                    expect(self.spy.invokedRemoveLoading).to(equal(true))
                }
                
                it("The loading should be removed from the screen only once") {
                    expect(self.spy.invokedRemoveLoadingCount).to(equal(1))
                }
            }
            
            context("When exchanges are not loaded") {
                beforeEach {
                    self.setupErrorExchanges()
                    self.sut.loadExchanges()
                }
                
                it("should display loading") {
                    expect(self.spy.invokedShowLoading).to(equal(true))
                }
                
                it("should display loading only once") {
                    expect(self.spy.invokedShowLoadingCount).to(equal(1))
                }
                
                it("should call the gateway method that loads the exchange list only once") {
                    expect(self.spy.invokedShowLoadingCount).to(equal(1))
                }
                
                it("An error should be shown") {
                    expect(self.spy.invokedShowError).to(equal(true))
                }
                
                it("An error should be shown only once") {
                    expect(self.spy.invokedShowErrorCount).to(equal(1))
                }
                
                it("the error message should be `You are currently offline.`") {
                    let message = self.spy.invokedShowErrorParameters?.message
                    expect(message).to(equal("You are currently offline."))
                }
                
                it("The loading should be removed from the screen") {
                    expect(self.spy.invokedRemoveLoading).to(equal(true))
                }
                
                it("The loading should be removed from the screen only once") {
                    expect(self.spy.invokedRemoveLoadingCount).to(equal(1))
                }
            }
        }
        
    }
    
}

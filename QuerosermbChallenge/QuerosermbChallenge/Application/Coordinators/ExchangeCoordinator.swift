//
//  ExchangeCoordinator.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 13/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

import UIKit

final class ExchangeCoordinator {

    private lazy var exchangesListViewController: ExchangesListScene = {
        let viewController = ExchangesListScene(gateway: gateway, delegate: self)
        viewController.title = R.string.navigationBar.exchangeList()
        
        return viewController
    }()
    
    private var exchangeDetailViewController: ExchangeDetailViewController?
    
    private let navigationController: UINavigationController
    private let gateway: ExchangeGateway

    init(navigationController: UINavigationController, gateway: ExchangeGateway) {
        self.navigationController = navigationController
        self.gateway = gateway
    }

}

extension ExchangeCoordinator: Coordinator {
    func start() {
        navigationController.pushViewController(exchangesListViewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangesListViewDelegate {
    
    func didSelect(viewModel: ExchangeViewModel) {
        exchangeDetailViewController = ExchangeDetailViewController()
        exchangeDetailViewController?.viewModel = viewModel
        
        guard let viewController = exchangeDetailViewController else { return }
        
        if #available(iOS 13.0, *) {
            navigationController.present(viewController, animated: true)
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
}

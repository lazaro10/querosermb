//
//  ExchangesListViewController.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 13/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

import UIKit

final class ExchangesListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: ExchangesListDataSource = {
        let dataSource = ExchangesListDataSource(tableView: tableView)
    
        return dataSource
    }()
    
    private let viewModel: CurrenciesListViewModel
    
    // MARK: Initializer
    
    init(viewModel: CurrenciesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
        
        setupView()
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        exchanges()
    }
    
    // MARK: Private functions
    
    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.exchangesViewModel.bind { (exchanges) in
            DispatchQueue.main.async { [weak self] in
                self?.dataSource.viewModels = exchanges
            }
        }
    }
    
    private func exchanges() {
        viewModel.fetchExchanges()
    }
}

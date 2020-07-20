//
//  ExchangesListViewController.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 13/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class ExchangesListViewController: UIViewController {
    
    private let tableView  = UITableView()
    private let snakeBarErrorView = SnakeBarErrorView()
    private let loadingView = NVActivityIndicatorView(frame: .zero)
    
    private lazy var dataSource: ExchangesListDataSource = {
        let completion: ExchangesListDataSource.CompletionHandler = { [weak self] in
            self?.didSelect(adapter: $0)
        }
        
        let completionRefresh: ExchangesListDataSource.CompletionHandlerRefresh = { [weak self] in
            self?.loadExchanges()
        }
        
        let dataSource = ExchangesListDataSource(tableView: tableView,
                                                 completion: completion,
                                                 completionRefresh: completionRefresh)
    
        return dataSource
    }()
    
    private let viewModel: ExchangesLisViewModel
    private let delegate: ExchangesListViewDelegate
    
    // MARK: Initializer
    
    init(viewModel: ExchangesLisViewModel, delegate: ExchangesListViewDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
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
        loadExchanges()
    }
    
    // MARK: Private functions
    
    private func setupView() {
        view.accessibilityLabel = R.string.accessibilityLabels.exchangeList()
    }
    
    private func setupLayout() {
        view.addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(snakeBarErrorView)
        
        view.addSubview(loadingView, constraints: [
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func bindViewModel() {
        viewModel.exchangeItemAdapters.bind({ [weak self] exchanges in
            DispatchQueue.main.async {
                self?.dataSource.adapters = exchanges
            }
        })
        
        viewModel.isLoading.bind({ [weak self] (isOn) in
            DispatchQueue.main.async {
                let operation = isOn ? NVActivityIndicatorView.startAnimating : NVActivityIndicatorView.stopAnimating
                operation(self!.loadingView)()
            }
        })
        
        viewModel.onError.bind({ [weak self] (message) in
            DispatchQueue.main.async {
                self?.snakeBarErrorView.show(message)
            }
        })
    }
    
    private func loadExchanges() {
        viewModel.loadExchanges()
    }
    
    private func didSelect(adapter: ExchangeItemAdapter) {
        delegate.didSelect(adapter: adapter)
    }
}

//
//  CurrencySelectionViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/16.
//

import UIKit

class CurrencySelectionViewController: UIViewController {
    
    let currencyManger = CurrencyManager.shared
    var currencyArrays: [Currency] = []
    
    private let selectionTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(selectionTable)
        setupData()
        setupSelectionTable()
//        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        selectionTable.frame = view.bounds
    }
    
    private func setupData() {
        currencyArrays = currencyManger.getCurrencyArraysFromAPI()
    }
    
    private func setupSelectionTable() {
        view.addSubview(selectionTable)
        selectionTable.register(CurrencySelectionTableViewCell.self, forCellReuseIdentifier: CurrencySelectionTableViewCell.identifier)
        selectionTable.delegate = self
        selectionTable.dataSource = self
    }
    
    private func applyConstraints() {
        let selectionTableConstraints = [
            selectionTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectionTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectionTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            selectionTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(selectionTableConstraints)
    }
}

extension CurrencySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = selectionTable.dequeueReusableCell(withIdentifier: CurrencySelectionTableViewCell.identifier, for: indexPath) as? CurrencySelectionTableViewCell else {
            return UITableViewCell()
        }
        
        var currency = currencyArrays[indexPath.row]
        currency.country = currency.country ?? currency.countryName
        cell.currency = currency
        
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

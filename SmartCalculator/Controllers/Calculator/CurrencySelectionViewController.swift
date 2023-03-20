//
//  CurrencySelectionViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/16.
//

import UIKit

class CurrencySelectionViewController: UIViewController {
    var completion: ((Int) -> Void)?
    
    let currencyManger = CurrencyManager.shared
    var currencyArrays: [Currency] = []
    var filteredContents: [Currency] = []
    var searchTimer: Timer?
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "국가 또는 통화명을 입력해 주세요"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let selectionTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(selectionTable)
        setupSearchBar()
        setupData()
        setupSelectionTable()
        configureNavBar()
        applyConstraints()
    }
    
    private func setupData() {
        currencyArrays = currencyManger.getCurrencyArraysFromAPI()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
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
    
    private func configureNavBar() {
        let textLabel = UILabel()
        textLabel.textColor = UIColor.label
        textLabel.text = "환율선택"
        textLabel.font = UIFont.Pretendard(.semiaBold, size: 15)
        self.navigationItem.titleView = textLabel
    }
}

extension CurrencySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredContents.count
        } else {
            return currencyArrays.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = selectionTable.dequeueReusableCell(withIdentifier: CurrencySelectionTableViewCell.identifier, for: indexPath) as? CurrencySelectionTableViewCell else {
            return UITableViewCell()
        }

        
        var currency = searchController.isActive ? filteredContents[indexPath.row] :  currencyArrays[indexPath.row]
        
        currency.country = currency.country ?? currency.countryName
        cell.currency = currency
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(indexPath.row)
        navigationController?.popViewController(animated: true)
    }
}

extension CurrencySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchController.searchBar.text ?? ""
        // 디바운싱 적용
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.search(for: searchText)
        })
        
    }
    
    func search(for searchText: String) {
        if searchText.isEmpty {
            filteredContents = currencyArrays
        } else {
            filteredContents = currencyArrays.filter({
                guard let country = $0.country, let currencyCode = $0.currencyCode else { return false }
                return country.lowercased().contains(searchText.lowercased()) || currencyCode.lowercased().contains(searchText.lowercased())
            })
        }
        selectionTable.reloadData()
    }
    
}

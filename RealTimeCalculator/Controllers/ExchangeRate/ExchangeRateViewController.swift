//
//  ExchangeRateViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class ExchangeRateViewController: UIViewController {
    
    let currencyFetcher = CurrencyFetcher.shared
    var currencyArrays: [Currency] = []
    var filteredContents: [Currency] = []
    var searchTimer: Timer?
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "국가 또는 통화명을 입력해 주세요"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // ExchangeRateViewController가 생성 된 후 변수 접근시 초기화 (self.compositionalLayout)
    lazy var exchangeRatecollectionVeiw: UICollectionView = {
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0 / 10.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    let exchangeRateCollectionViewHeader: UIStackView = {
        let stackView = ExchangeRateCollectionViewHeader(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(exchangeRateCollectionViewHeader)
        view.addSubview(exchangeRatecollectionVeiw)
        setupData()
        configureNavBar()
        setupSearchBar()
        setupCollectionView()
        applyConstraints()
    }
    
    private func setupData() {
        currencyArrays = currencyFetcher.getCurrencyArraysFromAPI()
        filteredContents = currencyArrays
    }
    
    private func setupCollectionView() {
        exchangeRatecollectionVeiw.dataSource = self
        exchangeRatecollectionVeiw.delegate = self
        exchangeRatecollectionVeiw.register(ExchangeRateCollectionViewCell.self, forCellWithReuseIdentifier: ExchangeRateCollectionViewCell.identifier)
    }
    
    private func applyConstraints() {
        let exchangeRateCollectionViewHeaderConstraints = [
            exchangeRateCollectionViewHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            exchangeRateCollectionViewHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            exchangeRateCollectionViewHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ]

        let exchangeRatecollectionVeiwConstraints = [
            exchangeRatecollectionVeiw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            exchangeRatecollectionVeiw.topAnchor.constraint(equalTo: exchangeRateCollectionViewHeader.bottomAnchor),
            exchangeRatecollectionVeiw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            exchangeRatecollectionVeiw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(exchangeRateCollectionViewHeaderConstraints)
        NSLayoutConstraint.activate(exchangeRatecollectionVeiwConstraints)
    }
    
    private func configureNavBar() {
        let label = UILabel()
        label.textColor = UIColor.label
        if !currencyArrays.isEmpty {
            if let date = currencyArrays[1].date, let time = currencyArrays[1].time {
                label.text = date + " " + time + " " + "기준"
            }
        }
        label.font = UIFont.Pretendard(.medium, size: 13)
        self.navigationItem.titleView = label
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .label
    }
    
}

extension ExchangeRateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredContents.count
        } else {
            return currencyArrays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = exchangeRatecollectionVeiw.dequeueReusableCell(withReuseIdentifier: ExchangeRateCollectionViewCell.identifier, for: indexPath) as? ExchangeRateCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var currency = searchController.isActive ? filteredContents[indexPath.row] :  currencyArrays[indexPath.row]
        currency.country = currency.country ?? currency.countryName
        cell.currency = currency
        
        return cell
    }
}

extension ExchangeRateViewController: UISearchBarDelegate { 
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
        exchangeRatecollectionVeiw.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredContents = currencyArrays
        exchangeRatecollectionVeiw.reloadData()
    }
}

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
    
    private lazy var exchangeRatecollectionVeiw: UICollectionView = {
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
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
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
        setupCollectionView()
        applyConstraints()
    }
    
    private func setupData() {
        currencyArrays = currencyFetcher.getCurrencyArraysFromAPI()
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
    
}

extension ExchangeRateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencyArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exchangeRatecollectionVeiw.dequeueReusableCell(withReuseIdentifier: ExchangeRateCollectionViewCell.identifier, for: indexPath) as! ExchangeRateCollectionViewCell
        
        var currency = currencyArrays[indexPath.row]
        currency.country = currency.country ?? currency.countryName
        
        cell.currency = currency
        
        return cell
    }
}

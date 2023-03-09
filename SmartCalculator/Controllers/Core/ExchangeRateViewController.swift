//
//  ExchangeRateViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class ExchangeRateViewController: UIViewController {
    
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(exchangeRatecollectionVeiw)
        setupCollectionView()
        configureLayout()
    }
    
    private func setupCollectionView() {
        exchangeRatecollectionVeiw.dataSource = self
        exchangeRatecollectionVeiw.delegate = self
        exchangeRatecollectionVeiw.register(ExchangeRateCollectionViewCell.self, forCellWithReuseIdentifier: ExchangeRateCollectionViewCell.identifier)
    }
    
    private func configureLayout() {
        let exchangeRatecollectionVeiwConstraints = [
            exchangeRatecollectionVeiw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            exchangeRatecollectionVeiw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exchangeRatecollectionVeiw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            exchangeRatecollectionVeiw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(exchangeRatecollectionVeiwConstraints)
    }
    
    
}

extension ExchangeRateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currencyArrays = CurrencyManager.shared.getCurrencyArraysFromAPI()
        let cell = exchangeRatecollectionVeiw.dequeueReusableCell(withReuseIdentifier: ExchangeRateCollectionViewCell.identifier, for: indexPath) as! ExchangeRateCollectionViewCell
        cell.currency = currencyArrays[0]
        
        return cell
    }
}

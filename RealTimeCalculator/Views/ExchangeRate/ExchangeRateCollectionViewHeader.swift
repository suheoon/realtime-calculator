//
//  ExchangeRateIndicatorView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/13.
//

import UIKit

final class ExchangeRateCollectionViewHeader: UIStackView {

    let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "통화명"
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.Pretendard(.bold, size: 14)
        
        return label
    }()
    
    let tradingStandardRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "매매기준율"
        label.textColor = .label
        label.font = UIFont.Pretendard(.bold, size: 14)
        
        return label
    }()
    
    let netChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전일대비"
        label.textColor = .label
        label.font = UIFont.Pretendard(.bold, size: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIStackView()
        configureUI()
        applyConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 15
        self.axis = .horizontal
    }
    
    private func configureUI() {        
        self.addArrangedSubview(currencyNameLabel)
        self.addArrangedSubview(tradingStandardRateLabel)
        self.addArrangedSubview(netChangeLabel)
    }
    
    private func applyConstraints() {
        currencyNameLabel.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 2).isActive = true
    }
}

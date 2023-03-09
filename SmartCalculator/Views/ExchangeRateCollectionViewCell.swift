//
//  ExchangeRateCollectionViewCell.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/09.
//

import UIKit

final class ExchangeRateCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExchangeRateCollectionViewCell"
    
    var currency: Currency? {
        didSet {
            configureUIWithData()
        }
    }
    
    let horizonalStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    let nationalFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image =  UIImage(named: "USD")?.resize(targetSize: CGSize(width: 60 , height: 60))
        
        return imageView
    }()
    
    lazy var currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(horizonalStackVeiw)
        applyConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        horizonalStackVeiw.addArrangedSubview(nationalFlag)
        horizonalStackVeiw.addArrangedSubview(currencyName)
    }
    
    private func configureUIWithData() {
        currencyName.text = currency?.currencyCode
    }
    
    private func applyConstraints() {
        let horizonalStackVeiwConstraints = [
            horizonalStackVeiw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            horizonalStackVeiw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(horizonalStackVeiwConstraints)
    }
}

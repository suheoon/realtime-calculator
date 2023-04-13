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
    
    let containerStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    let currencyNamehoriziontalStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    let currencyNameVerticalStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .leading
        
        return stackView
    }()
    
    let priceChangeVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .center
        
        return stackView
    }()
    
    let nationalFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.regular, size: 15)
        
        return label
    }()
    
    let coutnryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.regular, size: 13)
        
        return label
    }()
    
    let basePriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.Pretendard(.regular, size: 12)
        
        return label
    }()
    
    let changePriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.medium, size: 12)
        
        return label
    }()
    
    let changeRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.regular, size: 12)
        
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.addBorder(.top, color: .gray, thickness: 0.3)
        view.addBorder(.bottom, color: .gray, thickness: 0.3)
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerStackVeiw)
        contentView.addSubview(separatorView)
        applyConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        separatorView.frame = CGRect(x: 0, y: contentView.bounds.maxY - 1, width: contentView.bounds.width, height: 1)
    }
    
    private func configureUI() {
        currencyNameVerticalStackVeiw.addArrangedSubview(currencyCodeLabel)
        currencyNameVerticalStackVeiw.addArrangedSubview(coutnryLabel)
    
        currencyNamehoriziontalStackVeiw.addArrangedSubview(nationalFlag)
        currencyNamehoriziontalStackVeiw.addArrangedSubview(currencyNameVerticalStackVeiw)
        
        priceChangeVerticalStackView.addArrangedSubview(changePriceLabel)
        priceChangeVerticalStackView.addArrangedSubview(changeRateLabel)
        
        containerStackVeiw.addArrangedSubview(currencyNamehoriziontalStackVeiw)
        containerStackVeiw.addArrangedSubview(basePriceLabel)
        containerStackVeiw.addArrangedSubview(priceChangeVerticalStackView)
    }
    
    private func configureUIWithData() {
        if let currencyCode = currency?.currencyCode {
            currencyCodeLabel.text = currencyCode
            setImage(currencyCode)
        }
        if let basePrice = currency?.basePrice {
            basePriceLabel.text = String(format: "%.2f", basePrice)
        }
        
        if let country = currency?.country {
            coutnryLabel.text = country
        }
        
        if let change = currency?.change ,let changeRate = currency?.changeRate, let changePrice = currency?.changePrice {
            if change == "RISE" {
                changeRateLabel.textColor = .systemRed
                changePriceLabel.textColor = .systemRed
                changeRateLabel.text =  "(+" + String(format: "%.2f", changeRate) + "%)"
                changePriceLabel.text = "▲" + String(format: "%.2f", changePrice)
            }
            if change == "FALL" {
                changeRateLabel.textColor = .systemBlue
                changePriceLabel.textColor = .systemBlue
                changeRateLabel.text = "(-" + String(format: "%.2f", changeRate) + "%)"
                changePriceLabel.text = "▼" + String(format: "%.2f", changePrice)
            }
            if change == "EVEN" {
                changeRateLabel.textColor = .label
                changePriceLabel.textColor = .label
                changeRateLabel.text = "(" + String(format: "%.2f", changeRate) + "%)"
                changePriceLabel.text = String(format: "%.2f", changePrice)
            }
        }
    }
    
    private func applyConstraints() {
        nationalFlag.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nationalFlag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currencyNamehoriziontalStackVeiw.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 2).isActive = true
        
        let containerStackVeiwConstraints = [
            containerStackVeiw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStackVeiw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStackVeiw.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(containerStackVeiwConstraints)
    }
    
    private func setImage(_ name: String) {
        let image = UIImage(named: name)
        nationalFlag.image = image
    }
}

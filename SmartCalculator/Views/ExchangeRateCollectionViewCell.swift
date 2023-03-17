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
    
    let horiziontalStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    let verticalStackVeiw1: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .leading
        
        return stackView
    }()
    
    let verticalStackVeiw2: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .center
        
        return stackView
    }()
    
    let nationalFlag: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 30, 20))
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        separatorView.frame = CGRect(x: 0, y: contentView.bounds.maxY - 1, width: contentView.bounds.width, height: 1)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nationalFlag.image = nil
        currencyCodeLabel.text = nil
        basePriceLabel.text = nil
        changeRateLabel.text = nil
        changePriceLabel.text = nil
    }
    
    private func configureUI() {
        verticalStackVeiw1.addArrangedSubview(currencyCodeLabel)
        verticalStackVeiw1.addArrangedSubview(coutnryLabel)
    
        horiziontalStackVeiw.addArrangedSubview(nationalFlag)
        horiziontalStackVeiw.addArrangedSubview(verticalStackVeiw1)
        
        verticalStackVeiw2.addArrangedSubview(changePriceLabel)
        verticalStackVeiw2.addArrangedSubview(changeRateLabel)
        
        containerStackVeiw.addArrangedSubview(horiziontalStackVeiw)
        containerStackVeiw.addArrangedSubview(basePriceLabel)
        containerStackVeiw.addArrangedSubview(verticalStackVeiw2)
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
        horiziontalStackVeiw.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 2).isActive = true
        
        let containerStackVeiwConstraints = [
            containerStackVeiw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStackVeiw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStackVeiw.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(containerStackVeiwConstraints)
    }
    
    func setImage(_ name: String) {
        let cacheKey = NSString(string: name)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            nationalFlag.image = cachedImage
            return
        }
        
        guard let svgImage = UIImage(named: name)?.resize(targetSize: nationalFlag.frame.size) else { return }
        let renderer = UIGraphicsImageRenderer(size: svgImage.size)
        let image = renderer.image { context in
            svgImage.draw(in: CGRect(origin: .zero, size: svgImage.size))
        }
        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
        nationalFlag.image = image
    }
}

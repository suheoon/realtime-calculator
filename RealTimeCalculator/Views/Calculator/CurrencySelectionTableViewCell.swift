//
//  CurrencySelectionTableViewCell.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/17.
//

import UIKit

final class CurrencySelectionTableViewCell: UITableViewCell {
    
    var currency: Currency? {
        didSet {
            configureUIWithData()
        }
    }
    
    static let identifier = "CurrencySelectionTableViewCell"
    
    let containerStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    let countryHoriziontalStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    let nationalFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let coutnryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.regular, size: 13)
        
        return label
    }()
    
    let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.Pretendard(.regular, size: 15)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerStackVeiw)
        applyConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let spaceView1 = UIView()
        let spaceView2 = UIView()
        
        countryHoriziontalStackVeiw.addArrangedSubview(nationalFlag)
        countryHoriziontalStackVeiw.addArrangedSubview(coutnryLabel)
        countryHoriziontalStackVeiw.addArrangedSubview(spaceView1)
        
        spaceView1.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        containerStackVeiw.addArrangedSubview(countryHoriziontalStackVeiw)
        containerStackVeiw.addArrangedSubview(currencyCodeLabel)
        containerStackVeiw.addArrangedSubview(spaceView2)
        
        spaceView2.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private func applyConstraints() {
        countryHoriziontalStackVeiw.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 5 * 4).isActive = true
        
        nationalFlag.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nationalFlag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let containerStackVeiwConstraints = [
            containerStackVeiw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStackVeiw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackVeiw.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerStackVeiw.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(containerStackVeiwConstraints)
    }
    
    private func configureUIWithData() {
        if let currencyCode = currency?.currencyCode {
            currencyCodeLabel.text = currencyCode
            setImage(currencyCode)
        }

        if let country = currency?.country {
            coutnryLabel.text = country
        }
    }
    
    private func setImage(_ name: String) {
        let image = UIImage(named: name)
        nationalFlag.image = image
    }
    
    
}

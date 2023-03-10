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
        let imageView = UIImageView(frame: CGRectMake(0, 0, 50, 30))
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image =  UIImage(named: "BRL")?.resize(targetSize: imageView.frame.size)
        
        return imageView
    }()
    
    lazy var currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        
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
        contentView.addSubview(horizonalStackVeiw)
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
            horizonalStackVeiw.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(horizonalStackVeiwConstraints)
    }
}

//
//  CurrencySelectionTableViewCell.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/17.
//

import UIKit

class CurrencySelectionTableViewCell: UITableViewCell {
    
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
    
    let nationalFlag: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 30, 20))
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
        configureUI()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        horiziontalStackVeiw.addArrangedSubview(nationalFlag)
        horiziontalStackVeiw.addArrangedSubview(coutnryLabel)
        
        containerStackVeiw.addArrangedSubview(horiziontalStackVeiw)
        containerStackVeiw.addArrangedSubview(currencyCodeLabel)
    }
    
    private func applyConstraints() {
        let containerStackVeiwConstraints = [
            containerStackVeiw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStackVeiw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStackVeiw.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStackVeiw.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nationalFlag.image = nil
    }
    
}

//
//  CalculatorUIView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorUIStackView: UIStackView {
    
    let buttonSize: CGFloat = UIScreen.main.bounds.width / 4
    
    let horizonalStacVeiw1: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let horizonalStacVeiw2: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let horizonalStacVeiw3: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let horizonalStacVeiw4: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        self.addArrangedSubview(horizonalStacVeiw4)
        self.addArrangedSubview(horizonalStacVeiw3)
        self.addArrangedSubview(horizonalStacVeiw2)
        self.addArrangedSubview(horizonalStacVeiw1)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureUI() {
        self.spacing = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        
        let title1 = ["0", ".", "C", "+"]
        let title2 = ["1", "2", "3", "-"]
        let title3 = ["4", "5", "6", "÷"]
        let title4 = ["7", "8", "9", "×"]
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            if i == 2 {
                let image = UIImage(systemName: "delete.left")?.withRenderingMode(.alwaysTemplate)
                button.setImage(image, for: .normal)
                button.imageView?.tintColor = .label
            } else {
                button.setTitle(title1[i], for: .normal)
                button.setTitleColor(.label, for: .normal)
            }
//            button.addTarget(self, action: <#T##Selector#>, for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            horizonalStacVeiw1.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title2[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            horizonalStacVeiw2.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title3[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            horizonalStacVeiw3.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title4[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            horizonalStacVeiw4.addArrangedSubview(button)
        }
    }
    
}

//
//  CalculatorUIView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorUIStackView: UIStackView {
    
    let screenHight: CGFloat = UIScreen.main.bounds.height
    let screenWidth: CGFloat = UIScreen.main.bounds.width
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIStackView()
        configureFromDisplayUI()
        configureToDisplayUI()
        configureButtonUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fillEqually
        self.alignment = .center
        self.spacing = 0
        self.axis = .vertical
    }
    
    private func configureButtonUI() {
        let title1 = ["0", ".", "C", "+"]
        let title2 = ["1", "2", "3", "-"]
        let title3 = ["4", "5", "6", "÷"]
        let title4 = ["7", "8", "9", "×"]
        
        let horizonalStacVeiw1: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
        let horizonalStacVeiw2: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
        let horizonalStacVeiw3: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
        let horizonalStacVeiw4: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
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
//            button.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw1.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title2[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw2.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title3[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw3.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title4[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw4.addArrangedSubview(button)
        }
        
        self.addArrangedSubview(horizonalStacVeiw4)
        self.addArrangedSubview(horizonalStacVeiw3)
        self.addArrangedSubview(horizonalStacVeiw2)
        self.addArrangedSubview(horizonalStacVeiw1)
    }
    
    // from UI설정
    private func configureFromDisplayUI() {
        let horizonalStacVeiw: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fillProportionally
            
            return stackView
        }()
        
        let view1: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.top, color: .gray, thickness: 0.3)
//            view.addBorder(.right, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            view.addBorder(.left, color: .gray, thickness: 0.3)
            
            let horizonalStacVeiw: UIStackView = {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.spacing = 5
                stackView.alignment = .center
                
                return stackView
            }()
                        
            // from 버튼
            let fromSelectButton: UIButton = {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle("KRW ", for: .normal)
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                button.tintColor = .label
                button.setTitleColor(.label, for: .normal)
                button.setPreferredSymbolConfiguration(.init(pointSize: 13), forImageIn: .normal)
                button.semanticContentAttribute = .forceRightToLeft
//                button.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
                return button
            }()
            
            horizonalStacVeiw.addArrangedSubview(fromSelectButton)
            view.addSubview(horizonalStacVeiw)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            horizonalStacVeiw.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }()
        
        let view2: UIView = {
            let view = UIView()
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0"
                label.textColor = .label
                label.textAlignment = .right
                label.font = label.font.withSize(25)
                
                return label
            }()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.top, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            view.addBorder(.right, color: .gray, thickness: 0.3)
            view.addSubview(label)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            label.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3 - 40).isActive = true
            
            return view
        }()
        
        horizonalStacVeiw.addArrangedSubview(view1)
        horizonalStacVeiw.addArrangedSubview(view2)
        
        self.addArrangedSubview(horizonalStacVeiw)
    }
    
    // TO UI설정
    private func configureToDisplayUI() {
        let horizonalStacVeiw: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
        let view1: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
//            view.addBorder(.right, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.5)
            view.addBorder(.left, color: .gray, thickness: 0.3)
            
            let horizonalStackVeiw: UIStackView = {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.spacing = 5
                stackView.distribution = .fillProportionally
                
                return stackView
            }()
                      
            // to버튼
            let button: UIButton = {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle("KRW ", for: .normal)
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                button.tintColor = .label
                button.setTitleColor(.label, for: .normal)
                button.setPreferredSymbolConfiguration(.init(pointSize: 13), forImageIn: .normal)
                button.semanticContentAttribute = .forceRightToLeft
//                button.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
                return button
            }()
            
            horizonalStackVeiw.addArrangedSubview(button)
            
            view.addSubview(horizonalStackVeiw)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStackVeiw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            horizonalStackVeiw.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }()
        
        let view2: UIView = {
            let view = UIView()
            view.addBorder(.bottom, color: .gray, thickness: 0.5)
            view.addBorder(.right, color: .gray, thickness: 0.5)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0"
                label.textColor = .label
                label.textAlignment = .right
                label.font = label.font.withSize(25)
                
                return label
            }()
            
            view.addSubview(label)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3).isActive = true
            label.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3 - 40).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            return view
        }()
        
        horizonalStacVeiw.addArrangedSubview(view1)
        horizonalStacVeiw.addArrangedSubview(view2)
        self.addArrangedSubview(horizonalStacVeiw)
    }
        
    
}

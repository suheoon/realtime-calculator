//
//  CalculatorUIView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

protocol ButtonDelegate: AnyObject {
    func selectionButtonTapped(_ sender: UIButton)
    func tapCalculatorButton(_ sender: UIButton)
    func clearAll(_ sender: UIButton)
}

enum CalculatorButtonType: Int {
    case zero, dot, delete, plus
    case one, two, three, minus
    case four, five, six, divide
    case seven, eight, nine, multiply
}

final class CalculatorUIStackView: UIStackView {    
    var working: String = ""
    
    weak var delegate: ButtonDelegate?
    
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
        
        let horizonalStackVeiw1: UIStackView = {
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
                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(clearAll(_:)))
                button.addGestureRecognizer(longPress)
            } else {
                button.setTitle(title1[i], for: .normal)
                button.titleLabel?.font = UIFont.Pretendard(.medium, size: 18)
                button.setTitleColor(.label, for: .normal)
            }
            button.tag = i
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.addTarget(self, action: #selector(tapCalculatorButton(_:)), for: .touchUpInside)
            horizonalStackVeiw1.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title2[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.Pretendard(.medium, size: 18)
            button.tag = i + 4
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.addTarget(self, action: #selector(tapCalculatorButton(_:)), for: .touchUpInside)
            horizonalStacVeiw2.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title3[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.Pretendard(.medium, size: 18)
            button.tag = i + 8
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.addTarget(self, action: #selector(tapCalculatorButton(_:)), for: .touchUpInside)
            horizonalStacVeiw3.addArrangedSubview(button)
        }
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setTitle(title4[i], for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.Pretendard(.medium, size: 18)
            button.tag = i + 12
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.addTarget(self, action: #selector(tapCalculatorButton(_:)), for: .touchUpInside)
            horizonalStacVeiw4.addArrangedSubview(button)
        }
        
        self.addArrangedSubview(horizonalStacVeiw4)
        self.addArrangedSubview(horizonalStacVeiw3)
        self.addArrangedSubview(horizonalStacVeiw2)
        self.addArrangedSubview(horizonalStackVeiw1)
    }
    
    // from UI설정
    private func configureFromDisplayUI() {
        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fillProportionally
            
            return stackView
        }()
        
        let currencySelectionView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.top, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            
            let button: UIButton = {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle("KRW ", for: .normal)
                button.titleLabel?.font = UIFont.Pretendard(.medium, size: 16)
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                button.tintColor = .label
                button.setTitleColor(.label, for: .normal)
                button.setPreferredSymbolConfiguration(.init(pointSize: 13), forImageIn: .normal)
                button.semanticContentAttribute = .forceRightToLeft
                button.tag = 16
                button.addTarget(self, action: #selector(selectionButtonTapped(_:)), for: .touchUpInside)
                return button
            }()
            
            view.addSubview(button)
            
            view.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }()
        
        let numberDisplayView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.top, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            
            let workingLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = ""
                label.textColor = .gray
                label.textAlignment = .right
                label.font = UIFont.Pretendard(.regular, size: 20)
                label.tag = 17
                return label
            }()
            let resultLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0.00"
                label.textColor = .label
                label.textAlignment = .right
                label.font = UIFont.Pretendard(.regular, size: 25)
                label.tag = 18
                return label
            }()
            
            let verticalStackVeiw: UIStackView = {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.distribution = .fillEqually
                stackView.alignment = .fill
                stackView.spacing = 10
                stackView.axis = .vertical
                return stackView
            }()
            
            verticalStackVeiw.addArrangedSubview(workingLabel)
            verticalStackVeiw.addArrangedSubview(resultLabel)
            
            view.addSubview(verticalStackVeiw)
            
            view.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4 * 3).isActive = true
            verticalStackVeiw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            verticalStackVeiw.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            verticalStackVeiw.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            verticalStackVeiw.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4 * 3 - 40).isActive = true
            
            return view
        }()
        
        horizontalStackView.addArrangedSubview(currencySelectionView)
        horizontalStackView.addArrangedSubview(numberDisplayView)
        
        self.addArrangedSubview(horizontalStackView)
    }
    
    // TO UI설정
    private func configureToDisplayUI() {
        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fill
            
            return stackView
        }()
        
        let currencySelectionView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.bottom, color: .gray, thickness: 0.5)
            
            // to버튼
            let button: UIButton = {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle("KRW ", for: .normal)
                button.titleLabel?.font = UIFont.Pretendard(.medium, size: 16)
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                button.tintColor = .label
                button.setTitleColor(.label, for: .normal)
                button.setPreferredSymbolConfiguration(.init(pointSize: 13), forImageIn: .normal)
                button.semanticContentAttribute = .forceRightToLeft
                button.tag = 19
                button.addTarget(self, action: #selector(selectionButtonTapped(_:)), for: .touchUpInside)
                return button
            }()
            
            view.addSubview(button)
            
            view.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4).isActive = true
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }()
        
        let resultDisplayView: UIView = {
            let view = UIView()
            view.addBorder(.bottom, color: .gray, thickness: 0.5)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0.00"
                label.textColor = .label
                label.textAlignment = .right
                label.font = UIFont.Pretendard(.regular, size: 25)
                label.tag = 20
                return label
            }()
            
            view.addSubview(label)
            
            view.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4 * 3).isActive = true
            label.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 4 * 3 - 40).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            return view
        }()
        
        horizontalStackView.addArrangedSubview(currencySelectionView)
        horizontalStackView.addArrangedSubview(resultDisplayView)
        self.addArrangedSubview(horizontalStackView)
    }
    
    @objc func selectionButtonTapped(_ sender: UIButton) {
        delegate?.selectionButtonTapped(sender)
    }
    
    @objc func tapCalculatorButton(_ sender: UIButton) {
        delegate?.tapCalculatorButton(sender)
    }
    
    @objc func clearAll(_ sender: UIButton) {
        delegate?.clearAll(sender)
    }
    
}

//
//  CalculatorUIView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorUIView: UIView {
            
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let title = [["7", "8", "9", "×"],
                         ["4", "5", "6", "÷"],
                         ["1", "2", "3", "-"],
                         ["0", ".", "C", "+"]]
    
    private var buttonArr: [[UIButton]] = Array(repeating: Array(repeating: UIButton(), count: 4), count: 4)
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        for i in 0..<4 {
            for j in 0..<4 {
                let button = UIButton(type: .custom)
                button.translatesAutoresizingMaskIntoConstraints = false
                if i == 3 && j == 2 {
                    let image = UIImage(systemName: "delete.left")?.withRenderingMode(.alwaysTemplate)
                    button.setImage(image,for: .normal)
                    button.imageView?.tintColor = .label
                }
                else {
                    button.setTitle(title[i][j], for: .normal)
                }
                button.setTitleColor(.label, for: .normal)
                buttonArr[i][j] = button
                addSubview(button)
                button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            }
        }
        addSubview(resultLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in 0..<4 {
            for j in 0..<4 {
                configureButtonLayout(button: buttonArr[i][j], x: CGFloat(i), y: CGFloat(j))
            }
        }
        configureLableLayout()
    }
    
    private func configureButtonLayout(button: UIButton, x: CGFloat, y: CGFloat) {
        let windowRect = self.window?.frame
        let windowWidth = windowRect?.size.width ?? 10
        let buttonSize = windowWidth / 4
        
        let buttonConstraints = [
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1 * buttonSize * (3 - x)),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: buttonSize * y),
            button.widthAnchor.constraint(equalToConstant: buttonSize),
            button.heightAnchor.constraint(equalToConstant: buttonSize),
        ]
        
//        self.heightAnchor.constraint(equalToConstant: buttonSize * 4).isActive = true
        
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    private func configureLableLayout() {
        let windowRect = self.window?.frame
        let windowWidth = windowRect?.size.width ?? 10
        let buttonSize = windowWidth / 4
        
        let labelConstraints = [
            resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1 * 4 * buttonSize),
            resultLabel.heightAnchor.constraint(equalToConstant: buttonSize)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let title = sender.titleLabel?.text
        if (title == "1") {
            DispatchQueue.main.async {[weak self] in
                self?.resultLabel.text = "1"
            }
        }
    }
    
}

//
//  CalculatorUIView.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

enum CalculatorButtonType: Int {
    case zero, dot, delete, plus
    case one, two, three, minus
    case four, five, six, divide
    case seven, eight, nine, multiply
}

final class CalculatorUIStackView: UIStackView {
    
    // from, to currnecy를 모두 원 단위로 바꾸고 from / to 를 하면 계산가능
    
    let screenHight: CGFloat = UIScreen.main.bounds.height
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var working: String = ""
    
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
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
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
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
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
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
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
            button.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
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
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            
            let horizonalStacVeiw: UIStackView = {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.spacing = 5
                stackView.alignment = .center
                
                return stackView
            }()
            
            // from 버튼
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
                //                button.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
                return button
            }()
            
            horizonalStacVeiw.addArrangedSubview(button)
            view.addSubview(horizonalStacVeiw)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
            horizonalStacVeiw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            horizonalStacVeiw.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }()
        
        let view2: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.addBorder(.top, color: .gray, thickness: 0.3)
            view.addBorder(.bottom, color: .gray, thickness: 0.3)
            
            let label1: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = ""
                label.textColor = .gray
                label.textAlignment = .right
                label.font = UIFont.Pretendard(.regular, size: 20)
                label.tag = 17
                return label
            }()
            let label2: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0.0"
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
            
            verticalStackVeiw.addArrangedSubview(label1)
            verticalStackVeiw.addArrangedSubview(label2)
            
            view.addSubview(verticalStackVeiw)
            
            view.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3).isActive = true
            verticalStackVeiw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            verticalStackVeiw.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            verticalStackVeiw.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            verticalStackVeiw.widthAnchor.constraint(equalToConstant: screenWidth / 4 * 3 - 40).isActive = true
            
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
            view.addBorder(.bottom, color: .gray, thickness: 0.5)
            
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
                button.titleLabel?.font = UIFont.Pretendard(.medium, size: 16)
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                button.tintColor = .label
                button.setTitleColor(.label, for: .normal)
                button.setPreferredSymbolConfiguration(.init(pointSize: 13), forImageIn: .normal)
                button.semanticContentAttribute = .forceRightToLeft
                button.tag = 19
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
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "0.0"
                label.textColor = .label
                label.textAlignment = .right
                label.font = UIFont.Pretendard(.regular, size: 25)
                label.tag = 20
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
    
    
    @objc func tapCalculatorButton(_ sender: UIButton) {
        let calculatorButtonType = CalculatorButtonType(rawValue: sender.tag)
        let workingLabel = self.viewWithTag(17) as! UILabel
        let fromResultLabel = self.viewWithTag(18) as! UILabel
        let toResultLabel = self.viewWithTag(20) as! UILabel
        
        switch calculatorButtonType {
        case .zero:
            update(of: &working, with: "0")
        case .dot:
            update(of: &working, with: ".")
        case .delete:
            if !working.isEmpty {
                working.removeLast()
            }
        case .plus:
            update(of: &working, with: "+")
        case .one:
            update(of: &working, with: "1")
        case .two:
            update(of: &working, with: "2")
        case .three:
            update(of: &working, with: "3")
        case .minus:
            update(of: &working, with: "-")
        case .four:
            update(of: &working, with: "4")
        case .five:
            update(of: &working, with: "5")
        case .six:
            update(of: &working, with: "6")
        case .divide:
            update(of: &working, with: "/")
        case .seven:
            update(of: &working, with: "7")
        case .eight:
            update(of: &working, with: "8")
        case .nine:
            update(of: &working, with: "9")
        case .multiply:
            update(of: &working, with: "×")
        default:
            break
        }
        
        let result = calculate(convertInfixToPostfix(working))
        
        workingLabel.text = working
        fromResultLabel.text = String(describing: result)
        toResultLabel.text = String(describing: result)
    }
    
    @objc func clearAll(_ sender: UIButton) {
        let workingLabel = self.viewWithTag(17) as! UILabel
        let fromResultLabel = self.viewWithTag(18) as! UILabel
        let toResultLabel = self.viewWithTag(20) as! UILabel
        
        working = ""
        workingLabel.text = working
        fromResultLabel.text = "0.0"
        toResultLabel.text = "0.0"
    }
    
    
    // 계산기 로직, 추후 분리할것
    private func update(of working: inout String, with operators: String) {
        if operators == "+" || operators == "-" || operators == "/" || operators == "×" || operators == "."{
            if let last = working.last {
                if working.count == 1 && last == "0" {
                    return
                }
                if !working.isEmpty && last == "+" || last == "-" || last == "/" || last == "×" || last == "."{
                    return
                }
            }
        }
        working.append(operators)
        
        var dotCount = 0
        for char in working {
            if char == "+" || char == "-" || char == "/" || char == "×" {
                dotCount = 0
            }
            if char == "." {
                dotCount += 1
            }
        }
        
        if dotCount > 1 {
            working.removeLast()
        }
        
        if working.first == "0" && working.count > 1 {
            working.remove(at: working.startIndex)
        }
        
    }
    
    private func tokenize(_ working: String) -> [String] {
        let replaced = working.replacingOccurrences(of: "+", with: " + ")
            .replacingOccurrences(of: "-", with: " - ")
            .replacingOccurrences(of: "/", with: " / ")
            .replacingOccurrences(of: "×", with: " × ")
        
        return replaced.components(separatedBy: " ")
    }
    
    private func priority(of operators: String) -> Int {
        if operators == "+" || operators == "-" {
            return 1
        }
        if operators == "/" || operators == "×" {
            return 2
        }
        return -1
    }
    
    private func convertInfixToPostfix(_ infix: String) -> [String] {
        let tokenized = tokenize(infix)
        var stack = [String]()
        var postfix = [String]()
        
        for item in tokenized {
            if item == "+" || item == "-" || item == "/" || item == "×" {
                while !stack.isEmpty && priority(of: stack.last!) >= priority(of: item) {
                    postfix.append(stack.popLast()!)
                }
                stack.append(item)
            } else {
                postfix.append(item)
            }
        }
        while !stack.isEmpty {
            postfix.append(stack.popLast()!)
        }
        
        return postfix
    }
    
    private func calculate(_ postfix: [String]) -> Float {
        var stack = [Float]()
        
        for item in postfix {
            if item != "+" && item != "-" && item != "/" && item != "×" {
                stack.append((item as NSString).floatValue)
            } else {
                if var opperand2 = stack.popLast(), let opperand1 = stack.popLast() {
                    switch item {
                    case "+":
                        stack.append(opperand1 + opperand2)
                    case "-":
                        stack.append(opperand1 - opperand2)
                    case "×":
                        opperand2 = opperand2 == 0.0 ? 1.0 : opperand2
                        stack.append(opperand1 * opperand2)
                    case "/":
                        opperand2 = opperand2 == 0.0 ? 1.0 : opperand2
                        stack.append(opperand1 / opperand2)
                    default:
                        break
                    }
                }
            }
        }
        
        return stack.popLast() ?? 0
    }
}

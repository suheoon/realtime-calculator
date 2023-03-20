//
//  CalculatorViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    // from, to currnecy를 모두 원 단위로 바꾸고 from / to 를 하면 계산가능
    var from: Int = 0
    var to: Int = 0
    
    let currencyManger = CurrencyManager.shared
    var currencyArrays: [Currency] = []
    
    private lazy var calculatorView = {
        let calculatorView = CalculatorUIStackView(frame: .zero)
        calculatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return calculatorView
    }()
    
    var buttonHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(calculatorView)
        
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        setupData()
    }
    
    private func setupData() {
        currencyArrays = currencyManger.getCurrencyArraysFromAPI()
    }
    
    private func setupLayout() {
        let calculatorViewConstraints  = [
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(calculatorViewConstraints)
    }
    
    private func configureNavBar() {
        let label = UILabel()
        label.textColor = UIColor.label
        label.text = "환율 계산기"
        label.font = UIFont.Pretendard(.semiaBold, size: 18)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.navigationController?.navigationBar.tintColor = .label
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    
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
    
    private func calculate(_ postfix: [String]) -> Double {
        var stack = [Double]()
        
        for item in postfix {
            if item != "+" && item != "-" && item != "/" && item != "×" {
                stack.append((item as NSString).doubleValue)
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
    
    private func clear() {
        let workingLabel = calculatorView.viewWithTag(17) as! UILabel
        let fromResultLabel = calculatorView.viewWithTag(18) as! UILabel
        let toResultLabel = calculatorView.viewWithTag(20) as! UILabel
        
        calculatorView.working = ""
        workingLabel.text = calculatorView.working
        fromResultLabel.text = "0"
        toResultLabel.text = "0.00"
    }
}

// custom delegate패턴
extension CalculatorViewController: ButtonDelegate {
    func selectionButtonTapped(_ sender: UIButton) {
        let currencySelectionViewController = CurrencySelectionViewController()

        if (sender.tag == 16) {
            // from 버튼일 때
            currencySelectionViewController.completion = { [weak self] data in
                self?.from = data
                if let currencyCode = self?.currencyArrays[data].currencyCode {
                    sender.setTitle("\(currencyCode)", for: .normal)
                }
                self?.clear()
            }
        } else if (sender.tag == 19) {
            // to 버튼일 때
            currencySelectionViewController.completion = { [weak self ]data in
                self?.to = data
                if let currencyCode = self?.currencyArrays[data].currencyCode {
                    sender.setTitle("\(currencyCode)", for: .normal)
                }
                self?.clear()
            }
        }
        self.navigationController?.pushViewController(currencySelectionViewController, animated: false)
    }
    
    func tapCalculatorButton(_ sender: UIButton) {
        let calculatorButtonType = CalculatorButtonType(rawValue: sender.tag)
        let workingLabel = calculatorView.viewWithTag(17) as! UILabel
        let fromResultLabel = calculatorView.viewWithTag(18) as! UILabel
        let toResultLabel = calculatorView.viewWithTag(20) as! UILabel
        
        switch calculatorButtonType {
        case .zero:
            update(of: &calculatorView.working, with: "0")
        case .dot:
            update(of: &calculatorView.working, with: ".")
        case .delete:
            if !calculatorView.working.isEmpty {
                calculatorView.working.removeLast()
            }
        case .plus:
            update(of: &calculatorView.working, with: "+")
        case .one:
            update(of: &calculatorView.working, with: "1")
        case .two:
            update(of: &calculatorView.working, with: "2")
        case .three:
            update(of: &calculatorView.working, with: "3")
        case .minus:
            update(of: &calculatorView.working, with: "-")
        case .four:
            update(of: &calculatorView.working, with: "4")
        case .five:
            update(of: &calculatorView.working, with: "5")
        case .six:
            update(of: &calculatorView.working, with: "6")
        case .divide:
            update(of: &calculatorView.working, with: "/")
        case .seven:
            update(of: &calculatorView.working, with: "7")
        case .eight:
            update(of: &calculatorView.working, with: "8")
        case .nine:
            update(of: &calculatorView.working, with: "9")
        case .multiply:
            update(of: &calculatorView.working, with: "×")
        default:
            break
        }
        
        let result = calculate(convertInfixToPostfix(calculatorView.working))
        guard let fromBasePrice = currencyArrays[from].basePrice, let toBasePrice = currencyArrays[to].basePrice, let currencyUnit = currencyArrays[from].currencyUnit else { return }
        
        workingLabel.text = calculatorView.working
        fromResultLabel.text = String(format: "%.f", result)
        toResultLabel.text = String(format: "%.2f",result * fromBasePrice / toBasePrice / Double(currencyUnit))
    }
    
    func clearAll(_ sender: UIButton) {
        let workingLabel = calculatorView.viewWithTag(17) as! UILabel
        let fromResultLabel = calculatorView.viewWithTag(18) as! UILabel
        let toResultLabel = calculatorView.viewWithTag(20) as! UILabel
        
        calculatorView.working = ""
        workingLabel.text = calculatorView.working
        fromResultLabel.text = "0"
        toResultLabel.text = "0.00"
    }
}


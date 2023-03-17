//
//  CalculatorViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    weak var delegate: ButtonDelegate?
    
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
    }
}

extension CalculatorViewController: ButtonDelegate {
    func buttonTapped(_: UIButton) {
        let currencySelectionViewController = CurrencySelectionViewController()
        currencySelectionViewController.modalPresentationStyle = .formSheet
        self.present(currencySelectionViewController, animated: true, completion: nil)
    }
}


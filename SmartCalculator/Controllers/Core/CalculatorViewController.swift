//
//  CalculatorViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    private lazy var calculatorView = CalculatorUIStackView(frame: .zero)
    var buttonHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(calculatorView)
        
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureLayout() {
        calculatorView.translatesAutoresizingMaskIntoConstraints = false

        let calculatorViewConstraints  = [
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(calculatorViewConstraints)
    }
    
    private func configureNavBar() {
        let label = UILabel()
        label.textColor = UIColor.label
        label.text = "환율 계산기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
}

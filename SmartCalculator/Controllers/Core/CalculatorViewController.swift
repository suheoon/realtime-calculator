//
//  CalculatorViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    private lazy var calculatorView = CalculatorUIView()
    var buttonHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(calculatorView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureLayout() {
        calculatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let calculatorViewConstraints  = [
            calculatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        
        NSLayoutConstraint.activate(calculatorViewConstraints)
    }
    
    
}

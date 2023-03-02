//
//  ExchangeRateViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class ExchangeRateViewController: UIViewController {
    
    let currencyManger = CurrencyManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupDatas()
    }
    
    func setupDatas() {
        currencyManger.setupDatasFromAPI {}
    }

}

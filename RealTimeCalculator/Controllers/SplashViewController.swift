//
//  SplashViewController.swift
//  RealTimeCalculator
//
//  Created by Suheon Song on 2023/04/13.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let currencyFetcher = CurrencyFetcher.shared
        
        currencyFetcher.setupDatasFromAPI { [weak self] in
            DispatchQueue.main.async {
                let tabBarViewController = TabBarViewController()
                tabBarViewController.modalPresentationStyle = .fullScreen
                self?.present(tabBarViewController, animated: false)
            }
        }
    }
}

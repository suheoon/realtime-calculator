//
//  TabBarViewController.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/21.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        
        let vc1 = UINavigationController(rootViewController: CalculatorViewController())
        let vc2 = UINavigationController(rootViewController: ExchangeRateViewController())
        
        vc1.tabBarItem.image = UIImage(named: "calculator")?.resize(targetSize: CGSize(width: 20 , height: 20))
        vc2.tabBarItem.image = UIImage(named: "exchange-rate")?.resize(targetSize: CGSize(width: 25, height: 25))
        
        vc1.tabBarItem.title = "계산기"
        vc2.tabBarItem.title = "환율"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 10)
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Pretendard-Regular", size: 12)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
}

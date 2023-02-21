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
        
        let vc1 = UINavigationController(rootViewController: CalculatorViewController())
        let vc2 = UINavigationController(rootViewController: ExchangeRateViewController())
        
        vc1.tabBarItem.image = UIImage(named: "calculator")?.resizeImage(targetSize: CGSize(width: 25 , height: 25))
        vc2.tabBarItem.image = UIImage(named: "exchange-rate")?.resizeImage(targetSize: CGSize(width: 25, height: 25))
        
        vc1.tabBarItem.title = "계산기"
        vc2.tabBarItem.title = "환율"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  CurrencyManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

final class CurrencyManager {
    
    static let shared = CurrencyManager()
    
    private init() {}
    
    private let currencyService = CurrencyService.shared
    
    private var currencyArrays: [Currency] = [Currency(currencyCode: "KRW", country: "대한민국", basePrice: 1, change: "EVEN", changePrice: 0, currencyUnit: 1)]
    
    func getCurrencyArraysFromAPI() -> [Currency] {
        return currencyArrays
    }
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        currencyService.fetchCurrency { result in
            switch result {
            case .success(let currencyDatas):
                self.currencyArrays.append(contentsOf: currencyDatas)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    
    
}

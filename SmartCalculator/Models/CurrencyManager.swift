//
//  CurrencyManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

final class CurrencyManager {
    
    static let shared = CurrencyManager()
    
    private init() {
        
    }
    
    private let currencyService = CurrencyService.shared
    
    private var currencyArrays: [Currency] = []
    
    func getCurrencyArraysFromAPI() -> [Currency] {
        return currencyArrays
    }
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        currencyService.fetchCurrency { result in
            switch result {
            case .success(let currencyDatas):
                self.currencyArrays = currencyDatas
//                dump(currencyDatas)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    
    
}

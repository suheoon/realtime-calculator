//
//  CurrencyManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

final class CurrencyManager {
    
    static let shared = CurrencyManager()
    
    private let currencyService = CurrencyService.shared
    private let coredataManger = CoreDataManager.shared
    
    private var currencyArrays: [Currency] = [Currency(currencyCode: "KRW", country: "대한민국", basePrice: 1, change: "EVEN", changePrice: 0, currencyUnit: 1)]

    
    
    private init() {}
    
    func getCurrencyArraysFromAPI() -> [Currency] {
        return currencyArrays
    }
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        currencyService.fetchCurrency { result in
            switch result {
            case .success(let currencyDatas):
                self.currencyArrays.append(contentsOf: currencyDatas)
                DispatchQueue.main.async {
                    let currencyData: [CurrencySaved] = self.coredataManger.getCurrencyArrayFromCoreData()
                    for data in currencyData {
                        print(data.country)
                    }
                }
//                DispatchQueue.main.async {
//                    for data in currencyDatas {
//                        self.coredataManger.saveCurrency(data)
//                    }
//                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    
    
}

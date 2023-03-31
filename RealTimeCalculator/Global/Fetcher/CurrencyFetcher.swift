//
//  CurrencyManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

final class CurrencyFetcher {
    
    static let shared = CurrencyFetcher()
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    private var currencyArrays: [Currency] = [Currency(currencyCode: "KRW", country: "대한민국", basePrice: 1, change: "EVEN", changePrice: 0, currencyUnit: 1)]


    private init() {}
    
    func getCurrencyArraysFromAPI() -> [Currency] {
        return currencyArrays
    }
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        networkManager.getCurrency { result in
            switch result {
            case .success(let currencyDatas):
                self.currencyArrays.append(contentsOf: currencyDatas)
//                DispatchQueue.main.async {
//                    let currencyData: [Currency] = self.coreDataManager.getCurrencyArrayFromCoreData().map({$0.convertToCurrency()})
//
//                    self.currencyArrays.append(contentsOf: currencyData)
//                }
//                DispatchQueue.main.async {
//                    for data in currencyDatas {
//                        self.coredataManger.saveCurrencyToCoreData(data)
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

//
//  Currency.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation


typealias CurrencyArray = [Currency]

struct Currency: Codable {
    let currencyCode, currencyName, country: String?
    let date, time: String?
    let basePrice, changePrice: Double?
    
    var changeRate: Double? {
        guard let changePrice = changePrice, let basePrice = basePrice else { return 0.0 }
        return changePrice / basePrice * 100
    }
}

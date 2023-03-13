//
//  Currency.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation



typealias CurrencyArray = [Currency]

struct Currency: Codable {
    let currencyCode, currencyName: String? // "USD" "달러" "미국"
    var country: String?
    let date, time: String?
    let basePrice, openingPrice, highPrice, lowPrice: Double?
    let change: String? // "RISE" or "FALL"
    let changePrice: Double?
    let cashBuyingPrice, cashSellingPrice: Double? // (현찰) 사실 때 / 파실 때
    let ttSellingPrice, ttBuyingPrice: Double? // (송금) 보내실 때 / 받으실 때
    let exchangeCommission: Double? // 환전 수수료
    let usDollarRate: Double? // 미화 환산율
    let high52WPrice: Double?
    let high52WDate: String?
    let low52WPrice: Double?
    let low52WDate: String?
    let currencyUnit: Int? // 화폐 단위
    let provider: String? // 하나은행
    
    enum CodingKeys: String, CodingKey {
        case currencyCode, currencyName, country
        case date, time
        case basePrice, openingPrice, highPrice, lowPrice
        case change
        case changePrice
        case cashBuyingPrice, cashSellingPrice
        case ttSellingPrice, ttBuyingPrice
        case exchangeCommission
        case usDollarRate
        case high52WPrice = "high52wPrice"
        case high52WDate = "high52wDate"
        case low52WPrice = "low52wPrice"
        case low52WDate = "low52wDate"
        case currencyUnit
        case provider
    }
    
    var changeRate: Double? {
        guard let changePrice = changePrice, let basePrice = basePrice else { return 0.0 }
        return changePrice / basePrice * 100
    }
    
}

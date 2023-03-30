//
//  Currency.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

typealias CurrencyArray = [Currency]

struct Currency: Codable {
    var currencyCode, currencyName: String? // "USD" "달러"
    var country: String?
    var date, time: String?
    var basePrice, openingPrice, highPrice, lowPrice: Double?
    var change: String? // "RISE" or "FALL"
    var changePrice: Double?
    var cashBuyingPrice, cashSellingPrice: Double? // (현찰) 사실 때 / 파실 때
    var ttSellingPrice, ttBuyingPrice: Double? // (송금) 보내실 때 / 받으실 때
    var exchangeCommission: Double? // 환전 수수료
    var usDollarRate: Double? // 미화 환산율
    var high52WPrice: Double?
    var high52WDate: String?
    var low52WPrice: Double?
    var low52WDate: String?
    var currencyUnit: Int? // 화폐 단위
    var provider: String? // 하나은행
    var changeRate: Double? {
        guard let changePrice = changePrice, let basePrice = basePrice else { return 0.0 }
        return changePrice / basePrice * 100
    }
    // country가 nil인 나라들의 이름
    var countryName: String? {
        guard let currencyCode = currencyCode else {return ""}
        return dict[currencyCode]
    }
    
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
    
}

extension Currency: Equatable {
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.currencyCode == rhs.currencyCode
    }
}

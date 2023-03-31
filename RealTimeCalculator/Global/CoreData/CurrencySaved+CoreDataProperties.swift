//
//  CurrencySaved+CoreDataProperties.swift
//  RealTimeCalculator
//
//  Created by Suheon Song on 2023/03/30.
//
//

import Foundation
import CoreData


extension CurrencySaved {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencySaved> {
        return NSFetchRequest<CurrencySaved>(entityName: "CurrencySaved")
    }
    
    @NSManaged public var currencyCode: String?
    @NSManaged public var currencyName: String?
    @NSManaged public var country: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var basePrice: Double
    @NSManaged public var change: String?
    @NSManaged public var changePrice: Double
    @NSManaged public var usDollarRate: Double
    @NSManaged public var currencyUnit: Int32
    @NSManaged public var savedDate: Date?
    
    var changeRate: Double {
        return changePrice / basePrice * 100
    }
    
    // country가 nil인 나라들의 이름
    var countryName: String? {
        guard let currencyCode = currencyCode else {return ""}
        return dict[currencyCode]
    }
    
    static func currencySavedToCurrency(_ currencySaved: CurrencySaved) -> Currency {
        return Currency(currencyCode: currencySaved.currencyCode, currencyName: currencySaved.currencyName, country: currencySaved.country,
                        date: currencySaved.date, time: currencySaved.time, basePrice: currencySaved.basePrice,
                        change: currencySaved.change, changePrice: currencySaved.changePrice, usDollarRate: currencySaved.usDollarRate, currencyUnit: Int(currencySaved.currencyUnit))
    }
    
    func convertToCurrency() -> Currency {
        return Currency(currencyCode: self.currencyCode, currencyName: self.currencyName, country: self.country,
                        date: self.date, time: self.time, basePrice: self.basePrice,
                        change: self.change, changePrice: self.changePrice, usDollarRate: self.usDollarRate, currencyUnit: Int(self.currencyUnit))
    }
    
}

extension CurrencySaved : Identifiable {
    
}

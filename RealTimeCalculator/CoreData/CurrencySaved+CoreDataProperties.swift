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
    @NSManaged public var openingPrice: Double
    @NSManaged public var lowPrice: Double
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

}

extension CurrencySaved : Identifiable {

}

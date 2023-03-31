//
//  CoreDataManager.swift
//  RealTimeCalculator
//
//  Created by Suheon Song on 2023/03/30.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let modelName: String = "CurrencySaved"
    
    func getCurrencyArrayFromCoreData() -> [CurrencySaved] {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        lazy var context = appDelegate?.persistentContainer.viewContext
        
        var savedCurrencyArray: [CurrencySaved] = []

        if let context = context {

            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)

            let savedDateOrder = NSSortDescriptor(key: "savedDate", ascending: true)
            request.sortDescriptors = [savedDateOrder]
            
            do {
                
                if let fetchedCurrencyArray = try context.fetch(request) as? [CurrencySaved] {
                    savedCurrencyArray = fetchedCurrencyArray
                }
            } catch {
                print("fetch fail")
            }
        }
        
        return savedCurrencyArray
    }
    
    func saveCurrency(_ currency: Currency) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        lazy var context = appDelegate?.persistentContainer.viewContext
        
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let currencySaved = NSManagedObject(entity: entity, insertInto: context) as? CurrencySaved {
                    
                    currencySaved.savedDate = Date()
                    currencySaved.currencyCode = currency.currencyCode
                    currencySaved.currencyName = currency.currencyName
                    currencySaved.country = currency.country
                    currencySaved.date = currency.date
                    currencySaved.time = currency.time
                    currencySaved.basePrice = currency.basePrice ?? 0.0
                    currencySaved.openingPrice = currency.openingPrice ?? 0.0
                    currencySaved.change = currency.change
                    currencySaved.changePrice = currency.changePrice ?? 0.0
                    currencySaved.usDollarRate = currency.usDollarRate ?? 0.0
                    currencySaved.currencyUnit = Int32(currency.currencyUnit ?? 0)
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                            print("success")
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    // viewContext : main queue에서 동작함
    // coredata에 저장하는 데이터가 많다면 UI 업데이트가 block되는 현상이 길어지므로 다른 방법이 필요
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    private init() {}
    
    let modelName: String = "CurrencySaved"
    
    func getCurrencyArrayFromCoreData() -> [CurrencySaved] {
        var currencySavedArray: [CurrencySaved] = []

        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)

            let savedDateOrder = NSSortDescriptor(key: "savedDate", ascending: true)
            request.sortDescriptors = [savedDateOrder]
            
            do {
                if let fetchedData = try context.fetch(request) as? [CurrencySaved] {
                    currencySavedArray = fetchedData
                }
            } catch {
                print("fetch fail")
            }
        }
        
        return currencySavedArray
    }
    
    func saveCurrencyToCoreData(_ currency: Currency) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let currencySaved = NSManagedObject(entity: entity, insertInto: context) as? CurrencySaved {
                    
                    currencySaved.savedDate = Date()
                    currencySaved.currencyCode = currency.currencyCode
                    currencySaved.currencyName = currency.currencyName
                    currencySaved.country = currency.country
                    currencySaved.date = currency.date
                    currencySaved.time = currency.time
                    currencySaved.change = currency.change
                    currencySaved.basePrice = currency.basePrice ?? 0.0
                    currencySaved.changePrice = currency.changePrice ?? 0.0
                    currencySaved.usDollarRate = currency.usDollarRate ?? 0.0
                    currencySaved.currencyUnit = Int32(currency.currencyUnit ?? 0)
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

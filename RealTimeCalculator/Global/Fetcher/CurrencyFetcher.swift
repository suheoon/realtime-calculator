//
//  CurrencyManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import UIKit

final class CurrencyFetcher {
    
    static let shared = CurrencyFetcher()
    
    private var currencyArrays: [Currency] = []
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared

    private init() {
        // api로 받아올 수 없는 우리나라 환율 정보
        let koreanCurrency: Currency = Currency(currencyCode: "KRW", country: "대한민국", basePrice: 1,
                                                change: "EVEN", changePrice: 0, currencyUnit: 1)
        currencyArrays.append(koreanCurrency)
    }
    
    func getCurrencyArraysFromAPI() -> [Currency] {
        return currencyArrays
    }
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        networkManager.getCurrency { result in
            switch result {
            case .success(let currencyDatas):
                self.currencyArrays.append(contentsOf: currencyDatas)
                DispatchQueue.main.async {
                    for data in currencyDatas {
                        self.coreDataManager.saveCurrencyToCoreData(data)
                    }
                }
                completion()
            case .failure(let error):
                switch error {
                case .networkingError:
                    DispatchQueue.main.async {
                        let savedCurrencyArray : [Currency] = self.coreDataManager.getCurrencyArrayFromCoreData().map({$0.convertToCurrency()})
                        if savedCurrencyArray.isEmpty {
                            self.showExitAlert()
                        }
                        self.currencyArrays.append(contentsOf: savedCurrencyArray)
                        self.showNetworkErrorAlert()
                    }
                default:
                    DispatchQueue.main.async {
                        self.showAppErrorAlert()
                    }
                }
                completion()
            }
        }
    }
    
    // 네트워크 연결 오류가 발생했지만 CoreData에 저장된 데이터가 있을 경우
    private func showNetworkErrorAlert() {
        let alertController = UIAlertController(title: "네트워크 연결이 원활하지 않습니다", message: "네트워크 연결이 원활하지 않아 저장된 환율 정보를 사용합니다 실시간 환율과 정보가 다를 수 있습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
     
    // 네트워크 연결 오류가 발생했고 CoreData에 저장된 데이터도 없을 경우
    private func showExitAlert() {
        let alertController = UIAlertController(title: "네트워크 연결이 원활하지 않습니다", message: "환율 정보를 위해 네트워크 상태를 확인해 주세요 확인을 누르면 앱이 종료됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
           exit(0)
        }
        alertController.addAction(okAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // 서버나 앱 내부 에러가 발생했을 경우
    private func showAppErrorAlert() {
        let alertController = UIAlertController(title: "불편을 드려 죄송합니다🙇🏻‍♂️", message: "앱 실행 시 오류가 발생했습니다 앱 스토어 리뷰 또는 ssheon0812@naver.com으로 연락 주시면 신속히 처리하겠습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "종료", style: .default) { _ in
            exit(0)
        }
        alertController.addAction(okAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

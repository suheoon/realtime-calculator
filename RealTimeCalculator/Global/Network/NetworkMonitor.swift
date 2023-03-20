//
//  NetworkMonitor.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/21.
//

import Network
import UIKit

class NetworkMonitor {
    let monitor = NWPathMonitor()
    var isMonitoring = false
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status != .satisfied {
                self?.showAlert()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        isMonitoring = true
    }
    
    func stopMonitoring() {
        guard isMonitoring else { return }
        monitor.cancel()
        isMonitoring = false
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "네트워크 연결이 원활하지 않습니다", message: "환율 정보를 위해 네트워크 상태를 확인해 주세요 확인을 누르면 앱이 종료됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
           exit(0)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

//
//  NetworkManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class CurrencyService {
    
    static let shared = CurrencyService()
    
    private init() {}
    
    typealias NetworkCompletion = (Result<[Currency], NetworkError>) -> Void
    
    func fetchCurrency(completion: @escaping NetworkCompletion) {
        let urlString = Storage().requestUrl
        perfromRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func perfromRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let currencies = self.parseJSON(safeData) {
                completion(.success(currencies))
            } else {
                completion(.failure(.parseError))
            }
            
        }
        task.resume()
    }
    
    
    private func parseJSON(_ currencyData: Data) -> [Currency]? {
        do {
            let currencyData = try JSONDecoder().decode(CurrencyArray.self, from: currencyData)
            return currencyData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


//
//  NetworkManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/02.
//

import Foundation

enum ManagerError: Error {
    case invalidUrl
    case networkingError
    case invalidResponse
    case invalidStatusCode(Int)
    case dataError
    case parseError
}

enum HttpMethod: String {
    case get
    case post
    // enum의 각 case는 소문자로 시작하는 관례를 따르므로 rawValue를 대문자로 만들어주는 계산속성 정의
    var method: String { rawValue.uppercased() }
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getCurrency(completion: @escaping (Result<[Currency], Error>) -> Void) {
        let urlString = RequestUrl.currencyRequestUrl
        guard let url = URL(string: urlString) else {
            completion(.failure(ManagerError.invalidUrl))
            return
        }
        perfromRequest(fromURL: url, completion: completion)
    }
    
    // 네트워크 요청을 하는 공통 모듈
    private func perfromRequest<T: Decodable>(fromURL url: URL, httpMethod: HttpMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ManagerError.invalidResponse))
                return
            }
            if !(200..<300).contains(response.statusCode) {
                completion(.failure(ManagerError.invalidStatusCode(response.statusCode)))
                return
            }
        
            guard let data = data else {
                completion(.failure(ManagerError.dataError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(ManagerError.parseError))
            }
        }
        task.resume()
    }
}


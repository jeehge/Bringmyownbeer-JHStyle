//
//  NetworkManager.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import Foundation

final class NetworkManager {
    static func request<T: Decodable>(api: API, parameters: [String: String]?, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let request: URLRequest = getFinalURL(api: api,
                                                    parameters: parameters) else { return }
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.message(error.localizedDescription)))
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                if (200..<300).contains(response.statusCode){
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.parseError))
                        return
                    }
                } else {
                    completion(.failure(APIError.errorCode(response.statusCode)))
                }
            }
        }.resume()
    }
    
    private static func getFinalURL(api: API,  parameters: [String: String]?) -> URLRequest? {
        guard var components: URLComponents = URLComponents(string: api.path) else { return nil }
        if let param = parameters {
            components.setQueryItems(with: param)
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = api.method.rawValue
        return request
    }
}

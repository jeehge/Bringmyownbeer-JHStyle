//
//  BeerService.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/27.
//

import Foundation

final class BeerService {
    func getBeerList<T: Decodable>(api: API, completion: @escaping (Result<[T], APIError>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: api.path)!) {
            (data, response, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()

    }
}

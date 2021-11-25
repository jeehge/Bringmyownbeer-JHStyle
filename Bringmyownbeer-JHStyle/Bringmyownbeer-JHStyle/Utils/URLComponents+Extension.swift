//
//  URLComponents+Extension.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/25.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

//
//  NetworkError.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/25.
//

import Foundation

enum NetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(message):
            return message
        case .retry:
            return "다시 시도해주세요."
        }
    }
}

protocol PunkNetwork {
    func getBeers(page: Int?) -> Observable<Result<[Beer], PunkNetworkError>>
    func getBeer(id: String) -> Observable<Result<[Beer], PunkNetworkError>>
    func getRandomBeer() -> Observable<Result<[Beer], PunkNetworkError>>
}


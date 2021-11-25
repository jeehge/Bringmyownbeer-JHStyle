//
//  APIError.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/25.
//

import Foundation

enum APIError {
    case errorCode(Int)
    case noData
    case parseError
}

extension APIError: LocalizedError {
    var errorText: String? {
        switch self {
        case .errorCode(let code):
            return "status code : \(code)"
        case .noData:
            return "데이터가 없습니다."
        case .parseError:
            return "파싱 에러"
        }
    }
}

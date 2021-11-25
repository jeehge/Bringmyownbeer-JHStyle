//
//  API.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/25.
//

import Foundation
import UIKit

/**
 맥주 목록 가져오기 API  https://api.punkapi.com/v2/beers
*/

enum Method: String {
    case GET
    case POST
}

enum API {
    case beer
}

extension API {
    static let baseURL = "https://api.punkapi.com"
    
    var path: String {
        switch self {
        case .beer:
            return API.baseURL + "/v2/beers"
        }
    }
    
    var method: Method {
        switch self {
        case .beer:
            return .GET
        }
    }
}

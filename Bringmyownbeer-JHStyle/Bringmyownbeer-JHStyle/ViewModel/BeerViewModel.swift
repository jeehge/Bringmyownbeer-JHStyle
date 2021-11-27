//
//  BeerViewModel.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/27.
//

import Foundation

struct BeerViewModel {
    private let beer: Beer
}

extension BeerViewModel {
    init(_ beer: Beer) {
        self.beer = beer
    }
}

extension BeerViewModel {
    var id: String? {
        return String(describing: self.beer.id)
    }
    var name: String? {
        return self.beer.name
    }
    var imageURL: String? {
        return self.beer.imageURL
    }
    var description: String? {
        return self.beer.description
    }
}

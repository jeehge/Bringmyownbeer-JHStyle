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

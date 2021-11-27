//
//  BeerListViewModel.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/27.
//

import Foundation

struct BeerListViewModel {
    let beerList: [Beer]
}

extension BeerListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.beerList.count
    }

    func articleAtIndex(_ index: Int) -> BeerViewModel {
        let list = self.beerList[index]
        return BeerViewModel(list)
    }
}

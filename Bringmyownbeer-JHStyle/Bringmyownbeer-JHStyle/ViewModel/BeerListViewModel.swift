//
//  BeerListViewModel.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/27.
//

import Foundation
import RxSwift

protocol BeerListViewModelDelegate: AnyObject {
    func requestCompletion()
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

// Interface
class BeerListViewModelType: ViewModelType {
    struct Input {
        let fetch: Observable<Void>
    }
    
    struct Output {
        let fetch: Observable<[Beer]>
    }
    
    var input: Input!
    var output: Output!
    
    func transform(input: Input) -> Output {
        return output
    }
}

final class BeerListViewModel: BeerListViewModelType {
    private var beerList: [Beer] = []
    
    weak var delegate: BeerListViewModelDelegate?

    override func transform(input: BeerListViewModelType.Input) -> BeerListViewModelType.Output {
        
        let fetch: Observable<[Beer]> = input.fetch
            .flatMapLatest(tempRequest)
        
        return Output(fetch: fetch)
    }
}

extension BeerListViewModel {
    
    var list: [Beer] {
        return beerList
    }
    
    func request() {
        BeerService().getBeerList(api: .beer) { [weak self] (result: Result<[Beer], APIError>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.beerList = result
                self.delegate?.requestCompletion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tempRequest() -> Observable<[Beer]> {
//        let Beers: [Beer] = [
//            Beer(id: 1),
//            Beer(id: 2),
//            Beer(id: 3),
//            Beer(id: 4),
//            Beer(id: 5),
//        ]

        return Observable.just([])
    }
}

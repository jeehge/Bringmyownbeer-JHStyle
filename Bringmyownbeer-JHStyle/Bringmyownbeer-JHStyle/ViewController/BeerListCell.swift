//
//  BeerListCell.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit
import RxSwift
import RxCocoa

/**
 맥주 목록에서 사용하는 cell
 */
final class BeerListCell: UITableViewCell {
    
    // MARK: - Properties
    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 3
        return label
    }()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configConstraint()
    }
    
    // MARK: - Config
    
    private func configConstraint() {
        addSubviews(beerImageView, idLabel, nameLabel, descriptionLabel)
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            beerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            beerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            beerImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - internal Method
    
    func setBeerListCell(_ beer: Beer) {
        
//        let nameObservable: Observable<String> = Observable.just("권지혜")
//
//        nameObservable.subscribe(onNext: { [weak self] in
//            self?.idLabel.text = $0
//        }).disposed(by: disposeBag)
//
//        nameObservable
//            .bind(to: idLabel.rx.text)
//            .disposed(by: disposeBag)
//        beer.id.map(String.init).flatMap(test)
//
        idLabel.text = beer.id.map(String.init)
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        
        let url = URL(string: beer.imageURL ?? "")
        let data = try? Data(contentsOf: url!)
        
        // TODO: - 이미지 캐싱 
        DispatchQueue.main.async {
            self.beerImageView.image = UIImage(data: data!)
        }
        
    }
    
    func test(str: String?) -> String? {
        return str! + "원"
    }
}

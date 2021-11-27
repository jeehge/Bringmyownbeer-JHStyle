//
//  DetailViewController.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

/**
 맥주 상세 화면
 */
final class DetailViewController: BaseViewController {

    // MARK: - Properties
    
    var info: BeerViewModel?
    
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
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configConstraint()
        settingBeerInfo()
    }
    
    // MARK: - Config
    
    private func configConstraint() {
        view.addSubviews(beerImageView, idLabel, nameLabel, descriptionLabel)
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            beerImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            beerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            beerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            beerImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            beerImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
            beerImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.beerImageView.bottomAnchor),
            idLabel.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func settingBeerInfo() {
        guard let info = info else { return }
        idLabel.text = "\(info.id)"
        nameLabel.text = info.name
        descriptionLabel.text = info.description
        
        let url = URL(string: info.imageURL ?? "")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.beerImageView.image = UIImage(data: data!)
            }
        }
    }
}

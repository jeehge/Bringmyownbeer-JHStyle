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
    
    var info: Beer?
    
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
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
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
            beerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            beerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            beerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            beerImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            beerImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.beerImageView.bottomAnchor, constant: 16),
            idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
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

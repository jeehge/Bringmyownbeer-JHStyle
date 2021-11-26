//
//  BeerListCell.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

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
            beerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            beerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            beerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            beerImageView.trailingAnchor.constraint(equalTo: self.idLabel.leadingAnchor),
            beerImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.topAnchor),
            idLabel.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            idLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: - internal Method
    
    func setBeerListCell(_ info: Beer) {
        guard let id = info.id else { return }
        idLabel.text = "\(id)"
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

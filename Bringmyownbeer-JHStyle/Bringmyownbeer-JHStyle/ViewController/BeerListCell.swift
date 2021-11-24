//
//  BeerListCell.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

final class BeerListCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setConstraint()
    }
    
    // MARK: - private Method
    
    private func setConstraint() {
        
    }
    
    // MARK: - internal Method
    
    func setBeerListCell() {

    }
}

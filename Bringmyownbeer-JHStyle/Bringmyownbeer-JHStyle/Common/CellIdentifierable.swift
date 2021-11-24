//
//  CellIdentifierable.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

protocol CellIdentifierable { }

extension CellIdentifierable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifierable { }

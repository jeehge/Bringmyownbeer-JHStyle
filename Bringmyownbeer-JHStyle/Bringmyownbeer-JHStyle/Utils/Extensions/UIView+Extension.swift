//
//  UIView+Extension.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

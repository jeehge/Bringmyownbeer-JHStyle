//
//  UIViewController+Extension.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/26.
//

import UIKit

extension UIViewController {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}

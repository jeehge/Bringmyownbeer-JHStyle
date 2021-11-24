//
//  ViewControllerFromStoryBoard.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
}

protocol ViewControllerFromStoryBoard { }

extension ViewControllerFromStoryBoard where Self: UIViewController {
    static func viewController(from storyboardName: StoryboardName) -> Self {
        guard let viewController: Self = UIStoryboard(name: storyboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self else { return Self() }
        return viewController
    }
}

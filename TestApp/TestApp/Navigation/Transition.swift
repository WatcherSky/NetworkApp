//
//  Transition.swift
//  TestApp
//
//  Created by Владимир on 10.11.2022.
//

import Foundation
import UIKit

protocol Transition {
    static func instantiate() -> Self
}

extension Transition where Self: UIViewController {
    static func instantiate() -> Self {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
}


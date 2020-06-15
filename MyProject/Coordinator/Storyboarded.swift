//
//  Storyboarded.swift
//  MyProject
//
//  Created by Dev on 11.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instatiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instatiate() -> Self {

        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

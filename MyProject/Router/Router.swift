//
//  Router.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

protocol RouterEvent {
    func push(to: UIViewController)
    func pop()
}

class Router: RouterEvent {

    var navigator: UINavigationController!
    var storyBoard = UIStoryboard(name: "Main", bundle: nil)

    init() {
        navigator = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }

    func push(to presentedVewController: UIViewController) {
        navigator.pushViewController(presentedVewController, animated: true)
    }

    func pop() {
        navigator.popViewController(animated: true)
    }
}

enum Controllers : String {
    case main = "MainViewController"
    case map = "MapViewController"
    case second = "SecondViewController"
}

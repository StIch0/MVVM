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
    func push(to: UIViewController, with animateNavifator: AnimateNavigator?)
    func present(to: UIViewController)
    func pop(with animateNavifator: AnimateNavigator?)
    func pushToRoot(rootViewController: UIViewController)
}

class Router: RouterEvent {

    var navigator: UINavigationController!
    var storyBoard = UIStoryboard(name: "Main", bundle: nil)

    init() {
        navigator = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        
    }



    func push(to controller: UIViewController, with animateNavifator: AnimateNavigator? = nil) {
        animateNavifator?.showPush()
        navigator.pushViewController(controller, animated: true)
    }

    func pop(with animateNavifator: AnimateNavigator? = nil) {
        animateNavifator?.showPop()
        navigator.popViewController(animated: animateNavifator == nil)
    }

    func pushToRoot(rootViewController: UIViewController) {
        navigator = nil
        navigator = UINavigationController(rootViewController: rootViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigator
    }

    func present(to controller: UIViewController) {
        navigator.present(controller, animated: true, completion: nil)
    }
}

enum Controllers : String {
    case main = "MainViewController"
    case map = "MapViewController"
    case second = "SecondViewController"
    case auth = "AuthViewController"
}

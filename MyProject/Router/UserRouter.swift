//
//  UserRouter.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class UserRouter: Router {

    func route(to routeId : Controllers, params: Any?) {
        switch routeId {
        case .map:
            let controller = storyBoard.create(with: routeId.rawValue, type: MapViewController.self)
            let mapViewModel = MapViewModel(user: params as! User)
            controller.mapViewModel = mapViewModel
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            let source = storyBoard.create(with: Controllers.main.rawValue, type: MainViewController.self)
//            source.present(controller, animated: true, completion: nil)
            source.performSegue(withIdentifier: "showMapViewController", sender: mapViewModel)
//            push(to: controller)
        case .second:
            let controller = storyBoard.create(with: routeId.rawValue, type: SecondViewController.self)
            let secondViewModel = SecondViewModel(switchValue: params as! Bool)
            controller.secondViewModel = secondViewModel
            push(to: controller)
        default:
            break
        }
    }
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigator.topViewController?.prepare(for: segue, sender: sender)
    }
}

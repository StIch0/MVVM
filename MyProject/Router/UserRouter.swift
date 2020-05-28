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
    unowned var userViewModel: UserViewModel!
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }

    func route(to routeId : Controllers, params: Any?) {
        switch routeId {
        case .map:
            let controller: MapViewController = storyBoard.instantiateViewController(withIdentifier: routeId.rawValue) as! MapViewController
            let mapViewModel = MapViewModel(user: params as! User)
            controller.mapViewModel = mapViewModel
            push(to: controller)
        case .second:
            let controller: SecondViewController = storyBoard.instantiateViewController(withIdentifier: routeId.rawValue) as! SecondViewController
            push(to: controller)
        default:
            break
        }
    }
}

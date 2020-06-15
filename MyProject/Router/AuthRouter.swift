//
//  AuthRouter.swift
//  MyProject
//
//  Created by Dev on 05.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter: Router {

    var viewModel: AuthViewModel!

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }

    func route(routeId: Controllers) {
        switch routeId {
        case .main:
//            if (viewModel.isValidEmail.value) {
                let controller = self.storyBoard.create(with: routeId.rawValue, type: MainViewController.self)
                pushToRoot(rootViewController: controller)
//            } else {
//                print("Email is not valid")
//            }
        default:
            break;
        }
    }
}

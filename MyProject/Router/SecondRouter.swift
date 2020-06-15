//
//  SecondRouter.swift
//  MyProject
//
//  Created by Dev on 04.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class SecondRouter: Router {
    
    func route(routeId: Controllers) {
        let controller =  self.storyBoard.create(with: routeId.rawValue, type: AuthViewController.self)
        pushToRoot(rootViewController: controller)
    }

}

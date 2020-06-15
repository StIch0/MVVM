//
//  MapRouter.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class MapRouter: Router {
    unowned var mapViewModel: MapViewModel!
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
    }

    func route(to routeId : Controllers, params: Any?) {
        switch routeId {
        case .main:
            let controller = self.storyBoard.create(with: routeId.rawValue, type: MainViewController.self)
            print("MapRouter::route \(params as! Int)")
            let userViewModel = UserViewModel(params as! Int)
            userViewModel.onNextSegment(params as! Int)
            controller.changeViewModel(userViewModel)
            pop(with: AnimateNavigator(navigator))
        default:
            break
        }
    }
}

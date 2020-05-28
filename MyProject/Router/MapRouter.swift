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
            pop()
        default:
            break
        }
    }
}

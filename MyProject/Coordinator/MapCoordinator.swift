//
//  MapCoordinator.swift
//  MyProject
//
//  Created by Dev on 11.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class MapCoordinator: MainCoordinator {

    func start(_ viewModel: MapViewModel) {
        let mapVC = MapViewController.instatiate()
        mapVC.coordinator = self
        mapVC.mapViewModel = viewModel
        self.childCoordinator.append(self)
        self.navigationController.pushViewController(mapVC, animated: true)
    }

    func showMain(selectedIndex: Int) {
        let mainVC = MainViewController.instatiate()
        let viewModel = UserViewModel()
        viewModel.onNextSegment(selectedIndex)
        mainVC.changeViewModel(viewModel)
        mainVC.coordinator = self
        navigationController.setViewControllers([mainVC], animated: true)
    }
}

//
//  MainCoordinator.swift
//  MyProject
//
//  Created by Dev on 11.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var childCoordinator: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainVC = MainViewController.instatiate()
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: true)
    }

    func showMap(with params: Any?) {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        let mapViewModel = MapViewModel(user: params as! User)
        mapCoordinator.start(mapViewModel)
    }

    func showMapModaly(with params: Any?) {
        let mapVC = MapViewController.instatiate()
        mapVC.modalPresentationStyle = .pageSheet
        let mapViewModel = MapViewModel(user: params as! User)
        mapVC.mapViewModel = mapViewModel
        navigationController.present(mapVC, animated: true, completion: nil)
    }

    func showSecondViewController(with params: Any?) {
        let secondVC = SecondViewController.instatiate()
        secondVC.secondViewModel = SecondViewModel(switchValue: params as! Bool)
        navigationController.pushViewController(secondVC, animated: true)
    }
}

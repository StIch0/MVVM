//
//  Coordinator.swift
//  MyProject
//
//  Created by Dev on 11.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

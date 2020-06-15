//
//  RootViewControllerRouter.swift
//  MyProject
//
//  Created by Dev on 01.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

class RootViewControllerRouter: Router {

    @available(iOS 13.0, *)
    func start(window: UIWindow) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { [weak self](credentialState, error) in
            guard let self = self else { return }
            switch credentialState {
            case .authorized:
                self.createRootVC(routeId: .main) {
                    navigator in
                    DispatchQueue.main.async {
                        window.rootViewController = navigator
                        window.makeKeyAndVisible()
                    }
                }
            case .notFound, .revoked:
                self.startAuth(window: window)
            default: break
            }
        }
    }

    func startAuth(window: UIWindow) {
        createRootVC(routeId: .auth) { (navigator) in
            DispatchQueue.main.async {
                window.rootViewController = navigator
                window.makeKeyAndVisible()
            }
        }
    }

    private func createRootVC(routeId: Controllers, complete: @escaping (_ controller: UINavigationController)->()) {
        switch routeId {
        case .main:
            showMain(route: routeId.rawValue, complete)
        case .auth:
            showAuth(route: routeId.rawValue, complete)
        default:
            break
        }
    }

    private func showMain(route: String, _ complete: @escaping (UINavigationController)->()) {
        DispatchQueue.main.async {
            let viewModel = UserViewModel()
            let controller =  self.storyBoard.create(with: route, type: MainViewController.self)
            controller.userViewModel = viewModel
            self.navigator = UINavigationController(rootViewController: controller)
            complete(self.navigator)
        }
    }

    private func showAuth(route: String, _ complete: @escaping (UINavigationController)->()) {
        DispatchQueue.main.async {
            let controller = self.storyBoard.create(with: route, type: AuthViewController.self)
            let navigator = UINavigationController(rootViewController: controller)
            complete(navigator)
        }
    }

}

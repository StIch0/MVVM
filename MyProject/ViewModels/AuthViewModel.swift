//
//  AuthViewModel.swift
//  MyProject
//
//  Created by Dev on 01.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AuthViewModel {

    var authRouter: AuthRouter!

    var loginTap: ControlEvent<Void>!
    var userEmail = BehaviorRelay<String>(value: "")
    var isValidEmail = BehaviorRelay<Bool>(value: false)

    init() {
        authRouter = AuthRouter(viewModel: self)
    }

    let disposeBag: DisposeBag = DisposeBag()

    func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        authRouter.route(routeId: .main)
    }

    func bindLoginButton(tap: ControlEvent<Void>) {
        loginTap = tap
        loginTap.bind {
            self.authRouter.route(routeId: .main)
        }.disposed(by: disposeBag)
    }
}

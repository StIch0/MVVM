//
//  SecondViewModel.swift
//  MyProject
//
//  Created by Dev on 04.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SecondViewModel {

    let disposeBag: DisposeBag = DisposeBag()

    var selectedIndex: BehaviorSubject<Int> = BehaviorSubject<Int>(value: 0)
    let aqiStandard: AnyObserver<Int>!

    var switchValue: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)

    typealias changeSwitchValue = ((Event) -> Void)?

    let sRouter = SecondRouter()

    var logoutTap: ControlEvent<Void>!

    var changeSegmentControlIndex: ((Event)->Void)!

    init(switchValue: Bool = false) {
        aqiStandard = selectedIndex.asObserver()
        self.switchValue.onNext(switchValue)

    }

    func bindTapLogoutButton(tap: ControlEvent<Void>) {
        self.logoutTap = tap
        self.logoutTap.bind {

//            KeychainItem.deleteUserIdentifierFromKeychain()
//            self.sRouter.route(routeId: .auth)
        }.disposed(by: disposeBag)
    }
}

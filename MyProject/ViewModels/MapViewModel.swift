//
//  MapViewModel.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MapViewModel {

    var backTap: ControlEvent<Void>!
    var disposeBag = DisposeBag()
    var user: User!

    var router: MapRouter!

    init(user: User) {
        self.user = user
        router = MapRouter(mapViewModel: self)
    }

    func bindBackButton(backTap: ControlEvent<Void>) {
        self.backTap = backTap
        self.backTap.bind {
            self.router.route(to: .main, params: nil)
        }.disposed(by: disposeBag)
    }
}

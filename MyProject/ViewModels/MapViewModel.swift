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

protocol MapViewModelType {
    var delegate: MapViewModelDelegate? { get }
}
protocol MapViewModelDelegate: class {
    func setIndex(index: Int)
}


class MapViewModel: MapViewModelType {

    var delegate: MapViewModelDelegate?

    var backTap: ControlEvent<Void>!
    var disposeBag = DisposeBag()
    var user: User!

    var router: MapRouter!

    var segmentIndex: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)

    func setSegmentIndex(_ index: Int) {
        segmentIndex.accept(index)
    }

    init(user: User) {
        self.user = user
        router = MapRouter(mapViewModel: self)
    }

    func bindBackButton(backTap: ControlEvent<Void>,_ showMainComplete: @escaping (Int)->()) {
        self.backTap = backTap
        self.backTap.bind {
            showMainComplete(self.segmentIndex.value)
        }.disposed(by: disposeBag)
    }
}

//
//  UserViewModel.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Event {
    case ChangeButtonTitleEvent(String)
    case GoToMap(Void)
 }

protocol API {
    func downloadUser(complete : @escaping DownloadComplete)
}

class UserViewModel {

    var apiClient : NetworkClient = NetworkClient()
    var users: BehaviorRelay<[User]> = BehaviorRelay(value: [])


    let showLoading = BehaviorRelay<Bool>(value: true)

    var singleTimeEvents: PublishSubject<Event>! = PublishSubject.init()

    let disposeBag: DisposeBag = DisposeBag()

    var router: UserRouter = UserRouter()

    var segmentIndex:ReplaySubject<Int> = ReplaySubject.create(bufferSize: 1)

    init(_ segmentIndex: Int = 0) {
//        router = UserRouter()
    }

    func onNextSegment(_ segmentIndex: Int) {
        print("UserViewModel::init \(segmentIndex)")
        self.segmentIndex.onNext(segmentIndex)
    }

    func onTitleClicked(title: String) {
        singleTimeEvents.onNext(Event.ChangeButtonTitleEvent(title))
    }
    func removeItem(at indexPath: IndexPath, _ complete: (IndexPath)->()) {
        var sections = users.value
        print(indexPath.row, sections[indexPath.row])
        sections.remove(at: indexPath.row)
        users.accept(sections)

        complete(indexPath)
    }




    func changetitle(buttonTitle: Binder<String?>) {
        singleTimeEvents.bind{ [weak self] event in
            guard let self = self else { return }
            switch event {
            case .ChangeButtonTitleEvent(let title):
                let name = BehaviorSubject<String?>(value: title)
                name.bind(to: buttonTitle).disposed(by: self.disposeBag)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }


    func getUsers (_ userLoadingComplete: @escaping (BehaviorRelay<[User]>)->()){
        showLoading.accept(true)
        self.apiClient.downloadUser {
            self.users = self.apiClient.users
            userLoadingComplete(self.users)
        }

    }

    func numberOfItemsToDisplay(in section: Int)-> Int {
        return self.users.value.count
    }
}

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

    var tap: ControlEvent<Void>!

    var tableViewSelected: ControlEvent<User>!
    var willDisplayCell: ControlEvent<WillDisplayCellEvent>!
    
    var singleTimeEvents: PublishSubject<Event>! = PublishSubject.init()

    let disposeBag: DisposeBag = DisposeBag()

    var router: UserRouter!

    init() {
        router = UserRouter(userViewModel: self)
    }

    func bindButtonTap(tap: ControlEvent<Void>) {
        self.tap = tap
        self.tap.bind {
            self.router.route(to: .second, params: nil)
        }.disposed(by: disposeBag)
    }

    func onTitleClicked(title: String) {
        singleTimeEvents.onNext(Event.ChangeButtonTitleEvent(title))
    }

    func bindTableView(tableViewSelected: ControlEvent<User>) {
        self.tableViewSelected = tableViewSelected
        /// event на нажатие
        self.tableViewSelected.map{  user -> String in
            self.router.route(to: .map, params: user)
            return user.name.first ?? ""
            }.bind{ [weak self] name in
            guard let self = self else { return }
                /// event на смену title
                self.onTitleClicked(title: name )
        }.disposed(by: disposeBag)
    }

    func bindWillDisplayCell(_ willDisplayCell: ControlEvent<WillDisplayCellEvent>!, completeAnimation: @escaping (_ event: WillDisplayCellEvent)->()) {
        willDisplayCell
        .subscribe(onNext: ({ (cell,indexPath) in
            completeAnimation((cell,indexPath))
        })).disposed(by: disposeBag)
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

    func getUsers (rxtableView: Reactive<UITableView>) {
        self.apiClient.downloadUser {
            self.users = self.apiClient.users
             self.users.bind(to:
             rxtableView.items(cellIdentifier: UserInfoCell.cellId)) { (row, model, cell: UserInfoCell) in
                let cellViewModel: UserCellViewModel =  UserCellViewModel(cell: cell)
                cellViewModel.configureUserInfoCell(model)

                }
                .disposed(by: self.disposeBag)
        }
    }

    func numberOfItemsToDisplay(in section: Int)-> Int {
        return self.users.value.count
    }
}
extension Reactive where Base: UIButton {

    /// Reactive wrapper for `setTitle(_:for:)`
    public func title(for controlState: UIControl.State = []) -> Binder<String?> {
        return Binder(self.base) { button, title -> Void in
            button.setTitle(title, for: controlState)
        }
    }

    /// Reactive wrapper for `setImage(_:for:)`
    public func image(for controlState: UIControl.State = []) -> Binder<UIImage?> {
        return Binder(self.base) { button, image -> Void in
            button.setImage(image, for: controlState)
        }
    }

    /// Reactive wrapper for `setBackgroundImage(_:for:)`
    public func backgroundImage(for controlState: UIControl.State = []) -> Binder<UIImage?> {
        return Binder(self.base) { button, image -> Void in
            button.setBackgroundImage(image, for: controlState)
        }
    }

}

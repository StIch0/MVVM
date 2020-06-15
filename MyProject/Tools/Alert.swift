//
//  Alert.swift
//  MyProject
//
//  Created by Dev on 08.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class Alert {

    private var title: String!
    private var message: String!
    private var controller: UIViewController!
    private let disposeBag: DisposeBag = DisposeBag()   

    init(_ controller: UIViewController, title: String, message: String) {
        self.title = title
        self.message = message
        self.controller = controller
    }

     func show(with actions: [UIAlertController.AlertAction] = [
        .action(title: "no", style: .destructive),
        .action(title: "yes")
    ]) {
        UIAlertController
            .present(in: controller, title: title, message: message, style: .alert, actions: actions)
        .subscribe(onNext: { buttonIndex in
            print(buttonIndex)
        })
        .disposed(by: disposeBag)
    }

}

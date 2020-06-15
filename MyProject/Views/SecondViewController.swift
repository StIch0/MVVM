//
//  SecondViewController.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
import RxCocoa
import RxSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var switchElement: UISwitch!
    @IBOutlet weak var logoutButton: UIButton!

    @IBOutlet weak var segmentControl: UISegmentedControl!
    let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    let remoteSettings: RemoteConfigSettings = RemoteConfigSettings()

    let disposeBag: DisposeBag = DisposeBag()

    var secondViewModel: SecondViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let rigthButton = UIBarButtonItem(
                    title: "Logout",
                    style: .done,
                    target: nil,
                    action: nil
                );

        self.navigationItem.setRightBarButton(rigthButton, animated: true)

        secondViewModel.bindTapLogoutButton(tap: rigthButton.rx.tap)

        secondViewModel
            .switchValue
            .asObserver()
            .subscribe(onNext: { (value) in
                self.switchElement
                .rx
                .isOn
                .onNext(value)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)

//        switchElement
//            .rx
//            .isOn
//            .subscribe(secondViewModel.switchValue)
//            .disposed(by: disposeBag)
//
//        switchElement
//            .rx
//            .isOn
//            .changed
//            .distinctUntilChanged()
//            .share(replay: 1, scope: .forever)
//            .subscribe(secondViewModel.switchValue)
//            .disposed(by: disposeBag)

        segmentControl
            .rx
            .selectedSegmentIndex
            .bind(to: secondViewModel.selectedIndex)
//            .subscribe(svm.aqiStandard)
            .disposed(by: disposeBag)

        logoutButton.addTarget(self, action: #selector(press(_:)), for: .touchDown)
        

    }
    @objc func press (_ sender: Any?) {
        secondViewModel.switchValue.onNext(false)
        print(try? secondViewModel.switchValue.value())
    }
}

extension SecondViewController: Storyboarded {
    
}

//
//  ViewController.swift
//  MyProject
//
//  Created by Dev on 31/07/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, UIScrollViewDelegate {


    //MARK: Coordinator
    weak var coordinator: MainCoordinator?

    let disposeBag: DisposeBag = DisposeBag()

    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var buton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    var userViewModel: UserViewModel = UserViewModel()

    func changeViewModel(_ vm: UserViewModel){
        self.userViewModel = vm;
        vm.segmentIndex.subscribe { segment in
            self.view.backgroundColor = MainScreenColorManager().arrayOfColor[segment.element!]
        }.disposed(by: disposeBag)
    }


    func bindViewModel() {
        /// подгрузка данных
        dowloadUserData()

        /// обработка нажатия на кнопку
        self.buton.rx.tap.bind {
            self.coordinator?.showSecondViewController(with: true)
        }.disposed(by: disposeBag)

        /// обработка удаления ячейки
        tableView.rx.itemDeleted.subscribe {
            guard let indexPath = $0.element else { return }
            self.userViewModel.removeItem(at: indexPath) { (indexPath) in
                
            }
        }.disposed(by: disposeBag)

        /// обработка нажатия на ячейку
        tableView.rx.modelSelected(User.self).subscribe {
            user in
            self.coordinator?.showMap(with: user.element)
        }.disposed(by: disposeBag)

        /// смена title кнопки по нажати/ на ячейку
        userViewModel.changetitle(buttonTitle: self.buton.rx.title())

        userViewModel.showLoading.asObservable().observeOn(MainScheduler.instance).bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)



    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.delegate = nil
        tableView.dataSource = nil

        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.frame = CGRect(origin: view.center, size: CGSize(width: 30, height: 30))
        activityIndicator.hidesWhenStopped = true
        self.userViewModel.showLoading.accept(false)

        view.addSubview(activityIndicator)

        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        tableView.addGestureRecognizer(longPressGesture)

        bindViewModel()

        tableView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: UserInfoCell.cellId)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        /// Анимация ячеек
        tableView.rx.willDisplayCell.subscribe(onNext: { (cell, indexPath) in
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }).disposed(by: disposeBag)

    }


    func dowloadUserData() {
        userViewModel.getUsers { (users) in
            users.bind(to:
            self.tableView.rx.items(cellIdentifier: UserInfoCell.cellId)) { (row, model, cell: UserInfoCell) in
                self.userViewModel.showLoading.accept(false)
               let cellViewModel: UserCellViewModel =  UserCellViewModel(cell: cell)
               cellViewModel.configureUserInfoCell(model)
               }
               .disposed(by: self.disposeBag)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.tableView.delegate = nil
    }
}
extension MainViewController: UITableViewDelegate {

   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteButton = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        return [deleteButton]
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    @objc func handleLongPress(_ longPressGesture:UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        }
        else if (longPressGesture.state == .began) {
            coordinator?.showMapModaly(with: userViewModel.users.value[indexPath!.row])
            print("Long press on row, at \(indexPath!.row)")
        }
    }
}

extension MainViewController: Storyboarded {

}

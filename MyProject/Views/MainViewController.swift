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

class MainViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var buton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    var userViewModel: UserViewModel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil

        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserInfoCell.cellId)

        userViewModel = UserViewModel()

        /// подгрузка данных
        dowloadUserData()

        /// Анимация ячеек
        userViewModel.bindWillDisplayCell(tableView.rx.willDisplayCell) { (cell, indexPath) in
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }

        /// обработка нажатия на кнопку
        userViewModel.bindButtonTap(tap: self.buton.rx.tap)

        /// обработка нажатия на ячейку
        userViewModel.bindTableView(tableViewSelected: tableView.rx.modelSelected(User.self))

        /// смена title кнопки по нажати/ на ячейку
        userViewModel.changetitle(buttonTitle: self.buton.rx.title())

    }

    func dowloadUserData() {
        /// complete
        self.userViewModel.getUsers(rxtableView: tableView.rx)
    }
}

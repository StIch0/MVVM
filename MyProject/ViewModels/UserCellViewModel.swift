//
//  UserCellViewModel.swift
//  MyProject
//
//  Created by Dev on 21.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation


class UserCellViewModel {

    var cell: UserInfoCell!

    init(cell: UserInfoCell!) {
        self.cell = cell
    }
    func configureUserInfoCell(_ user: User) {
        let url: URL = URL(string:user.picture.medium)!
        cell.userImage.load(url: url)
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2
        cell.userImage.layer.borderWidth = 1
        cell.userName.text = "\(user.name.title ?? "") \(user.name.first ?? "")"
        cell.userSecondName.text = user.name.last
    }
}

//
//  UserInfoCell.swift
//  MyProject
//
//  Created by Dev on 08/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import UIKit

class UserInfoCell: UITableViewCell {

    static let cellId: String = "cellId"

    private let nibName: String = "UserCell"

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSecondName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: UserInfoCell.cellId)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

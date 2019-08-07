//
//  UserViewModel.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
class UserViewModel : NSObject {
    var apiClient : NetworkClient = NetworkClient()
    var users = [User]()
    func getUsers (_ complete: @escaping DownloadComplete) {
        self.apiClient.downloadUser {
            self.users = self.apiClient.users
            complete()
        }
    }
    func numberOfItemsToDisplay(in section: Int)-> Int{
        return users.count
    }
}
